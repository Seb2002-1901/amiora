# Sprint 0 — Livrable 2 : prototype du geste central « Ajouter une interaction »

* **Statut : prototype prêt pour test utilisateur**
* **Date :** juillet 2026
* **Références :** [PRD Final V1.2](../prd-v1.2.md) (fonction centrale, cible < 10 secondes) · [Audit UX](../audit/04-ux-parcours-utilisateur.md) (recommandation P0 n° 1 : concevoir et tester la boucle de saisie avant toute ligne de code)

---

## 1. Spécification UX du flux

### 1.1 Principe

Toute l'application repose sur une action : **ajouter une interaction**. Le PRD fixe un budget temps explicite : **moins de 10 secondes** entre l'intention et la confirmation. Le flux est donc conçu pour que le chemin nominal tienne en **trois taps** : « + » → personne → type → « Enregistrer » (quatre taps au total, trois décisions), sans aucun champ à remplir.

### 1.2 Étapes

| # | Écran | Contenu | Sortie |
|---|---|---|---|
| 1 | **Accueil** | En-tête « Bonjour Sébastien », cartes du jour, barre d'onglets avec bouton **+** central | Tap sur « + » → ouverture de la feuille (et démarrage du chronomètre de test) |
| 2 | **Feuille « Ajouter une interaction » — étape 1** | Grille de 8 avatars à initiales : Emma (Partenaire), Papa (Famille), Maman (Famille), Thomas (Ami), Grand-maman (Famille), Julie (Amie), Léa (Enfant), Marc (Mentor) | Sélection d'une ou plusieurs personnes |
| 3 | **Feuille — étape 2** | Grille des 10 types du PRD : Appel 📞 · Message 💬 · Repas 🍽️ · Sortie 🌆 · Voyage ✈️ · Visite 🏠 · Cadeau 🎁 · Moment ensemble ✨ · Photo souvenir 📷 · Événement ⭐ | Sélection d'un type unique |
| 4 | **Feuille — enregistrement** | Date pré-remplie « Aujourd'hui » (modifiable), section repliée « Ajouter des détails », bouton « Enregistrer » | Tap sur « Enregistrer » (arrêt du chronomètre) |
| 5 | **Confirmation** | Message chaleureux « Enregistré. Encore un moment avec Papa 💛 », récapitulatif (type · date), temps écoulé | Retour à l'accueil |

### 1.3 Règles

* **Obligatoire : personne + type.** Rien d'autre. Le bouton « Enregistrer » est inactif tant que ces deux choix ne sont pas faits, et s'active dès qu'ils le sont — son libellé explique quoi faire tant qu'il est inactif (« Choisissez une personne et un type »).
* **Tout le reste est facultatif et pré-rempli.** La **date vaut « Aujourd'hui » par défaut** et reste visible (et modifiable) sans ouvrir les détails. Durée, qualité, lieu, note et photo vivent dans une section repliée « **Ajouter des détails** » ; **l'enregistrement est possible sans jamais l'ouvrir**.
* **Multi-personnes : oui, la sélection multiple est autorisée en V1.** Décision tranchée ici : un repas de famille ou une sortie à trois est *une* interaction vécue avec plusieurs personnes, pas trois saisies. Exiger trois saisies pour un même dîner triplerait la charge de journalisation — exactement le risque n° 1 identifié par l'audit UX. Côté données, l'interaction est enregistrée une fois et rattachée à chaque relation sélectionnée (elle alimente l'Indice de présence de chacune) ; la confirmation nomme tout le monde (« Encore un moment avec Emma et Léa 💛 »).
* **Le type est unique.** Une interaction a une seule nature ; en cas de doute, « Moment ensemble ✨ » sert de valeur générique.
* **Sélection jamais signalée par la couleur seule** : anneau or + fond légèrement doré + coche ✓, conformément à l'exigence d'accessibilité de l'audit.
* **Fermer la feuille sans enregistrer n'enregistre rien** (et annule l'essai chronométré).
* **Qualité** : échelle en quatre libellés — Difficile · Correct · Bien · Excellent — sans chiffre ni jugement, cohérente avec le ton bienveillant du produit.

### 1.4 Ce que le prototype ne couvre pas (hors périmètre du test)

