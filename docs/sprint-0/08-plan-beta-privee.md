# Sprint 0 — Livrable 8 : Plan de bêta privée

* **Statut : validé pour exécution**
* **Date :** juillet 2026
* **Références :** [PRD V1.2](../prd-v1.2.md) · [Roadmap vers le lancement](../audit/12-roadmap-vers-le-lancement.md) (jalon J3) · [KPI et mesure du succès](../audit/13-kpi-et-mesure-du-succes.md) · [Revue du PRD V1.2](../audit/16-revue-du-prd-v1.2-validation-du-go.md)

> La bêta privée est le banc d'essai du pivot « premium sans plan gratuit » — la décision la plus audacieuse et la moins réversible du dossier (chapitre 16). Ce plan la réintroduit dans le calendrier avec des critères de sortie chiffrés, conformément au jalon J3 de la roadmap (décembre 2026 – février 2027). Tous les seuils de ce document sont des **hypothèses de travail** : ils créent une discipline de décision et seront révisés à la lumière des données réelles, jamais communiqués comme engagements.

---

## 1. Objectif : deux hypothèses à valider

La bêta ne teste pas « si l'application plaît ». Elle teste deux hypothèses précises, dans cet ordre d'importance :

| # | Hypothèse | Formulation testable | Instrument |
|---|---|---|---|
| **H1 — Paiement** | Des utilisateurs sont prêts à payer pour entretenir leurs relations. | ≥ 25 % des testeurs actifs à J30 déclarent une intention d'achat face au paywall sandbox. | Paywall simulé (semaine 4) + entretiens |
| **H2 — Usage** | Les utilisateurs reviennent au moins une fois par semaine. | Rétention hebdomadaire : l'utilisateur type ouvre l'application et consigne au moins une interaction chaque semaine. | Télémétrie (WAU, cohortes hebdomadaires) |

Hypothèses secondaires observées en passant : le geste central tient sa promesse (< 10 secondes), les rappels sont vécus comme une aide et non une culpabilisation (chapitre 08 de l'audit), et l'onboarding fabrique le « moment wow » avant que la valeur cumulative n'existe (chapitre 16).

Si H2 échoue, H1 ne sera jamais vraie : personne ne paie pour une application qu'il n'ouvre plus. L'ordre d'analyse est donc toujours **usage d'abord, paiement ensuite**.

---

## 2. Dispositif

| Paramètre | Valeur |
|---|---|
| **Effectif** | 50 à 100 testeurs réellement actifs (recruter ~130-150 pour absorber la déperdition) |
| **Durée** | 30 jours de cycle principal, prolongeable par cycles de 2 semaines si un critère de sortie n'est pas atteint (dans l'enveloppe du jalon J3 : décembre 2026 – février 2027) |
| **Distribution** | TestFlight (iOS) + Google Play piste interne puis fermée (Android), builds simultanés |
| **Zone** | Suisse romande d'abord — marché du lancement soft, langue et prix (CHF) déjà cohérents |
| **Monétisation** | **Abonnement simulé** : le paywall réel (grille 5,99 CHF/mois · 44,99 CHF/an, essai 14 jours) est affiché en environnement sandbox ; l'« achat » est un achat de test StoreKit / Play Billing — **aucun encaissement réel**. On mesure l'intention et on valide techniquement la chaîne d'achat, sans facturer des testeurs bénévoles. |
| **Canal d'animation** | Un canal d'échange dédié (groupe privé), une adresse de contact, un questionnaire d'entrée et deux micro-enquêtes in-app |

Le choix de la période n'est pas un accident de calendrier : la fenêtre couvre les fêtes de fin d'année, période de plus forte densité relationnelle (anniversaires, repas de famille, bonnes résolutions) — le meilleur banc d'essai possible pour ce produit (chapitre 12).

### Pourquoi l'abonnement simulé

Le modèle sans plan gratuit rend la conversion réelle impossible à mesurer honnêtement en bêta : des testeurs recrutés et accompagnés ne sont pas des acheteurs froids. Le paywall sandbox mesure ce qui est mesurable à ce stade — l'**intention** (déclenchement volontaire de l'« achat » test, réponses au paywall, verbatims d'entretien) — et laisse la mesure de la conversion réelle au lancement soft, où elle appartient. Il valide en revanche dès la bêta toute la mécanique VENDABLE : affichage des offres, souscription, restauration d'achat, bascule mensuel/annuel, règle d'expiration en lecture seule.

