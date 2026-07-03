// Webhook RevenueCat : met à jour `subscriptions` (source de vérité du
// droit d'accès). Le mode lecture seule découle de `expires_at` — imposé
// par les politiques d'écriture côté base et vérifié par le client.
// Secret requis : RC_WEBHOOK_SECRET (en-tête Authorization du webhook).
import { adminClient, checkSharedSecret, json } from "../_shared/mod.ts";

const HANDLED = new Set([
  "INITIAL_PURCHASE",
  "RENEWAL",
  "PRODUCT_CHANGE",
  "CANCELLATION",
  "UNCANCELLATION",
  "EXPIRATION",
  "BILLING_ISSUE",
]);

Deno.serve(async (req) => {
  if (!checkSharedSecret(req, "RC_WEBHOOK_SECRET")) {
    return json({ error: "non autorisé" }, 401);
  }
  const { event } = await req.json();
  if (!event || !HANDLED.has(event.type)) return json({ ignored: true });

  const userId = event.app_user_id as string; // = auth.users.id (configuré côté app)
  const expiresAtMs = event.expiration_at_ms as number | null;
  const status =
    event.type === "EXPIRATION" ? "expired"
    : event.type === "BILLING_ISSUE" ? "billing_issue"
    : event.type === "CANCELLATION" ? "cancelled"
    : "active";

  const db = adminClient();
  const { error } = await db.from("subscriptions").upsert({
    user_id: userId,
    entitlement: "premium",
    status,
    store: event.store ?? null,
    product_id: event.product_id ?? null,
    expires_at: expiresAtMs ? new Date(expiresAtMs).toISOString() : null,
    updated_at: new Date().toISOString(),
  }, { onConflict: "user_id" });

  if (error) return json({ error: error.message }, 500);
  return json({ ok: true });
});
