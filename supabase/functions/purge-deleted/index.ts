// Purge quotidienne (cron) : suppression PHYSIQUE des données effacées
// logiquement depuis plus de 30 jours, et des comptes marqués pour
// suppression depuis plus de 30 jours (données + fichiers Storage).
// La purge SQL détaillée vit en base (fonction purge_soft_deleted(),
// migration initiale) — cette fonction l'orchestre et nettoie Storage.
import { adminClient, json } from "../_shared/mod.ts";

Deno.serve(async (_req) => {
  const db = adminClient();

  // 1. Purge SQL des lignes soft-deleted > 30 jours (ordre FK en base).
  const { error: purgeErr } = await db.rpc("purge_soft_deleted", { p_grace_days: 30 });
  if (purgeErr) return json({ error: purgeErr.message }, 500);

  // 2. Comptes marqués pour suppression > 30 jours : Storage puis auth.
  const cutoff = new Date(Date.now() - 30 * 864e5).toISOString();
  const { data: users, error: uErr } = await db
    .from("users").select("id").not("deleted_at", "is", null).lt("deleted_at", cutoff);
  if (uErr) return json({ error: uErr.message }, 500);

  let purgedUsers = 0;
  for (const u of users ?? []) {
    for (const bucket of ["media-photos", "media-thumbnails", "exports", "avatars"]) {
      const { data: files } = await db.storage.from(bucket).list(u.id, { limit: 1000 });
      if (files?.length) {
        await db.storage.from(bucket).remove(files.map((f) => `${u.id}/${f.name}`));
      }
    }
    await db.auth.admin.deleteUser(u.id); // cascade SQL via FK users.id
    purgedUsers++;
  }
  return json({ ok: true, purged_users: purgedUsers });
});
