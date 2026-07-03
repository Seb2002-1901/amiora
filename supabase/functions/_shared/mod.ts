// Utilitaires partagés des Edge Functions AMIORA.
// Référence : docs/sprint-0/06-architecture-supabase.md.
import { createClient, SupabaseClient } from "jsr:@supabase/supabase-js@2";

/** Client service (RLS contournée) — réservé aux fonctions serveur. */
export function adminClient(): SupabaseClient {
  const url = Deno.env.get("SUPABASE_URL");
  const key = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  if (!url || !key) throw new Error("SUPABASE_URL / SUPABASE_SERVICE_ROLE_KEY manquants");
  return createClient(url, key, { auth: { persistSession: false } });
}

/** Client au nom de l'appelant (RLS appliquée) — pour export/suppression. */
export function userClient(req: Request): SupabaseClient {
  const url = Deno.env.get("SUPABASE_URL");
  const anon = Deno.env.get("SUPABASE_ANON_KEY");
  const auth = req.headers.get("Authorization") ?? "";
  if (!url || !anon) throw new Error("SUPABASE_URL / SUPABASE_ANON_KEY manquants");
  return createClient(url, anon, {
    global: { headers: { Authorization: auth } },
    auth: { persistSession: false },
  });
}

export function json(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json" },
  });
}

/** Vérifie un secret partagé (webhooks). Comparaison naïve suffisante ici. */
export function checkSharedSecret(req: Request, envVar: string): boolean {
  const expected = Deno.env.get(envVar);
  const got = req.headers.get("Authorization")?.replace(/^Bearer\s+/i, "");
  return Boolean(expected) && got === expected;
}
