# AMIORA — Décisions finales avant développement (V1.1)

* **Statut :** pré-développement.
* **Date :** juillet 2026.
* **Objectif :** figer définitivement le produit avant d'écrire du code.

> Ce document amende et complète la [Spécification de référence V1.0](specification-de-reference-v1.0.md). En cas de conflit, les décisions ci-dessous prévalent.

---

## Décision 1 — Paiements

**Décision officielle :**

* **iOS :** StoreKit + RevenueCat.
* **Android :** Google Play Billing + RevenueCat.

**Interdiction** — ne pas utiliser pour les abonnements numériques :

* ❌ Stripe
* ❌ TWINT
* ❌ Apple Pay

**Autorisé plus tard** — Stripe et TWINT pourront être utilisés uniquement pour : livre photo imprimé ; objets physiques ; produits dérivés.

## Décision 2 — MVP réel

Le MVP actuel est trop gros. Objectif : sortir rapidement, valider le marché, apprendre.

### MVP V1

* **Authentification :** Apple, Google, Email.
* **Relations :** créer, modifier, supprimer ; catégories ; photo ; dates importantes ; préférences ; notes.
* **Interactions** (fonction centrale) — types : appel, message, repas, sortie, voyage, visite, cadeau, moment ensemble, photo, événement.
* **Souvenirs :** photos, notes, albums.
* **Calendrier :** anniversaires, promesses, sorties, dates importantes.
* **Notifications :** anniversaires, rappels, relations à entretenir.
* **Indice de présence :** privé, visible uniquement par l'utilisateur.
* **En mémoire :** archiver une relation en conservant photos, souvenirs, chronologie, notes.

### V1.1

Capsules temporelles · Bucket Lists · Statistiques avancées · Badges · Défis · Widgets.

### V1.2

Album annuel PDF · Partage familial · Livre imprimé.

## Décision 3 — Fonction principale

L'application tourne autour d'un seul geste : **Ajouter une interaction**.

Si cette fonctionnalité est mauvaise, AMIORA échoue.

**Écran « Ajouter interaction » :** type, date, durée, qualité, notes, photos, lieu, personnes.

**Temps maximum : moins de 10 secondes.** L'utilisateur doit pouvoir enregistrer un moment extrêmement rapidement.

## Décision 4 — Indice de présence

* **Nom officiel :** Indice de présence.
* **Échelle :** 0-100.

**Variables et pondérations :**

| Variable | Poids |
|---|---|
| Dernière interaction | 35 % |
| Régularité | 25 % |
| Temps passé ensemble | 15 % |
| Promesses | 10 % |
| Souvenirs | 10 % |
| Dates importantes | 5 % |

**Affichage :**

| Plage | Libellé |
|---|---|
| 90-100 | Très entretenue |
| 75-89 | Bien entretenue |
| 50-74 | À entretenir |
| 0-49 | Peu entretenue |

**Jamais :** « toxique », « mauvaise relation », « dangereuse ».

## Décision 5 — Notifications

**Ton :** bienveillant. Jamais culpabilisant.

**Exemples autorisés :**

* « Cela fait quelque temps que vous n'avez pas pris de nouvelles de Thomas. »
* « Une petite attention pourrait faire plaisir à papa. »
* « L'anniversaire de Julie approche. »
* « Vous aviez parlé d'un restaurant avec Emma. »

**Interdit :**

* « Vous négligez vos proches. »
* « Votre relation est en danger. »
* « Vous êtes un mauvais ami. »

## Décision 6 — Sauvegarde

* Sauvegarde : 100 % gratuite.
* Export : 100 % gratuit.
* Suppression : 100 % gratuite.
* Récupération : 100 % gratuite.

**Ne jamais bloquer l'accès aux souvenirs créés.**

## Décision 7 — Confidentialité

* Les données sont privées.
* Aucun partage automatique.
* Aucune donnée médicale.
* Aucune donnée sensible.
* Aucun accès par les proches.
* Aucun score partagé.

## Décision 8 — Fonction « Souvenir du jour »

**Conserver.** C'est probablement l'une des meilleures fonctionnalités de rétention.

Exemple : « Il y a exactement trois ans, vous étiez à Rome avec Emma. »

## Décision 9 — Fonction « En mémoire »

**Conserver.** Très forte valeur émotionnelle.

Mode : 🕊️ En mémoire — la relation est archivée, aucune notification, historique conservé.

## Décision 10 — Base de données définitive

Users · Relationships · RelationshipCategories · Interactions · Memories · Photos · Notes · Events · Promises · Notifications · Subscriptions · Achievements · Settings.

## Architecture recommandée

* **Application :** Flutter.
* **Backend :** Supabase.
* **Base :** PostgreSQL.
* **Stockage :** Supabase Storage.
* **Notifications :** Firebase.
* **Paiements :** RevenueCat, StoreKit, Google Play Billing.

## Design system

* **Fond :** noir profond.
* **Cartes :** anthracite.
* **Accent :** or premium.
* **Coins :** 24 px.
* **Animations :** fluides. Grandes photos. Approche émotionnelle.

## KPI de lancement

Inscriptions · relations créées · interactions créées · souvenirs créés · rétention J7 · rétention J30 · conversion Premium · churn.

## Hypothèse à valider

**Question principale :** les utilisateurs reviennent-ils naturellement au moins une fois par semaine ?

Si la réponse est non : revoir les notifications, renforcer les souvenirs, renforcer les rappels, ajouter davantage de valeur émotionnelle.

## Définition du succès

L'utilisateur pense : « Cette application contient une partie de mon histoire et m'aide à prendre soin des personnes qui comptent. »

## GO / NO GO

Développement autorisé uniquement lorsque :

* ✅ Paiements figés
* ✅ MVP figé
* ✅ Indice de présence figé
* ✅ Notifications figées
* ✅ Modèle de données figé
* ✅ Design system figé
* ✅ Parcours utilisateur figé
* ✅ Fonction « Ajouter une interaction » conçue et validée
