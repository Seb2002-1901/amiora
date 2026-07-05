// Moteur de notifications quotidien (cron HORAIRE — voir README).
// À chaque passage : sélectionne les utilisateurs dont l'heure locale est
// 09:00, construit les candidates, applique priorités et plafonds
// (2/jour, 6/semaine — PRD V1.2), heures silencieuses 22 h-8 h, puis
// envoie via FCM et journalise dans `notifications`.
// Jamais de notification pour une relation archivée ou en mémoire.
// Secrets requis : FCM_SERVICE_ACCOUNT_JSON (compte de service Firebase).
import { adminClient, json } from "../_shared/mod.ts";

type Candidate = {
  userId: string;
  relationshipId: string | null;
  kind: "birthday_today" | "promise_due" | "birthday_soon" | "attention";
  title: string;
  body: string;
  priority: number; // 1 = plus haut
};

const MAX_PER_DAY = 2;
const MAX_PER_WEEK = 6;

Deno.serve(async (_req) => {
  const db = adminClient();
  const nowUtc = new Date();

  // Utilisateurs dont l'heure locale ≈ 09:00 (les réglages portent le fuseau).
  const { data: users, error: uErr } = await db
    .from("settings")
    .select("user_id, extra, notifications_enabled")
    .eq("notifications_enabled", true);
  if (uErr) return json({ error: uErr.message }, 500);

  let sent = 0;
  for (const u of users ?? []) {
    const localHour = localHourFor(u.extra, nowUtc);
    if (localHour !== 9) continue; // 9 h locale (hors heures silencieuses par construction)

    const candidates = await buildCandidates(db, u.user_id);
    if (!candidates.length) continue;

    // Plafonds : journal des 7 derniers jours.
    const since = new Date(nowUtc.getTime() - 7 * 864e5).toISOString();
    const { data: recent } = await db
      .from("notifications")
      .select("id, sent_at")
      .eq("user_id", u.user_id)
      .gte("sent_at", since);
    const today = nowUtc.toISOString().slice(0, 10);
    const sentToday = (recent ?? []).filter((n) => n.sent_at?.startsWith(today)).length;
    const budget = Math.min(MAX_PER_DAY - sentToday, MAX_PER_WEEK - (recent?.length ?? 0));
    if (budget <= 0) continue;

    candidates.sort((a, b) => a.priority - b.priority);
    for (const c of candidates.slice(0, budget)) {
      await sendPush(db, c);
      sent++;
    }
  }
  return json({ ok: true, sent });
});

// Heure locale de l'utilisateur : identifiant IANA si l'app en a fourni un
// (contient '/'), sinon décalage en minutes (tz_offset_min, envoyé quand le
// client ne connaît qu'une abréviation type « CEST »), sinon Europe/Zurich.
function localHourFor(
  extra: { timezone?: string; tz_offset_min?: number } | null,
  at: Date,
): number {
  const tz = extra?.timezone;
  if (typeof tz === "string" && tz.includes("/")) {
    try {
      return hourIn(tz, at);
    } catch {
      // Identifiant inconnu du runtime : repli ci-dessous.
    }
  }
  if (typeof extra?.tz_offset_min === "number") {
    return new Date(at.getTime() + extra.tz_offset_min * 60_000).getUTCHours();
  }
  return hourIn("Europe/Zurich", at);
}

function hourIn(timezone: string, at: Date): number {
  return Number(
    new Intl.DateTimeFormat("fr-CH", { timeZone: timezone, hour: "2-digit", hour12: false })
      .format(at),
  );
}

async function buildCandidates(db: ReturnType<typeof adminClient>, userId: string): Promise<Candidate[]> {
  const out: Candidate[] = [];
  const today = new Date();

  // Relations actives uniquement (jamais archived / in_memoriam).
  const { data: rels } = await db
    .from("relationships")
    .select("id, first_name, cadence_days, status, deleted_at")
    .eq("user_id", userId)
    .eq("status", "active")
    .is("deleted_at", null);

  const { data: dates } = await db
    .from("important_dates")
    .select("relationship_id, type, date, recurs_annually")
    .eq("user_id", userId)
    .is("deleted_at", null);

  for (const d of dates ?? []) {
    const rel = (rels ?? []).find((r) => r.id === d.relationship_id);
    if (!rel) continue;
    const days = daysUntilOccurrence(new Date(d.date), d.recurs_annually, today);
    if (days === 0) {
      out.push({
        userId, relationshipId: rel.id, kind: "birthday_today", priority: 1,
        title: "Aujourd'hui compte",
        body: `C'est un jour important pour ${rel.first_name}.`,
      });
    } else if (days === 3 || days === 7) {
      out.push({
        userId, relationshipId: rel.id, kind: "birthday_soon", priority: 3,
        title: "À venir",
        body: `L'anniversaire de ${rel.first_name} approche.`,
      });
    }
  }

  const { data: promises } = await db
    .from("promises")
    .select("id, relationship_id, title, due_date, status")
    .eq("user_id", userId)
    .neq("status", "done")
    .is("deleted_at", null)
    .lte("due_date", today.toISOString());
  for (const p of promises ?? []) {
    const rel = (rels ?? []).find((r) => r.id === p.relationship_id);
    out.push({
      userId, relationshipId: p.relationship_id, kind: "promise_due", priority: 2,
      title: "Une promesse t'attend",
      body: rel ? `Tu avais prévu quelque chose avec ${rel.first_name}.` : "Tu avais prévu quelque chose.",
    });
  }

  // « Relation à entretenir » : dernière interaction > 2 × cadence.
  // Ton bienveillant, jamais de compteur de jours en push (PRD V1.2).
  const { data: lastInteractions } = await db.rpc("last_interaction_by_relationship", {
    p_user_id: userId,
  });
  for (const li of lastInteractions ?? []) {
    const rel = (rels ?? []).find((r) => r.id === li.relationship_id);
    if (!rel) continue;
    const daysSince = Math.floor((today.getTime() - new Date(li.last_at).getTime()) / 864e5);
    if (daysSince >= 2 * (rel.cadence_days ?? 30)) {
      out.push({
        userId, relationshipId: rel.id, kind: "attention", priority: 4,
        title: "Une petite attention ?",
        body: `Cela fait quelque temps — ${rel.first_name} serait sûrement heureux d'avoir de tes nouvelles.`,
      });
    }
  }
  return out;
}

