# AMIORA — Spécification de référence V1.0

* **Version :** 1.0
* **Statut :** Référence officielle
* **Date :** juillet 2026
* **Objectif :** construire une première version utilisable, cohérente et commercialisable d'AMIORA.

> Ce document est le document fondateur du produit. Il prévaut sur les documents sources antérieurs (`docs/spec/`), désormais archivés. Toute évolution passe par une nouvelle version datée de ce fichier.

---

## Vision

AMIORA est une application mobile premium permettant d'entretenir les relations importantes de sa vie.

**Mission :** empêcher les relations de s'éteindre par négligence et aider les utilisateurs à créer davantage de souvenirs avec les personnes qui comptent.

AMIORA n'est pas :

* un réseau social ;
* une messagerie ;
* un carnet de contacts.

AMIORA est :

* un gestionnaire de relations humaines ;
* un journal de vie ;
* un album de souvenirs ;
* un organisateur relationnel.

## Problème résolu

Aujourd'hui, beaucoup de personnes :

* oublient d'appeler leurs parents ;
* perdent progressivement leurs amis ;
* négligent leur couple ;
* oublient des promesses ;
* ne prennent plus le temps de créer des souvenirs.

Le problème n'est pas l'amour. Le problème est le manque de temps et d'attention.

## Positionnement

**Phrase produit :** « Prends soin des personnes qui comptent. »

**Promesse :** « AMIORA t'aide à être plus présent auprès de tes proches et à préserver les souvenirs qui comptent vraiment. »

## Public cible

**Cœur de cible :** 25 à 45 ans.

**Sous-cibles :** couples, familles, parents, amitiés longue distance, jeunes actifs, entrepreneurs.

## Objectifs du MVP

Permettre à un utilisateur de :

1. Ajouter les personnes importantes de sa vie.
2. Enregistrer ses interactions.
3. Créer des souvenirs.
4. Recevoir des rappels utiles.
5. Retrouver l'histoire de ses relations.
6. Avoir une vision claire de son cercle relationnel.

## Fonction principale

L'application est construite autour d'une seule action : **AJOUTER UNE INTERACTION**.

Toute la valeur du produit dépend de cette action.

### Types d'interactions

Appel · Message · Repas · Sortie · Voyage · Visite · Cadeau · Moment ensemble · Photo souvenir · Événement important.

### Structure d'une interaction

* Type
* Date
* Durée
* Qualité : Très mauvais / Moyen / Bien / Excellent
* Notes
* Photos (facultatives)
* Lieu (facultatif)
* Personnes concernées

## Fonctionnalités du MVP

### Authentification

* Apple
* Google
* Email
* Mot de passe oublié
* Suppression du compte

### Relations

Photo · Prénom · Nom · Catégorie · Date de naissance · Téléphone · Email · Adresse (facultative) · Métier (facultatif) · Notes.

### Catégories

Partenaire · Famille · Amis · Enfants · Mentor · Professionnel · Autres.

### Préférences d'une personne

Restaurants préférés · Loisirs · Films · Musique · Couleurs · Fleurs · Parfums · Idées cadeaux · Notes diverses.

**Aucune donnée médicale. Aucune donnée sensible.**

### Dates importantes

Anniversaire · Première rencontre · Premier rendez-vous · Mariage · Fiançailles · Naissance · Diplôme · Autres événements.

## Souvenirs

Photos · Vidéos · Notes · Messages · Documents · Albums.

## Ligne de vie

Chronologie automatique.

Exemple : 2024 première rencontre ; 2025 voyage à Rome ; 2026 déménagement ; 2027 mariage.

## Calendrier

Vues : jour, semaine, mois.

Affichage : anniversaires, promesses, activités, voyages, événements.

## Promesses

* Créer une promesse.
* Date.
* Priorité.
* Statut : à faire / en cours / terminée.

## Notifications

Exemples :

* « Anniversaire dans sept jours. »
* « Cela fait trente jours sans voir Thomas. »
* « Vous aviez prévu un restaurant. »
* « Une petite attention pourrait faire plaisir à papa. »

**Le ton doit toujours rester bienveillant. Jamais culpabilisant.**

## Score relationnel

* **Nom officiel :** Indice de présence.
* **Échelle :** 0 à 100.
* **Objectif :** donner une indication personnelle et privée.

