# Livrable 1 — Formule définitive de l'Indice de présence

* **Statut :** spécification normative, prête à implémenter.
* **Exigence :** la formule est **déterministe** — deux implémentations indépendantes qui reçoivent les mêmes données doivent produire exactement le même résultat.
* **Référence produit :** [PRD V1.2](../prd-v1.2.md) (pondérations officielles, échelle, terminologie).

## 1. Principes

1. **Échelle 0-100**, affichée en quatre bandes (90-100 « Très entretenue », 75-89 « Bien entretenue », 50-74 « À entretenir », 0-49 « Peu entretenue »).
2. **Privé et unilatéral** : jamais partagé, jamais envoyé aux proches, jamais comparé publiquement.
3. **Bienveillant par construction** : décroissance progressive (jamais de chute brutale), plancher pour les relations ayant existé, tolérance à la sous-saisie (chute plafonnée à ~8 points par semaine), démarrage neutre pour les nouvelles relations.
4. **Relatif à la relation** : chaque relation a une **cadence attendue** `P` (en jours) qui règle toutes les fenêtres de calcul. On n'évalue pas un mentor comme un partenaire.
5. **Calcul local** : le score se calcule sur l'appareil, à partir des données locales (architecture hors-ligne d'abord). Le serveur n'est pas nécessaire au calcul.

## 2. Paramètres

### 2.1 Cadence attendue `P` (jours)

Valeur par défaut selon la catégorie, **modifiable par relation** par l'utilisateur (bornes : 1 à 365) :

| Catégorie | `P` par défaut |
|---|---|
| Partenaire (`partner`) | 2 |
| Enfant (`child`) | 3 |
| Famille (`family`) | 7 |
| Ami (`friend`) | 14 |
| Mentor (`mentor`) | 30 |
| Professionnel (`professional`) | 30 |
| Autres (`other`) | 30 |

### 2.2 Durées par défaut (minutes)

Quand `duration_minutes` n'est pas renseigné sur une interaction, la durée effective vaut :

| Type | Durée par défaut |
|---|---|
| `call` (appel) | 15 |
| `message` | 2 |
| `meal` (repas) | 90 |
| `outing` (sortie) | 180 |
| `visit` (visite) | 120 |
| `trip` (voyage) | 600 |
| `gift` (cadeau) | 15 |
| `moment` (moment ensemble) | 60 |
| `photo` (photo souvenir) | 5 |
| `event` (événement important) | 180 |

### 2.3 Objectif de temps ensemble (minutes / 90 jours)

| Catégorie | Objectif `T_target` |
|---|---|
| Partenaire | 1 800 (30 h) |
| Enfant | 1 200 (20 h) |
| Famille | 600 (10 h) |
| Ami | 360 (6 h) |
| Mentor / Professionnel / Autres | 120 (2 h) |

### 2.4 Conventions de calcul

* Toutes les durées en **jours** sont calculées dans le **fuseau horaire local de l'utilisateur**, frontières de jour à minuit local. `d(a, b)` = nombre de jours entiers entre deux instants.
* `now` = l'instant du calcul ; `today` = minuit local du jour courant.
* Seules les données **non supprimées** (`deleted_at IS NULL`) entrent dans le calcul.
* Une interaction est datée par `occurred_at` et doit être **dans le passé** (les activités futures sont des événements de calendrier, pas des interactions).
* Une interaction **multi-personnes compte à part entière** pour chaque participant (pas de dilution).
* `age_days` = jours entiers écoulés depuis `relationship.created_at`.

## 3. Les six composantes

Chaque composante est un réel dans **[0, 1]**.

### 3.1 `F` — Dernière interaction (poids 35 %)

`d` = jours depuis l'interaction la plus récente ; s'il n'y a **aucune** interaction, l'ancre est `created_at` de la relation.

```
F = 1                          si d ≤ P
F = 0.5 ^ ((d − P) / (2·P))    si d > P
```

Lecture : période de grâce d'une cadence, puis **demi-vie de deux cadences**. À `d = 3P`, `F = 0,5` ; à `d = 5P`, `F = 0,25` ; à `d = 7P`, `F = 0,125`.

### 3.2 `R` — Régularité (poids 25 %)

On observe les `n` dernières périodes de longueur `P` : fenêtre `k` = `[today − k·P, today − (k−1)·P)` pour `k = 1..n`, avec `n = min(8, max(1, floor(age_days / P)))`.

`hits` = nombre de fenêtres contenant **au moins une** interaction.

```
R = 0.6            si age_days < P   (a priori neutre)
R = hits / n       sinon
```

### 3.3 `T` — Temps passé ensemble (poids 15 %)