---

## 3. Recrutement

### 3.1 Canaux

1. **Entourage élargi du porteur** (amis d'amis, collègues, réseau professionnel) — avec une **consigne écrite de non-biais** remise à chaque relais : ne pas « vendre » l'application, ne pas aider à l'utiliser, ne pas excuser ses défauts ; le testeur idéal ne connaît pas le porteur personnellement.
2. **Communautés locales romandes** : groupes de quartier et d'expatriés, associations de parents, réseaux d'entrepreneurs et de jeunes actifs (Lausanne, Genève, Fribourg, Neuchâtel, Sion), presse locale le cas échéant.
3. **Liste d'attente de la landing page** — ouverte dès septembre 2026 (recommandation P1-6 du chapitre 12) ; c'est aussi le canal qui préfigure l'acquisition réelle du lancement.
4. **Recrutement dirigé par personas** : chaque persona de l'audit (chapitre 01) doit être représenté par au moins 10 testeurs — par exemple *la trentenaire expatriée qui culpabilise de ne pas appeler*, *le père débordé qui perd ses amis d'université*, et un troisième profil « jeune actif / entrepreneur au réseau personnel négligé ».

### 3.2 Critères de sélection

* Possession d'un appareil **iOS ou Android** récent (objectif : ~50/50 entre plateformes) ;
* **25-45 ans** — la cible du PRD ;
* Mix de situations relationnelles : **couples, familles avec proches âgés ou éloignés, amitiés à distance** ;
* Disponibilité déclarée : accepter d'utiliser l'application « comme dans la vraie vie » pendant 30 jours et, pour une partie d'entre eux, un entretien de 30-45 minutes ;
* Exclusions : professionnels du produit/UX proches du projet, membres de la famille directe du porteur (biais de complaisance).

### 3.3 Formulaire d'entrée

Un formulaire court (< 3 minutes) adossé à la landing page :

1. Prénom, âge, canton, adresse e-mail.
2. Appareil (iOS / Android + modèle approximatif).
3. Situation relationnelle (en couple / famille avec enfants / proches à l'étranger ou éloignés / autre).
4. « Citez une personne que vous aimeriez mieux entretenir, et depuis combien de temps vous ne l'avez pas vue ou appelée. » (question ouverte — filtre les candidats sans problème réel)
5. « Avez-vous déjà payé un abonnement pour une application personnelle (journal, sport, méditation…) ? » (oui / non / lequel)
6. Disponibilité pour un entretien en visio (oui / non).
7. Consentement explicite : collecte de données d'usage pseudonymisées pendant la bêta, confidentialité du contenu testé (les règles privacy-first du chapitre 13 s'appliquent dès la bêta : aucun contenu, aucun prénom de proche dans la télémétrie).

Sélection finale par quotas (plateforme, âge, persona) plutôt que premier arrivé, premier servi.

---

## 4. Déroulé semaine par semaine

| Semaine | Objectif | Actions |
|---|---|---|
| **S0 (pré-bêta)** | Tout est prêt avant le premier testeur | Builds validés en interne (dogfooding du porteur depuis octobre), télémétrie recettée, canal d'échange ouvert, guide de bienvenue rédigé |
| **S1 — Onboarding et première valeur** | Chaque testeur atteint l'activation | Envoi des invitations par vagues de 20-25 ; message de bienvenue unique (« utilisez AMIORA comme si vous l'aviez téléchargée vous-même ») ; suivi quotidien de la complétion d'onboarding et du temps jusqu'à la 3ᵉ fiche ; relance individuelle à J+3 des comptes créés mais non activés |
| **S2-S3 — Usage naturel** | Observer l'habitude s'installer, sans la forcer | Aucune sollicitation produit ; seules des **relances de saisie** neutres sont tolérées (rappel du geste central à ceux qui n'ont rien consigné depuis 7 jours, une seule fois) ; micro-enquête in-app n° 1 à **J14** ; lecture hebdomadaire des cohortes ; correctifs éventuels (2-3 builds prévus au jalon J3) |
| **S4 — Paywall test et entretiens** | Mesurer l'intention de paiement et comprendre le ressenti | Activation du paywall sandbox pour tous les testeurs actifs (simulation de fin d'essai : écran d'offre, achat test possible) ; micro-enquête in-app n° 2 à **J30** ; conduite des 8-12 entretiens semi-directifs ; consolidation des métriques pour la revue de sortie |

En cas de prolongation (cycles de 2 semaines), le schéma S2-S3 se répète, avec une nouvelle lecture des critères à chaque fin de cycle.

---

## 5. Métriques et cibles go/no-go

Les définitions suivent le dictionnaire de métriques du chapitre 13 (activation = *aha moment*, actif = utilisateur actif hebdomadaire). La logique de l'audit est reprise et adaptée au modèle sans plan gratuit : la « conversion » devient une **intention de paiement** mesurée au paywall sandbox.

| Métrique | Définition | Cible go/no-go |
|---|---|---|
| **Complétion d'onboarding** | Part des invités qui terminent l'onboarding (compte + premières fiches) | **≥ 70 %** |
| **Activation** | 3 relations créées **+** 1 interaction consignée **+** 1 rappel reçu, dans les 7 premiers jours | **≥ 40 %** |
| **Geste central** | Temps médian de saisie d'une interaction (télémétrie) | **< 10 s** |
| **Intensité d'usage** | Part des actifs hebdomadaires consignant ≥ 3 interactions/semaine | **≥ 60 %** |
| **Rétention J7** | Cohortes de testeurs, retour = ouverture + action | **≥ 30 %** |
| **Rétention J30** | Idem à 30 jours (bêta motivée : cible plus haute que le lancement) | **≥ 25 %** |
| **Intention de paiement (H1)** | Part des actifs à J30 déclenchant l'« achat » sandbox ou déclarant une intention ferme au paywall | **≥ 25 %** |
| **Stabilité** | Sessions sans crash sur les 30 jours | **> 99,5 %**, zéro bug critique ouvert |

**Garde-fous surveillés, jamais optimisés** (chapitre 13) : durée médiane de session (doit rester courte et stable), taux de désactivation des notifications, consignations « suspectes » (rafales), taux d'opt-out de la télémétrie.

---

## 6. Feedback qualitatif

### 6.1 Entretiens semi-directifs (8 à 12)

Sélection : couvrir les trois personas, les deux plateformes, et un mélange délibéré de testeurs très actifs, moyennement actifs et décrocheurs (les décrocheurs sont les plus instructifs). Durée 30-45 minutes, en visio, enregistrés avec accord, retranscrits en verbatims anonymisés.

**Guide d'entretien — 10 questions :**

1. Racontez-moi la dernière fois que vous avez ouvert AMIORA. Qu'êtes-vous venu y faire ?
2. **Question mission** : AMIORA vous a-t-il amené à recontacter ou revoir quelqu'un que vous auriez autrement négligé ? Racontez.
3. Qu'est-ce qui vous fait revenir dans l'application — ou qu'est-ce qui vous en a éloigné ?
4. Montrez-moi comment vous ajoutez une interaction. (observation directe : gestes, hésitations, durée ressentie)
5. Que pensez-vous des rappels reçus ? Donnez un exemple de rappel utile — et un exemple de rappel de trop, s'il y en a eu.
6. L'Indice de présence : aide, gadget, ou source de culpabilité ?
7. **Test de déception** : si AMIORA disparaissait demain, seriez-vous **très déçu, un peu déçu, ou pas déçu** ? Pourquoi ?
8. Vous avez vu l'écran d'abonnement : 5,99 CHF par mois ou 44,99 CHF par an après 14 jours d'essai. Réaction à chaud ? Qu'est-ce qui vous ferait payer — ou refuser ?
9. Quatorze jours d'essai : est-ce assez pour savoir si l'application vous est utile ? Que faudrait-il avoir vécu dans l'application pour en être sûr ?
10. À qui recommanderiez-vous AMIORA, avec quels mots ? Et à qui ne la recommanderiez-vous surtout pas ?

Les questions 8 et 9 alimentent directement le plan B (livrable 9) : elles distinguent l'objection **prix** de l'objection **durée d'essai**.

### 6.2 Micro-enquête in-app (J14 et J30)

Deux questions, jamais bloquantes, une seule fois par échéance :

1. « Au cours des deux dernières semaines, AMIORA vous a-t-elle amené à contacter ou voir un proche que vous auriez autrement négligé ? » — oui / non / je ne sais pas.
2. « Que ressentiriez-vous si vous ne pouviez plus utiliser AMIORA ? » — très déçu / un peu déçu / indifférent.

Cible indicative en bêta : **≥ 25 % de « très déçu »** (le seuil classique de 40 % reste l'objectif d'horizon, chapitre 13). Les réponses agrégées rejoignent le tableau de bord au même rang que les métriques d'usage.

---

## 7. Gouvernance

### 7.1 Tableau de bord hebdomadaire

Une page, revue chaque semaine à jour fixe (lundi), tenue par le porteur :

* North Star : interactions réelles consignées / semaine / actif hebdomadaire (tendance) ;
* Complétion d'onboarding et taux d'activation de la cohorte de la semaine ;
* Courbes de rétention des cohortes ouvertes (hebdomadaires) ;
* Temps médian de saisie d'une interaction ;
* Part des actifs à ≥ 3 interactions/semaine ;
* Crash-free sessions, bugs critiques ouverts ;
* Garde-fous : durée de session, désactivation des notifications, opt-out télémétrie ;
* Signal qualitatif : « très déçu » (dernière enquête), verbatims marquants de la semaine ;
* À partir de S4 : entonnoir paywall sandbox (vue → interaction → « achat » test).

### 7.2 Rituel de tri des retours

Un créneau hebdomadaire fixe (1 h) pour dépouiller le canal d'échange et les retours :

* Chaque retour est classé **bug critique / bug / friction UX / idée / hors périmètre v1** ;
* Les bugs critiques sont corrigés dans le prochain build (2-3 builds correctifs prévus) ; les idées sont notées mais **aucune fonctionnalité nouvelle n'entre pendant la bêta** — la bêta teste le produit défini, elle ne le redéfinit pas ;
* Toute métrique en alerte deux semaines consécutives déclenche une décision explicite : corriger, tolérer et documenter, ou retirer (chapitre 13).

### 7.3 Critères d'arrêt anticipé

La bêta est suspendue immédiatement (et les testeurs informés) si :

* crash-free < 98 % ou bug de **perte de données** (souvenirs, photos) avéré ;
* incident de confidentialité, même mineur (fuite de contenu, télémétrie captant des données de tiers) ;
* activation < 20 % après deux vagues complètes d'invitations — le produit ne passe pas la première marche, inutile d'user les testeurs ;
* signal de nocivité : rappels majoritairement vécus comme culpabilisants dans les retours spontanés.

Un arrêt anticipé n'est pas un échec du plan : c'est le plan qui fonctionne.

### 7.4 Sortie de bêta : arbre de décision

La revue de sortie confronte les huit cibles du § 5 et le signal qualitatif :

```
Tous les critères d'usage atteints (onboarding, activation, saisie,
intensité, rétention, stabilité) ?
│
├─ OUI ── Intention de paiement ≥ 25 % ?
│         ├─ OUI → **GO lancement soft** (avril 2027, jalon J5),
│         │        grille tarifaire confirmée, plan B armé en veille.
│         └─ NON → **Itérer sur la monétisation** : analyser l'objection
│                  dominante (prix vs durée d'essai vs valeur perçue,
│                  questions 8-9 des entretiens), pré-activer l'option
│                  correspondante du plan B (livrable 9), prolonger la
│                  bêta d'un cycle de 2 semaines pour retester le paywall.
│                  Le lancement recule, il ne se force pas.
│
└─ NON ── Les manques sont-ils localisés et corrigeables
          (un écran, un flux, un réglage de rappels) ?
          ├─ OUI → **Itérer sur le produit** : corriger, prolonger par
          │        cycles de 2 semaines, relire les critères à chaque cycle.
          └─ NON → Usage hebdomadaire structurellement absent
                   (rétention et intensité loin des cibles malgré
                   des testeurs motivés) → **Pivoter** : le problème
                   est dans la proposition de valeur, pas dans
                   l'exécution. Revue complète promesse/cible avant
                   toute dépense de lancement.
```

Règle finale, héritée du chapitre 12 : **c'est la complétion des critères, et non une date, qui déclenche le lancement.**
