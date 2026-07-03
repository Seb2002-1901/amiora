// Suppression de compte (exigence stores + nLPD/RGPD) : marque le compte
// pour suppression, révoque les sessions ; la purge effective (données +
// Storage) est faite par `purge-deleted` après le délai de grâce de
// 30 jours, pendant lequel l'utilisateur peut annuler en se reconnectant
// via le parcours « Annuler la suppression ».
import { adminClient, json, userClient } from "../_shared/mod.ts";

Deno.serve(async (req) => {
  const caller = userClient(req);
  const { data: auth } = await caller.auth.getUser();
  if (!auth?.user) return json({ error: "non authentifié" }, 401);

  const db = adminClient();
  const now = new Date().toISOString();
  const { error } = await db
    .from("users")
    .update({ deleted_at: now })
    .eq("id", auth.user.id);
  if (error) return json({ error: error.message }, 500);

  // Révoque toutes les sessions de l'utilisateur.
  await db.auth.admin.signOut(auth.user.id, "global");
  return json({ ok: true, purge_after_days: 30 });
});
