# Sprint 0 — Livrable 9 : Plan B — scénarios de repli du modèle « premium sans gratuit »

* **Statut : validé — à armer avant le lancement soft**
* **Date :** juillet 2026
* **Références :** [PRD V1.2](../prd-v1.2.md) · [Business model et monétisation](../audit/10-business-model-et-monetisation.md) · [Revue du PRD V1.2](../audit/16-revue-du-prd-v1.2-validation-du-go.md) · [Plan de bêta privée](08-plan-beta-privee.md)

> **L'absence de formule gratuite est une hypothèse produit, pas un dogme.** Le chapitre 16 de l'audit l'exige explicitement : « traiter le pivot comme une hypothèse à valider » et « définir à l'avance le plan B mesuré si le haut de l'entonnoir s'effondre ». Ce document est ce plan B — écrit **avant** le lancement, à froid, pour que le jour où un seuil est franchi, la réponse soit une exécution et non une improvisation sous pression. Tous les chiffres sont des hypothèses de travail, à ajuster sur les données réelles.

---

## 1. Principe

Le modèle retenu (essai complet de 14 jours, puis 5,99 CHF/mois ou 44,99 CHF/an, mode lecture seule après expiration) a une faiblesse identifiée et assumée : **la valeur d'AMIORA est cumulative** — le produit est le plus convaincant après des mois de souvenirs accumulés — **alors que l'essai dure 14 jours** (chapitre 16). Par ailleurs, un essai avec engagement de paiement convertit bien ceux qui le démarrent, mais réduit le nombre de ceux qui osent le démarrer, surtout pour une marque inconnue.

Le plan B n'est donc pas un aveu de doute : c'est la contrepartie rationnelle d'un pari assumé. Il définit **quand** on agit (des seuils mesurés, pas des impressions), **quoi** faire (des options pré-arbitrées, dans un ordre fixé) et **ce qui ne changera jamais** (les invariants du § 4).

---

## 2. Seuils de déclenchement

Mesure sur les **60 premiers jours suivant le lancement soft** (jalon J5, avril 2027), via l'entonnoir instrumenté du chapitre 13 (`paywall_viewed` → `trial_started` → `subscription_started` → `subscription_renewed` / `subscription_cancelled`). Le plan B est **déclenché** si, à l'issue de cette fenêtre, au moins un des trois seuils est franchi :

| # | Indicateur | Définition | Seuil de déclenchement |
|---|---|---|---|
| S1 | **Page store → essai démarré** | Part des visiteurs de la fiche store qui installent **et** démarrent l'essai | **< 5 %** |
| S2 | **Essai → payant** | Part des essais de 14 jours convertis en premier paiement (mensuel ou annuel confondus) | **< 25 %** |
| S3 | **Churn mensuel** | Part des abonnés actifs résiliant sur un mois glissant (hors remboursements sous 48 h) | **> 8 %** |

Trois précautions de lecture :

* **Volume minimal** : aucun seuil n'est interprété sous ~200 fiches store vues (S1), ~50 essais démarrés (S2) ou ~30 abonnés (S3) — en dessous, on prolonge la mesure, on ne décide pas sur du bruit.
* **Diagnostic avant remède** : chaque seuil franchi déclenche d'abord une lecture qualitative (verbatims des entretiens de bêta, avis stores, tickets support) pour identifier l'objection dominante — prix, durée d'essai, valeur perçue, ou confiance. La matrice du § 5 associe ensuite le symptôme à l'option.
* **S3 n'est pas un problème de tarif** : un churn élevé signale un déficit de valeur ou d'habitude ; aucune option tarifaire ne le corrige durablement. Il renvoie d'abord au produit (rétention, rappels, onboarding), les options A-D n'intervenant qu'en soutien.

---

## 3. Options pré-arbitrées

Ordre d'exécution nominal : **A → B → C**, l'option D étant une mesure d'amorçage activable dès le lancement, indépendamment des seuils. On ne saute une étape que si le diagnostic l'impose de façon univoque (matrice du § 5).

### Option A — Allonger l'essai à 30 jours *(première à tester)*