Ajout réel d'une photo (bouton factice), création d'une nouvelle personne depuis la feuille, saisie depuis la fiche relation ou depuis une notification (prévues au produit, non nécessaires pour valider le budget temps), persistance des données (tout reste en mémoire).

---

## 2. Prototype et mode d'emploi

**Fichier :** [`prototype/ajouter-interaction.html`](../../prototype/ajouter-interaction.html) — un seul fichier HTML autonome, sans dépendance externe, polices système, tokens officiels du design system (fond `#0B0B0D`, cartes `#1A1A1E`, accent or `#D9B45B`, etc.).

**Mode d'emploi :**

1. Ouvrir le fichier dans un navigateur (double-clic suffit ; aucun serveur requis).
2. Le cadre mobile (390 × 844) est au centre ; le panneau **Résultats** est à côté.
3. Taper sur **+** : le chronomètre démarre (invisiblement) et la feuille s'ouvre.
4. Choisir personne(s) puis type, puis **Enregistrer** : le chronomètre s'arrête.
5. L'écran de confirmation affiche le temps en grand, **en vert si < 10 s**, en rouge sinon.
6. Le panneau Résultats accumule les essais et calcule la **médiane** en continu.
7. **Recommencer** (sur la confirmation ou dans le panneau) ramène à l'accueil, formulaire vierge, prêt pour l'essai suivant. **Effacer** vide la liste des essais.

Pour un test sur téléphone réel, ouvrir le fichier sur l'appareil (ou le servir sur le réseau local) : les cibles tactiles respectent le minimum de 44 px.

---

## 3. Protocole de test utilisateur

### 3.1 Participants

* **5 à 10 participants**, dans la cible 25-45 ans, mix de profils (couple, parent, jeune actif), utilisateurs de smartphone au quotidien, **jamais exposés au prototype** auparavant.
* Idéalement au moins deux participants gauchers ou tenant le téléphone à une main (voir § 5, zone du pouce).
* Matériel : un téléphone (ou à défaut un ordinateur) avec le prototype ouvert ; le chronomètre est intégré, aucun outil externe n'est nécessaire.

### 3.2 Consigne exacte à lire au participant

> « Voici la maquette d'une application qui aide à prendre soin de ses proches. Chaque fois que tu passes un moment avec quelqu'un — un appel, un repas, une sortie — tu peux l'enregistrer en quelques secondes. Je vais te demander d'enregistrer trois moments. Fais comme tu le ferais naturellement, sans chercher à aller vite : il n'y a pas de bonne ou de mauvaise façon de faire, c'est la maquette que nous testons, pas toi. Pense à voix haute si quelque chose te surprend. »

Ne **jamais** mentionner l'objectif des 10 secondes ni la présence d'un chronomètre avant la fin de la session (biais de vitesse). Masquer ou replier le panneau Résultats côté participant si l'écran le montre.

### 3.3 Tâches

| Tâche | Énoncé lu au participant | Ce qu'elle valide |
|---|---|---|
| **T1** | « Tu viens de raccrocher après un appel avec ton papa. Enregistre ce moment. » | Le chemin nominal minimal (personne + type + Enregistrer), **support du critère de validation** |
| **T2** | « Hier soir, tu as partagé un repas avec Emma, et c'était un excellent moment. Enregistre-le en précisant que c'était excellent. » | La découvrabilité de la section « Ajouter des détails » et du champ qualité |
| **T3** | « Samedi, tu as fait une sortie avec deux personnes de ton choix. Enregistre-la. » | La sélection multiple de personnes (compréhension spontanée, sans indice) |

Entre chaque tâche, l'animateur tape « Recommencer » pour revenir à l'accueil. Chaque tâche produit un essai chronométré dans le panneau Résultats.

### 3.4 Mesures

* **Temps par tâche** : relevé automatiquement par le chronomètre intégré (du tap sur « + » au tap sur « Enregistrer »), consigné depuis le panneau Résultats à la fin de chaque participant.
* **Erreurs** : tout tap n'appartenant pas au chemin attendu — mauvais élément sélectionné puis corrigé, ouverture inutile des détails en T1/T3, hésitation > 3 s sans action, échec (abandon ou aide nécessaire).
* **Verbatims** : phrases prononcées à voix haute, en particulier au moment d'ouvrir les détails (T2), de sélectionner la deuxième personne (T3) et à la lecture de l'écran de confirmation (le message chaleureux est-il perçu comme tel ?).
* Après les trois tâches : deux questions ouvertes — « Qu'est-ce qui t'a semblé le plus simple ? le plus agaçant ? » et « Le ferais-tu vraiment après chaque appel ou repas ? pourquoi ? ».

