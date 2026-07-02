# AMIORA — Product Requirements Document Final (V1.2)

* **Statut : GO DÉVELOPPEMENT**
* **Date :** juillet 2026

> Ce PRD est le document de référence actif du produit. Il consolide et remplace la [Spécification de référence V1.0](specification-de-reference-v1.0.md) et les [Décisions finales V1.1](decisions-finales-v1.1.md), conservées comme historique des décisions.

---

## Mission

AMIORA aide les utilisateurs à prendre soin des personnes qui comptent le plus dans leur vie et à préserver leurs souvenirs.

L'application n'est pas un réseau social, une messagerie ou un carnet de contacts.

AMIORA est :

* un gestionnaire de relations humaines ;
* un journal de souvenirs ;
* un organisateur relationnel ;
* un album de vie.

## Promesse

« Prends soin des personnes qui comptent. »

## Positionnement

Application premium. Approche émotionnelle. Confidentielle. Bienveillante.

Sans publicité. Sans partage automatique. Sans réseau social.

## Objectif principal

Créer une habitude positive permettant aux utilisateurs de :

* passer davantage de temps avec leurs proches ;
* créer davantage de souvenirs ;
* maintenir le lien avec les personnes importantes ;
* conserver l'histoire de leurs relations.

## Public cible

**25-45 ans.** Sous-cibles : couples, familles, parents, amitiés longue distance, jeunes actifs, entrepreneurs.

---

## Fonction centrale

Toute l'application est construite autour d'une action : **AJOUTER UNE INTERACTION**.

Cette action est le cœur du produit. Toutes les statistiques, rappels, souvenirs et indices dépendent de cette action.

### Types d'interactions

Appel · Message · Repas · Sortie · Voyage · Visite · Cadeau · Moment ensemble · Photo souvenir · Événement important.

### Écran « Ajouter une interaction »

**Temps de complétion cible : moins de 10 secondes.**

* **Obligatoire :** personne · type.
* **Facultatif :** date · durée · qualité · lieu · photo · note.

### Flow

Accueil → bouton + → sélection de la personne → sélection du type → Enregistrer → confirmation.

---

## Fonctionnalités V1

### Authentification

Connexion Apple · Connexion Google · Connexion Email · Mot de passe oublié · Suppression du compte · Déconnexion.

### Relations

Créer · Modifier · Supprimer · **Archiver**.

**Informations d'une relation :** photo, prénom, nom, catégorie, date de naissance, téléphone, email, adresse (facultative), métier (facultatif), notes.

**Catégories :** Partenaire · Famille · Amis · Enfants · Mentor · Professionnel · Autres.

**Préférences :** restaurants, loisirs, films, musique, couleurs, fleurs, parfums, idées cadeaux, notes diverses.

**Dates importantes :** anniversaire, première rencontre, premier rendez-vous, mariage, fiançailles, naissance, diplôme, événement personnalisé.

### Souvenirs

Photos · Notes · Albums · Chronologie.

### Ligne de vie

Chronologie automatique : première rencontre, voyages, anniversaires, événements, promesses, souvenirs.

### Promesses

Créer · Modifier · Terminer · Supprimer.

**États :** à faire · en cours · terminée.

### Calendrier

Vues : jour, semaine, mois.

**Événements affichés :** anniversaires, promesses, sorties, voyages, dates importantes.

---

## Notifications

**Ton :** bienveillant. Jamais culpabilisant.

**Exemples :**

* « Une petite attention pourrait faire plaisir à papa. »
* « L'anniversaire de Julie approche. »
* « Vous aviez prévu un restaurant avec Emma. »
* « Cela fait quelque temps que vous n'avez pas vu Thomas. »

**Limites :** maximum **2 notifications par jour**, **6 notifications par semaine**.

**Heures silencieuses :** 22 h → 8 h.

---

## Indice de présence

