# Couche domaine

Règles :

1. **Dart pur** — aucune dépendance Flutter, Drift ou Supabase ici.
2. La formule de l'Indice de présence (`presence/presence_score.dart`)
   implémente le contrat `docs/sprint-0/01-indice-de-presence.md` ;
   ses vecteurs de test (`test/presence_score_test.dart`) font foi.
   Toute évolution passe par une révision du livrable, puis du code,
   puis des tests — dans cet ordre.
3. Les entités sont immuables ; la persistance vit dans `lib/data/`.