### 3.5 Critère de validation

> **La médiane des temps de la tâche T1 (tous participants confondus) doit être inférieure à 10 secondes.**

Critères secondaires (indicatifs, non bloquants) : T2 < 20 s ; T3 < 12 s ; zéro échec sur T1 ; au moins 8 participants sur 10 découvrent la sélection multiple sans aide en T3.

Si la médiane T1 est ≥ 10 s : identifier le poste de temps dominant (recherche de la personne dans la grille ? repérage du type ? portée du bouton Enregistrer ?) à partir des erreurs observées, corriger le prototype, retester avec 5 nouveaux participants avant d'ouvrir le développement de l'écran.

---

## 4. Gabarit de rapport de test

À remplir à l'issue de la campagne (une ligne par participant, temps relevés dans le panneau Résultats) :

| Participant | Profil | T1 — appel avec Papa (s) | T2 — repas + qualité (s) | T3 — sortie à deux (s) | Erreurs (nb + nature) | Verbatim marquant |
|---|---|---|---|---|---|---|
| P1 | | | | | | |
| P2 | | | | | | |
| P3 | | | | | | |
| P4 | | | | | | |
| P5 | | | | | | |
| … | | | | | | |
| **Médiane** | | **__ s** | __ s | __ s | | |

**Synthèse :**

* Médiane T1 : __ s → critère « < 10 s » : **atteint / non atteint**
* Taux de réussite sans aide : T1 __ /__ · T2 __ /__ · T3 __ /__

**Améliorations décidées :**

| # | Constat (tâche, fréquence) | Amélioration proposée | Priorité (P0/P1/P2) | Retest nécessaire ? |
|---|---|---|---|---|
| 1 | | | | |
| 2 | | | | |
| 3 | | | | |

---

## 5. Points d'attention connus

* **Zone du pouce.** La grille des personnes est en haut de la feuille, hors de la zone naturelle du pouce en usage à une main sur un grand écran. C'est un compromis assumé (l'ordre personne → type suit le modèle mental « avec qui ? quoi ? ») ; si les tests montrent des étirements ou des changements de prise, envisager d'inverser la disposition ou de remonter la feuille moins haut. Observer spécifiquement la main de tenue pendant T1.
* **Portée du bouton « + ».** Le « + » central de la barre d'onglets est bien placé pour le pouce, mais l'audit a relevé son ambiguïté dans les maquettes historiques (personne ? souvenir ? interaction ?). Dans ce prototype, il ouvre directement « Ajouter une interaction » — l'hypothèse à confirmer en test est que ce raccourci direct est compris ; à terme, si le « + » ouvre un menu de création, « Enregistrer une interaction » devra en être la première entrée et le budget des 10 secondes devra absorber ce tap supplémentaire.
* **Saisie ultérieure des détails.** Le flux parie que l'utilisateur enregistre le squelette (personne + type) sur le moment et n'enrichit que rarement. Deux risques à surveiller : des interactions durablement « creuses » (pas de durée → la métrique « temps ensemble » du PRD reste vide, point déjà signalé par l'audit) et l'absence, dans ce prototype, d'un chemin pour rouvrir une interaction et compléter ses détails après coup. Ce geste d'édition devra exister dans le produit ; le test T2 mesure en attendant le coût d'une saisie de détail « à chaud ».
* **Ordre et taille de la grille des types.** Dix types sur cinq rangées imposent un balayage visuel ; les tests diront si les types fréquents (Appel, Message, Repas) doivent être triés par usage réel plutôt que par l'ordre du PRD.
* **Le chronomètre est un instrument de test, pas une fonctionnalité.** Rien de chronométré ne doit apparaître dans le produit final : mesurer la vitesse de saisie devant l'utilisateur contredirait le ton du produit.

---

*Livrable 2 du Sprint 0 — répond à la réserve « geste central non prototypé » de la [validation du GO](../audit/16-revue-du-prd-v1.2-validation-du-go.md).*