* **Échelle :** 0 à 100.
* **Privé. Jamais partagé. Jamais envoyé aux proches.**
* Ne représente pas la valeur d'une relation. Simple indicateur personnel.

**Pondérations :**

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

**Terminologie interdite :** « danger », « toxique », « négligée », « mauvaise relation ».

---

## Fonction « Souvenir du jour »

Exemple : « Il y a exactement trois ans, vous étiez à Rome avec Emma. »

## Fonction « En mémoire »

**Objectif :** conserver l'histoire d'une personne décédée.

**Éléments conservés :** photos, notes, souvenirs, chronologie, capsules.

**Notifications : désactivées.**

## Gamification

**Objectif :** créer une habitude saine.

**Éléments :** niveaux, XP, badges, défis, progression du cercle.

---

## Modèle économique

**Aucun plan gratuit.**

**Essai :** 14 jours gratuits, accès complet, carte bancaire obligatoire, annulation possible à tout moment.

**Abonnement :**

* Mensuel : **5,99 CHF**.
* Annuel : **44,99 CHF**.

**Après expiration — mode lecture seule :**

* L'utilisateur peut : consulter · exporter · supprimer.
* L'utilisateur ne peut plus : créer · modifier · ajouter du contenu.

**Paiements :**

* iOS : StoreKit + RevenueCat.
* Android : Google Play Billing + RevenueCat.

---

## Sauvegarde, export, suppression

* **Sauvegarde :** gratuite, automatique, cloud.
* **Export :** gratuit, PDF et JSON.
* **Suppression du compte :** définitive, conforme RGPD et nLPD suisse.

## Fonctionnement hors ligne

**L'application doit fonctionner sans Internet.**

**Autorisé hors ligne :** créer une relation · créer un souvenir · créer une interaction · modifier une note · consulter ses données.

**Synchronisation :** automatique, silencieuse, au retour d'Internet.

---

## Design system

**Style :** premium minimaliste.

**Couleurs :**

| Rôle | Couleur |
|---|---|
| Fond | Noir profond |
| Cartes | Anthracite |
| Accent | Or premium |
| Succès | Vert doux |
| Alerte | Orange doux |
| Erreur | Rouge discret |

**Interface :** grandes photos, grandes cartes, coins arrondis, animations fluides, effet premium.

## Navigation

Accueil · Relations · Ajouter · Souvenirs · Profil.

## Écrans à développer

1. Splash
2. Onboarding
3. Connexion
4. Création du compte
5. Accueil
6. Relations
7. Ajouter relation
8. Fiche relation
9. Ajouter interaction
10. Souvenirs
11. Calendrier
12. Promesses
13. Statistiques
14. Profil
15. Paramètres
16. Premium
17. En mémoire

---

## Architecture recommandée

* **Application :** Flutter.
* **Backend :** Supabase.
* **Base de données :** PostgreSQL.
* **Stockage :** Supabase Storage.
* **Notifications :** Firebase.
* **Paiements :** RevenueCat.

### Tables

Users · Relationships · RelationshipCategories · Preferences · Interactions · Memories · Photos · Notes · Events · Promises · Notifications · Achievements · Subscriptions · Settings.

---

## KPI

Inscriptions · essais gratuits démarrés · conversions après 14 jours · relations créées · interactions créées · souvenirs créés · rétention J7 · rétention J30 · taux d'abonnement · churn.

## Définition du succès

L'utilisateur doit penser :

> « Cette application contient une partie de mon histoire et m'aide à prendre soin des personnes que j'aime. »

## Règle fondatrice

Toute fonctionnalité développée doit obligatoirement répondre à au moins un objectif :

1. Créer davantage de moments ensemble.
2. Préserver les souvenirs.
3. Faciliter les petites attentions.
4. Aider l'utilisateur à être plus présent auprès de ses proches.

Si une fonctionnalité ne répond à aucun de ces objectifs, elle ne doit pas être développée.
