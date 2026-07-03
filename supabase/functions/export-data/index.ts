// Export des données (droit à la portabilité — gratuit, in-app).
// S'exécute avec le JWT de l'appelant : la RLS garantit qu'il ne lit
// que SES données. Produit un JSON structuré dans le bucket `exports`
// et retourne une URL signée 1 h. Les médias sont listés avec des URL
// signées incluses dans le JSON (pas d'archive binaire en V1).
import { adminClient, json, userClient } from "../_shared/mod.ts";

const TABLES = [
  "relationships", "preferences", "interactions", "interaction_participants",
  "memories", "media_assets", "albums", "important_dates", "events",
  "promises", "notifications", "presence_scores", "settings",
] as const;

Deno.serve(async (req) => {
  const caller = userClient(req);
  const { data: auth } = await caller.auth.getUser();
  if (!auth?.user) return json({ error: "non authentifié" }, 401);
  const uid = auth.user.id;

  const payload: Record<string, unknown> = {
    format: "amiora-export/1",
    exported_at: new Date().toISOString(),
    user: { id: uid, email: auth.user.email },
  };
  for (const t of TABLES) {
    const { data, error } = await caller.from(t).select("*");
    if (error) return json({ error: `${t}: ${error.message}` }, 500);
    payload[t] = data;
  }

  // URL signées des médias (24 h) incluses dans l'export.
  const admin = adminClient();
  const media = (payload["media_assets"] as { storage_path?: string }[]) ?? [];
  for (const m of media) {
    if (!m.storage_path) continue;
    const { data } = await admin.storage.from("media-photos")
      .createSignedUrl(m.storage_path, 86400);
    (m as Record<string, unknown>).signed_url = data?.signedUrl ?? null;
  }

  const path = `${uid}/export-${new Date().toISOString().slice(0, 10)}.json`;
  const { error: upErr } = await admin.storage.from("exports").upload(
    path,
    new Blob([JSON.stringify(payload, null, 2)], { type: "application/json" }),
    { upsert: true },
  );
  if (upErr) return json({ error: upErr.message }, 500);

  const { data: signed, error: sErr } = await admin.storage.from("exports")
    .createSignedUrl(path, 3600);
  if (sErr) return json({ error: sErr.message }, 500);
  return json({ ok: true, url: signed.signedUrl, expires_in: 3600 });
});