* **Logique** : la valeur d'AMIORA est cumulative ; l'essai court est la faiblesse identifiée du modèle (chapitre 16). Trente jours laissent le temps de vivre un anniversaire, un « Souvenir du jour », une reprise de contact — c'est-à-dire la promesse elle-même. C'est le remède le plus direct à l'objection « je n'ai pas eu le temps de voir l'intérêt ».
* **Mise en œuvre** : modification des offres d'essai dans App Store Connect / Play Console (+ RevenueCat) ; aucune modification du produit.
* **Coût** : quasi nul (paramétrage + mise à jour des fiches stores et de la landing page). Un revenu différé de 16 jours, marginal à cette échelle.
* **Délai** : < 1 semaine.
* **Métrique de succès** : après 30 jours de mesure — S1 remonte (l'essai long rassure au moment de s'engager) **et** S2 se maintient ≥ 25 % sur les nouvelles cohortes. Échec si S2 se dégrade fortement sans gain sur S1 (l'essai long ne ferait que retarder le non).

### Option B — Baisser le prix : 4,99 CHF/mois · 39,99 CHF/an

* **Logique** : à n'activer **que si l'objection prix domine explicitement** les entretiens et les verbatims — pas sur une intuition, et **pas avant 90 jours de données** post-lancement. Baisser un prix est un acte quasi irréversible et un signal public ; l'audit le dit : « monter un prix qui convertit est facile, descendre un prix qui échoue est un aveu » (chapitre 10). La remise annuelle (~33 %) reste dans l'épure de la grille actuelle.
* **Mise en œuvre** : nouvelle grille dans les stores et RevenueCat ; les abonnés existants sont **automatiquement alignés sur le meilleur tarif** (voir § 4) ; mise à jour des fiches, CGV et landing page.
* **Coût** : direct — environ −17 % de revenu brut par abonné mensuel, −11 % par abonné annuel ; indirect — repositionnement (assumer un premium légèrement plus accessible).
* **Délai** : 1-2 semaines (paramétrage + communication).
* **Métrique de succès** : après 30 jours — S2 ≥ 25 % sur les cohortes au nouveau prix **et** revenu net par cohorte au moins stable (la baisse doit être plus que compensée par le volume). Échec si S2 ne bouge pas : l'objection n'était pas le prix, et le retour en arrière ne se fera que pour les nouveaux entrants.

### Option C — Mode gratuit limité *(dernier recours)*

* **Logique** : réintroduire un palier gratuit étroit si, et seulement si, les options A et B ont échoué et que le haut de l'entonnoir (S1) reste effondré — signe que l'engagement de paiement avant l'usage est la barrière, quelle que soit la durée d'essai ou le prix. Le périmètre est **figé dès maintenant** pour éviter l'improvisation sous pression et l'inflation du gratuit :

  | Capacité | Gratuit (périmètre exact, non négociable) | Abonné |
  |---|---|---|
  | Relations | **3** au maximum | Illimitées |
  | Photos / souvenirs | **50** en création cumulée | Illimités |
  | Rappels | **Anniversaires uniquement** | Tous (reprise de contact, promesses, dates importantes) |
  | Statistiques & Indice de présence | **Non** | Oui |
  | Calendrier, export, sauvegarde | Oui (sur le périmètre gratuit) | Oui |

  Ce périmètre respecte la logique du chapitre 10 : le gratuit installe l'habitude et fait toucher la valeur cumulative ; le paywall se raconte autour de la mémoire et de la profondeur, pas de la confiscation.
* **Mise en œuvre** : développement des quotas, des états de blocage bienveillants, du parcours de conversion gratuit → essai → payant ; requalification des KPI (la conversion se mesure alors sur la base active gratuite, cible 2-4 %, chapitre 13).
* **Coût** : **4 à 6 semaines de développement** + coût de stockage d'une base gratuite + charge de support ; c'est la seule option qui change le modèle économique, d'où son rang de dernier recours.
* **Délai** : 4-6 semaines de bascule, puis 60 jours de mesure (le cycle gratuit → payant est plus lent qu'un essai).
* **Métrique de succès** : S1 (redéfini : store → inscription gratuite) > 20 % ; conversion gratuit → payant ≥ 2 % à 60 jours ; rétention J30 du gratuit ≥ 15 %. Échec si le gratuit croît sans convertir : on aurait alors construit une base de coûts, pas un entonnoir.

### Option D — Offre de lancement « fondateur » *(amorçage, activable dès le jour 1)*

* **Logique** : ce n'est pas un repli mais un **accélérateur d'amorçage**, documenté ici parce qu'il mobilise le même levier (le prix perçu) et doit obéir aux mêmes règles. Deux variantes, au choix du lancement :
  * **D1 — « Fondateur » −40 % la première année** : environ **26,99 CHF la première année** (au lieu de 44,99), limitée aux N premiers abonnés (hypothèse : 500-1 000) ou aux 8 premières semaines, **tarif préférentiel conservé tant que l'abonnement reste actif** ;
  * **D2 — « Fondateur à vie »** : paiement unique, strictement contingenté (hypothèse : 200-300 unités, ~119 CHF) — l'audit met en garde contre l'achat à vie qui cannibalise le récurrent sur un produit aux coûts de stockage perpétuels (chapitre 10) ; D2 n'est donc envisageable que comme opération de rareté, jamais comme offre permanente. **Recommandation : D1 par défaut, D2 seulement si un signal fort de communauté le justifie.**
* **Mise en œuvre** : offre promotionnelle dans les stores / RevenueCat, compteur public de places restantes, mention sur la landing page.
* **Coût** : remise consentie sur les premières cohortes — compensée par la valeur d'une base d'ambassadeurs précoces et de premiers avis.
* **Délai** : 1 semaine de paramétrage ; fenêtre limitée dans le temps par construction.
* **Métrique de succès** : épuisement du contingent en ≤ 8 semaines ; S1 et S2 des cohortes « fondateur » supérieurs aux cohortes plein tarif ; rétention à 12 mois des fondateurs ≥ 40 % (première lecture de la rétention annuelle, chapitre 13).

### Vue d'ensemble

| Option | Déclencheur type | Coût | Délai de mise en œuvre | Mesure | Rang |
|---|---|---|---|---|---|
| **A — Essai 30 jours** | S1 ou S2 franchi, objection « pas le temps de voir la valeur » | Quasi nul | < 1 semaine | 30 jours | 1ᵉʳ |
| **B — Prix 4,99 / 39,99** | S2 franchi **et** objection prix dominante, ≥ 90 jours de données | −11 à −17 % de revenu unitaire | 1-2 semaines | 30 jours | 2ᵉ |
| **C — Gratuit limité** | S1 toujours effondré après A et B | 4-6 semaines de dev + coûts récurrents | 4-6 semaines | 60 jours | Dernier recours |
| **D — Offre fondateur** | Amorçage (indépendant des seuils) | Remise contingentée | 1 semaine | 8 semaines | Parallèle, dès J5 |

---

## 4. Règles d'exécution

1. **Une seule option à la fois.** Deux changements simultanés rendent la mesure illisible ; on ne saura jamais lequel a agi.
2. **Trente jours de mesure minimum avant d'enchaîner** (soixante pour l'option C), sur des cohortes complètes — pas de lecture à mi-cycle, pas de décision sur une semaine anormale (vacances, presse).
3. **« On ne confisque jamais ce qui a été créé. »** La règle du chapitre 10 s'applique à **tous** les scénarios, y compris l'option C : tout contenu créé reste consultable, exportable et supprimable à vie, quel que soit le statut de l'abonnement. Les quotas du gratuit limitent la *création*, jamais la consultation. Aucun plan B ne peut y déroger — c'est la confiance, l'actif le plus précieux du produit.
4. **Les abonnés existants gardent le meilleur tarif.** Toute baisse de prix est répercutée automatiquement aux abonnés en place (ou leur tarif est d'emblée inférieur, cas des fondateurs) ; personne ne découvre qu'un nouveau venu paie moins pour la même chose. Toute activation d'option fait l'objet d'une **communication transparente** aux abonnés : ce qui change, pourquoi, et ce que cela leur apporte.
5. **Chaque activation est documentée** : date, seuil déclencheur, diagnostic, métrique de succès attendue, date de relecture — une page ajoutée en annexe de ce document, pour que l'historique des décisions reste lisible.
6. **Le produit d'abord.** Si le diagnostic pointe la valeur perçue ou la rétention (S3), la réponse prioritaire est produit (onboarding, rappels, geste central) — les options tarifaires ne maquillent pas un déficit d'usage.

---

## 5. Matrice de décision finale

| Symptôme observé (après diagnostic qualitatif) | Lecture | Option recommandée |
|---|---|---|
| S1 < 5 %, verbatims « je ne veux pas m'engager avant d'avoir vu » | L'engagement de paiement avant usage bloque l'entrée | **A** (essai 30 jours) ; si échec confirmé après B → **C** |
| S2 < 25 %, entretiens : « pas eu le temps de voir l'intérêt », usage réel pendant l'essai faible | L'essai est trop court pour une valeur cumulative | **A** |
| S2 < 25 %, entretiens : objection prix explicite et dominante, usage pendant l'essai correct | Le prix est la barrière, pas la valeur | **B** (jamais avant 90 jours de données) |
| S2 < 25 %, usage pendant l'essai quasi nul dès la première semaine | Problème d'activation, pas de monétisation | Itération produit (onboarding, « moment wow ») — aucune option tarifaire |
| S1 < 5 % **et** S2 ≥ 25 % | Ceux qui entrent convertissent : le goulot est en amont (notoriété, fiche store, confiance) | **D** (amorçage) + travail fiche store/landing ; **A** en second |
| S3 > 8 %, motifs de résiliation : « je ne l'utilise plus » | Déficit d'habitude | Itération produit (rappels, North Star) ; **A** n'aide pas, **B** non plus |
| S3 > 8 %, motifs : « trop cher pour mon usage », churn concentré sur le mensuel | Rapport valeur/prix déséquilibré sur le mensuel | **B**, avec bascule incitée vers l'annuel |
| A puis B testées, S1 toujours < 5 % après 6 mois | Le modèle 100 % payant ne passe pas ce marché | **C** (périmètre exact du § 3, sans renégociation) |
| Tous les seuils au vert | Le pari premium est validé | Aucune option ; envisager le retour au prix cible (7,99/59,99 CHF) pour les **nouveaux** entrants uniquement (chapitre 10) |

---

*Ce plan est relu à la revue de lancement à +8 semaines (juin 2027, recommandation P2-10 du chapitre 12), puis à chaque revue trimestrielle. Un plan B qui n'est jamais activé est le meilleur des scénarios — mais il n'a de valeur que s'il est prêt avant d'être nécessaire.*