function daysUntilOccurrence(base: Date, recurs: boolean, today: Date): number {
  const t = new Date(today.getFullYear(), today.getMonth(), today.getDate());
  let occ = recurs
    ? new Date(t.getFullYear(), base.getMonth(), base.getDate())
    : new Date(base.getFullYear(), base.getMonth(), base.getDate());
  if (recurs && occ < t) occ = new Date(t.getFullYear() + 1, base.getMonth(), base.getDate());
  return Math.round((occ.getTime() - t.getTime()) / 864e5);
}

async function sendPush(db: ReturnType<typeof adminClient>, c: Candidate) {
  // Jetons d'appareils de l'utilisateur.
  const { data: devices } = await db
    .from("devices")
    .select("push_token")
    .eq("user_id", c.userId)
    .not("push_token", "is", null);

  for (const d of devices ?? []) {
    await sendFcm(d.push_token, c.title, c.body).catch((e) =>
      console.error("fcm", c.kind, String(e)),
    );
  }
  await db.from("notifications").insert({
    user_id: c.userId,
    relationship_id: c.relationshipId,
    kind: c.kind,
    title: c.title,
    body: c.body,
    sent_at: new Date().toISOString(),
  });
}

/** Envoi FCM HTTP v1 (jeton OAuth du compte de service). */
async function sendFcm(token: string, title: string, body: string) {
  const sa = JSON.parse(Deno.env.get("FCM_SERVICE_ACCOUNT_JSON") ?? "");
  const accessToken = await googleAccessToken(sa);
  const res = await fetch(
    `https://fcm.googleapis.com/v1/projects/${sa.project_id}/messages:send`,
    {
      method: "POST",
      headers: { Authorization: `Bearer ${accessToken}`, "Content-Type": "application/json" },
      body: JSON.stringify({
        message: { token, notification: { title, body } },
      }),
    },
  );
  if (!res.ok) throw new Error(`FCM ${res.status}: ${await res.text()}`);
}

/** Jeton OAuth 2.0 signé RS256 pour le compte de service Firebase. */
async function googleAccessToken(sa: { client_email: string; private_key: string }): Promise<string> {
  const now = Math.floor(Date.now() / 1000);
  const header = b64url(JSON.stringify({ alg: "RS256", typ: "JWT" }));
  const claims = b64url(JSON.stringify({
    iss: sa.client_email,
    scope: "https://www.googleapis.com/auth/firebase.messaging",
    aud: "https://oauth2.googleapis.com/token",
    iat: now,
    exp: now + 3600,
  }));
  const input = `${header}.${claims}`;
  const key = await crypto.subtle.importKey(
    "pkcs8", pemToDer(sa.private_key),
    { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" }, false, ["sign"],
  );
  const sig = await crypto.subtle.sign("RSASSA-PKCS1-v1_5", key, new TextEncoder().encode(input));
  const jwt = `${input}.${b64url(sig)}`;
  const res = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: `grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion=${jwt}`,
  });
  const data = await res.json();
  if (!data.access_token) throw new Error("OAuth Google: jeton absent");
  return data.access_token;
}

function b64url(data: string | ArrayBuffer): string {
  const bytes = typeof data === "string" ? new TextEncoder().encode(data) : new Uint8Array(data);
  let bin = "";
  for (const b of bytes) bin += String.fromCharCode(b);
  return btoa(bin).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
}

function pemToDer(pem: string): ArrayBuffer {
  const b64 = pem.replace(/-----[^-]+-----/g, "").replace(/\s+/g, "");
  const bin = atob(b64);
  const bytes = new Uint8Array(bin.length);
  for (let i = 0; i < bin.length; i++) bytes[i] = bin.charCodeAt(i);
  return bytes.buffer;
}