`minutes_90` = somme des durées effectives (§ 2.2) des interactions des 90 derniers jours.

Facteur de jeunesse : `w = min(90, max(age_days, 14)) / 90`.

```
T = min(1, minutes_90 / (T_target × w))
```

### 3.4 `Pc` — Promesses (poids 10 %)

Population : promesses de la relation dont `due_date` est dans `[today − 180 j, today]`.
`kept` = celles au statut `done`.

```
Pc = 0.7                 si population = 0   (neutre : pas de promesse ≠ pénalité)
Pc = kept / population   sinon
```

Une promesse échue non terminée (`due_date < today`, statut ≠ `done`) compte dans la population et pas dans `kept`.

### 3.5 `S` — Souvenirs (poids 10 %)

`memories_90` = souvenirs (photos, notes) liés à la relation et créés dans les 90 derniers jours.

```
S = min(1, memories_90 / max(1, 3 × w))      (même w qu'en 3.3)
```

### 3.6 `D` — Dates importantes (poids 5 %)

Occurrence la plus récente d'une date importante de la relation dans les 365 derniers jours (les dates récurrentes — anniversaires — comptent par leur dernière occurrence).

```
D = 0.7   si aucune occurrence depuis la création de la relation   (neutre)
D = 1     si ≥ 1 interaction dans [occurrence − 3 j, occurrence + 3 j]
D = 0.4   sinon
```

## 4. Assemblage, arrondi, plancher

```
raw = 100 × (0.35·F + 0.25·R + 0.15·T + 0.10·Pc + 0.10·S + 0.05·D)

IP_calc = clamp(round_half_up(raw), 0, 100)
IP_calc = max(IP_calc, 15)   si la relation a eu ≥ 1 interaction dans sa vie
```

Le plancher de 15 garantit qu'une relation qui a existé ne tombe jamais à zéro — l'application invite, elle n'enterre pas.

### 4.1 Période de découverte (14 premiers jours)

Pendant les **14 jours** suivant la création de la relation :

* si la relation n'a **aucune interaction**, on n'affiche **pas de chiffre** : pastille « **Nouvelle relation** » ;
* sinon, chaque composante **autre que `F`** est bornée en dessous par **0,6** (`x = max(x, 0.6)`), pour que le premier score soit neutre-positif et non punitif.

### 4.2 Chute plafonnée (tolérance à la sous-saisie)

Le score **affiché** est lissé à partir des instantanés quotidiens (table `presence_scores`) :

```
IP_display(today) = max( IP_calc(today),
                         IP_display(dernier instantané) − 1.2 × jours_écoulés )
```

* Les **hausses sont instantanées** (`IP_calc > affiché` → on affiche `IP_calc`).
* Les baisses sont plafonnées à **1,2 point/jour** (~8 points/semaine) : un utilisateur qui oublie de saisir pendant ses vacances ne retrouve pas un tableau de bord effondré.
* L'affichage est arrondi à l'entier.

### 4.3 Cercle global

`Cercle = round( moyenne des IP_display des relations au statut active )`. Les relations `archived` et `in_memoriam` sont exclues. Aucun affichage si aucune relation active.

## 5. Cas particuliers (normatif)

| Cas | Règle |
|---|---|
| **Relation créée aujourd'hui, sans interaction** | Pastille « Nouvelle relation », pas de chiffre (§ 4.1). |
| **Relation créée aujourd'hui, avec une interaction** | Calcul normal avec bornes de découverte : premier score ≈ 75-80 (« Bien entretenue »), voir exemple 4. |
| **Relation sans aucune interaction (> 14 jours)** | Calcul normal, `F` ancré sur `created_at` : le score décroît doucement, sans plancher (le plancher exige ≥ 1 interaction). |
| **Relation archivée (`archived`)** | Score **gelé** à sa valeur du jour d'archivage. Exclue du cercle, des notifications et des listes « à entretenir ». |
| **Relation « En mémoire » (`in_memoriam`)** | Identique à l'archivage : score gelé, jamais recalculé, aucune notification. Le score n'est plus mis en avant dans l'interface. |
| **Désarchivage** | La relation ré-entre en **période de découverte** (14 jours, § 4.1) et `F` est ancré sur `max(dernière interaction, date de désarchivage)`. On ne punit pas une pause. |
| **Données supprimées** | Le calcul ne lit que les données vivantes : toute suppression (interaction, souvenir, promesse) entraîne un **recalcul complet** depuis les données restantes. La baisse éventuelle est amortie par § 4.2. Aucune contribution supprimée n'est mémorisée. |
| **Nouvelle interaction** | Recalcul **immédiat** de la relation concernée (et du cercle). La hausse s'affiche instantanément. |
| **Interaction antidatée** | Autorisée (rattrapage de saisie) : `occurred_at` dans le passé, recalcul complet — le déterminisme est préservé puisque tout est recalculé depuis les données. |
| **Changement de cadence `P` ou de catégorie** | Recalcul immédiat avec les nouveaux paramètres. Pas d'effet rétroactif mémorisé. |
| **Changement de fuseau horaire** | Les frontières de jour suivent le fuseau local courant ; les instantanés passés ne sont pas réécrits. |