Le score n'est jamais partagé. Le score ne juge pas la relation. Le score n'est qu'un indicateur.

### Variables du score

* Temps depuis la dernière interaction
* Nombre d'activités ensemble
* Régularité des contacts
* Promesses tenues
* Souvenirs créés
* Temps passé ensemble

## Relations à entretenir

Supprimer : « Relation en danger ».

Remplacer par : « Une petite attention pourrait faire plaisir. » · « Relation à entretenir. » · « Prenez des nouvelles. »

## Gamification

**Objectif :** créer une habitude positive. Jamais une dépendance nocive.

**Éléments :** niveaux, XP, badges, défis, progression du cercle.

**Badges :** Communicateur · Voyageur · Explorateur · Souvenir Keeper · Toujours présent.

**Défis :** appeler un proche · créer un souvenir · faire une activité · voir un ami · passer du temps en famille.

## Fonction « Souvenir du jour »

Exemple : « Il y a exactement deux ans, vous étiez à Rome avec Emma. »

Cette fonctionnalité est fortement recommandée : elle possède un fort potentiel de rétention.

## Fonction « Bucket List »

Liste d'activités à réaliser ensemble.

Exemples : voyager au Japon · voir les aurores boréales · faire un road trip · voir un concert.

## Fonction « En mémoire »

Permet de conserver l'historique d'une personne décédée : photos, souvenirs, messages, chronologie, capsules temporelles.

L'application devient également un album de vie.

## Navigation

Accueil · Relations · Ajouter · Souvenirs · Profil.

## Écrans du MVP

1. Splash screen
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
12. Statistiques
13. Profil
14. Paramètres
15. Premium
16. Capsule temporelle
17. Bucket List
18. En mémoire

## Design system

**Style :** premium minimaliste.

**Couleurs :** noir profond · anthracite · or premium · vert doux · orange doux · rouge discret.

**Typographie :** moderne, très lisible, grands espacements.

**Visuels :** gros visuels, grandes photos, animations fluides.

## Modèle économique

**Version gratuite :**

* 20 relations
* 500 photos
* Sauvegarde cloud
* Calendrier
* Souvenirs
* Notifications

**Premium :**

* 5,99 CHF par mois
* 59,99 CHF par an
* Relations illimitées
* Albums annuels
* Capsules temporelles
* Statistiques avancées
* Défis premium
* Widgets
* Exports PDF

## Architecture technique recommandée

* **Application :** Flutter.
* **Backend :** Supabase.
* **Base de données :** PostgreSQL.
* **Stockage :** Supabase Storage.
* **Notifications :** Firebase.
* **Paiements :** Stripe · Apple Pay · Google Pay · TWINT.

### Tables principales

Users · Relationships · RelationshipCategories · Interactions · Memories · Photos · Videos · Notes · Events · Promises · BucketLists · Notifications · Achievements · Statistics · Subscriptions · Settings.

## Confidentialité

* Toutes les données sont privées.
* Aucun partage automatique.
* Aucune donnée médicale.
* Export possible.
* Suppression définitive possible.
* Sauvegarde gratuite pour tous.
* Conformité RGPD et nLPD suisse obligatoire.

## KPI à mesurer

Inscriptions · relations créées · interactions enregistrées · souvenirs créés · temps passé · rétention J1 · rétention J7 · rétention J30 · conversion Premium · churn.

## Roadmap

* **Phase 1 :** MVP.
* **Phase 2 :** bêta privée.
* **Phase 3 :** lancement Suisse romande.
* **Phase 4 :** lancement France.
* **Phase 5 :** internationalisation.

## Définition du succès

L'utilisateur doit penser :

> « Cette application contient une partie de mon histoire et m'aide à prendre soin des personnes que j'aime. »

Toute décision produit ou design devra être prise en fonction de cette phrase.

## Règle fondatrice d'AMIORA

Chaque fonctionnalité doit répondre à au moins un de ces objectifs :

1. Créer davantage de moments ensemble.
2. Préserver les souvenirs.
3. Faciliter les petites attentions.
4. Aider l'utilisateur à être plus présent auprès de ses proches.

Si une fonctionnalité ne répond à aucun de ces objectifs, elle ne doit pas être développée.