## 6. Déclencheurs de calcul

1. **Événementiel** : toute mutation (création/modification/suppression d'interaction, souvenir, promesse, date importante ; changement de cadence/catégorie/statut) recalcule immédiatement la relation touchée.
2. **Quotidien** : à la première ouverture du jour (et par tâche planifiée à minuit local si l'app tourne), recalcul de toutes les relations actives pour appliquer la décroissance, puis écriture de l'instantané du jour dans `presence_scores` (`relationship_id`, `date`, `score_calc`, `score_display`, composantes).

## 7. Pseudo-code de référence

```pseudo
function computePresenceScore(rel, data, today) -> {display: int, calc: int} | NEW_RELATION:
    P        = rel.cadence_days                      # défaut selon catégorie (§2.1)
    age      = daysBetween(rel.created_at, today)
    inters   = data.interactions(rel, deleted=false, occurred_at <= now)

    if age < 14 and inters.isEmpty():
        return NEW_RELATION                          # pastille, pas de chiffre

    # --- F : fraîcheur (ancre = dernière interaction, sinon création)
    anchor = inters.isEmpty() ? rel.created_at : max(inters.occurred_at)
    d = daysBetween(anchor, today)
    F = d <= P ? 1.0 : pow(0.5, (d - P) / (2.0 * P))

    # --- R : régularité sur n périodes de P jours
    n = min(8, max(1, floor(age / P)))
    if age < P:
        R = 0.6
    else:
        hits = count k in 1..n where inters.anyIn([today - k*P, today - (k-1)*P))
        R = hits / n

    # --- T : temps ensemble sur 90 jours
    w = min(90, max(age, 14)) / 90.0
    minutes90 = sum(effectiveDuration(i) for i in inters if i.occurred_at >= today - 90d)
    T = min(1.0, minutes90 / (targetMinutes(rel.category) * w))

    # --- Pc : promesses échues sur 180 jours
    pop  = promises(rel, due_date in [today - 180d, today])
    Pc   = pop.isEmpty() ? 0.7 : count(pop, status == done) / pop.size()

    # --- S : souvenirs sur 90 jours
    m90 = count(memories(rel, created_at >= today - 90d, deleted=false))
    S   = min(1.0, m90 / max(1.0, 3.0 * w))

    # --- D : dernière date importante (± 3 jours)
    occ = lastImportantDateOccurrence(rel, within 365d, since rel.created_at)
    if occ is null:            D = 0.7
    elif inters.anyIn([occ - 3d, occ + 3d]):  D = 1.0
    else:                      D = 0.4

    # --- Période de découverte : bornes basses
    if age < 14:
        R = max(R, 0.6); T = max(T, 0.6); Pc = max(Pc, 0.6)
        S = max(S, 0.6); D = max(D, 0.6)

    raw  = 100 * (0.35*F + 0.25*R + 0.15*T + 0.10*Pc + 0.10*S + 0.05*D)
    calc = clamp(roundHalfUp(raw), 0, 100)
    if not inters.isEmpty(): calc = max(calc, 15)

    # --- Chute plafonnée
    prev = lastSnapshot(rel)                          # peut être null
    if prev is null or calc >= prev.display:
        display = calc
    else:
        display = roundHalfUp(max(calc, prev.display - 1.2 * daysBetween(prev.date, today)))

    return {display, calc}
```

## 8. Exemples chiffrés (vecteurs de test)

Les exemples utilisent des historiques plausibles ; ils reproduisent l'esprit des anciennes maquettes à quelques points près. **Le jeu de démonstration canonique doit être régénéré par cette formule** (les valeurs des maquettes de 2026 étaient illustratives et non calculées).

### Exemple 1 — Emma, partenaire (`P = 2`), relation ancienne

Dernier message aujourd'hui ; interactions dans 7 des 8 dernières fenêtres de 2 jours ; 2 100 min ensemble sur 90 j ; aucune promesse échue sur 180 j ; 4 souvenirs sur 90 j ; anniversaire de rencontre il y a 40 j avec un dîner le jour même.

| Comp. | Valeur | Contribution |
|---|---|---|
| F | d = 0 ≤ 2 → **1,000** | 35,00 |
| R | 7/8 = **0,875** | 21,88 |
| T | min(1, 2100/1800) = **1,000** | 15,00 |
| Pc | population 0 → **0,700** | 7,00 |
| S | min(1, 4/3) = **1,000** | 10,00 |
| D | interaction à ± 3 j → **1,000** | 5,00 |

`raw = 93,88` → **IP = 94** — « Très entretenue ». ✔ (valeur maquette : 94)

### Exemple 2 — Papa, famille (`P = 7`), dernier appel il y a 21 jours

Interactions dans 5 des 8 fenêtres de 7 j ; 540 min sur 90 j (objectif 600) ; 1 promesse échue tenue ; 2 souvenirs sur 90 j ; fête récente sans interaction à ± 3 j.

| Comp. | Valeur | Contribution |
|---|---|---|
| F | d = 21 : 0,5^((21−7)/14) = 0,5^1 = **0,500** | 17,50 |
| R | 5/8 = **0,625** | 15,63 |
| T | 540/600 = **0,900** | 13,50 |
| Pc | 1/1 = **1,000** | 10,00 |
| S | 2/3 = **0,667** | 6,67 |
| D | occurrence sans interaction → **0,400** | 2,00 |

`raw = 65,30` → **IP = 65** — « À entretenir ». (maquette : 67 — écart de 2 points, plausible)

### Exemple 3 — Thomas, ami (`P = 14`), dernière sortie il y a 76 jours

1 seule fenêtre touchée sur 8 ; 180 min sur 90 j (objectif 360) ; aucune promesse ; aucun souvenir récent ; anniversaire il y a 30 j sans interaction.

| Comp. | Valeur | Contribution |
|---|---|---|
| F | d = 76 : 0,5^((76−14)/28) = 0,5^2,214 = **0,215** | 7,54 |
| R | 1/8 = **0,125** | 3,13 |
| T | 180/360 = **0,500** | 7,50 |
| Pc | population 0 → **0,700** | 7,00 |
| S | 0/3 = **0,000** | 0,00 |
| D | occurrence sans interaction → **0,400** | 2,00 |

`raw = 27,17` → `IP_calc = 27` (≥ plancher 15). Le score **affiché** peut être supérieur si la baisse est en cours d'amortissement (§ 4.2). — « Peu entretenue ».

### Exemple 4 — Relation créée aujourd'hui avec un repas enregistré (partenaire, `P = 2`)

`F = 1` (35,00) ; découverte → `R = 0,6` (15,00) ; `T` : w = 14/90, objectif 280 min, repas 90 min → 0,321 borné à **0,6** (9,00) ; `Pc = 0,7` (7,00) ; `S = 0,6` (6,00) ; `D = 0,7` (3,50).

`raw = 75,50` → **IP = 76** — « Bien entretenue ». Une nouvelle relation démarre neutre-positif, jamais dans le rouge.

### Exemple 5 — Relation jamais alimentée (mentor, `P = 30`), créée il y a 60 jours

`F` ancré sur la création : d = 60 → 0,5^(30/60) = 0,7071 (24,75) ; `R` : n = 2, hits = 0 → 0 ; `T = 0` ; `Pc = 0,7` (7,00) ; `S = 0` ; `D = 0,7` (3,50).

`raw = 35,25` → **IP = 35** (pas de plancher : aucune interaction n'a jamais eu lieu).

## 9. Vecteurs de test unitaires obligatoires

L'implémentation doit inclure au minimum les tests suivants (mêmes entrées → mêmes sorties exactes) :

1. Les exemples 1 à 5 ci-dessus (valeurs exactes de chaque composante et du score).
2. `F` aux points remarquables : d = P → 1 ; d = 3P → 0,5 ; d = 5P → 0,25.
3. Plancher : relation avec une interaction il y a 400 jours → `IP_calc = 15`.
4. Chute plafonnée : affiché 80 hier, calculé 60 aujourd'hui → affiché 78,8 → 79 ; calculé 85 aujourd'hui → affiché 85.
5. Archivage : score gelé, exclu du cercle ; désarchivage : période de découverte réappliquée.
6. Suppression de la dernière interaction → recalcul avec l'ancre précédente.
7. Interaction multi-personnes → créditée intégralement à chaque relation participante.
8. `round_half_up(0,5) = 1` (et non arrondi bancaire) — à verrouiller par test dans les deux langages (Dart, SQL/PLpgSQL si un recalcul serveur est un jour ajouté).
