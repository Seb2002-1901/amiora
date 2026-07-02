# AMIORA — Design system V1

* **Sprint 0 — Livrable 3**
* **Statut : NORMATIF — les valeurs de ce document sont figées**
* **Date : juillet 2026**

> Ce document transforme la direction artistique validée par le [PRD V1.2](../prd-v1.2.md) (section Design system) et consolidée par l'[audit design](../audit/05-design-system.md) en un système de valeurs exécutable. Toute valeur absente de ce document est une décision à soumettre, pas une liberté d'interprétation. Aucun écran ne doit contenir de valeur codée en dur : chaque couleur, rayon, espacement, durée ou taille de texte référence un token défini ici.

---

## 1. Principes

**Premium minimaliste.** L'élégance d'AMIORA repose sur la retenue : un fond noir profond, une seule couleur d'accent (l'or), de grandes cartes, de grands espaces, peu d'éléments par écran. Chaque ajout visuel doit se justifier ; le décor ne rivalise jamais avec les photos et les souvenirs de l'utilisateur, qui sont la vraie matière émotionnelle du produit.

**Émotion sans culpabilisation.** L'interface parle des personnes qui comptent : elle est chaleureuse, jamais anxiogène. Le rouge est réservé aux erreurs système et ne qualifie jamais une relation ni une personne. Les moments positifs (première interaction du jour, badge obtenu, promesse tenue) sont célébrés avec sobriété — de l'or, jamais du bruit.

**Accessible par construction.** Le thème sombre exige plus de rigueur, pas moins : chaque paire texte/fond de ce document est vérifiée au seuil WCAG AA minimum (4,5:1 pour le texte courant), les cibles tactiles font au moins 44 × 44 pt, l'agrandissement de police système est supporté, et la couleur ne porte jamais un sens à elle seule — elle est toujours doublée d'un libellé ou d'une icône.

**Sémantique d'abord.** Les tokens sont nommés par rôle (`surface.card`, `text.secondary`), jamais par apparence (`gris-clair`). Le thème sombre est le thème de lancement et le seul du périmètre V1 ; la discipline de nommage garantit qu'un futur thème clair reste un remplacement de table, pas une refonte.

---

## 2. Couleurs

### 2.1 Tokens sémantiques

Le thème sombre est le thème de lancement. La colonne « Light » est **préparatoire, hors périmètre V1** : elle fige l'intention pour un futur thème clair et devra être revalidée en outillage de contraste au moment de son développement.

| Token | Rôle | Dark (V1) | Light (préparatoire, hors périmètre V1) |
|---|---|---|---|
| `bg.base` | Fond d'écran | `#0B0B0D` | `#FAF8F3` |
| `surface.card` | Cartes, cellules, champs | `#1A1A1E` | `#FFFFFF` |
| `surface.raised` | Surfaces surélevées : bottom sheets, modales, menus, toasts | `#232329` | `#FFFFFF` (élévation par ombre) |
| `border.subtle` | Bordures et séparateurs | `#2E2E33` | `#E6E2D9` |
| `accent.gold` | Or de marque : textes et icônes actifs, traits, progression | `#D9B45B` | `#8A6D24` |
| `accent.gold-container` | Fond des boutons et éléments pleins or | `#D9B45B` | `#C7A24A` |
| `accent.gold-pressed` | Or à l'état pressé | `#B8963F` | `#B08A38` |
| `accent.on-gold` | Texte et icônes posés sur l'or | `#1A1405` | `#1A1405` |
| `text.primary` | Texte principal | `#F4F1E9` | `#1C1B17` |
| `text.secondary` | Méta-informations, sous-titres | `#A9A6A0` | `#5D5A52` |
| `text.disabled` | Texte et icônes désactivés | `#6E6C68` | `#9B978E` |
| `feedback.success` | Succès, confirmations | `#8BC49A` | `#2F7D4F` |
| `feedback.warning` | Alertes douces, relations à entretenir | `#E0A45C` | `#9A6414` |
| `feedback.error` | Erreurs système (icônes, gros titres, bordures) | `#C96A5E` | `#B04A3E` |
| `feedback.error-text` | Texte courant d'erreur (voir § 2.4) | `#DE8478` | `#B04A3E` |
| `overlay.modal` | Voile derrière modales et sheets | `rgba(0,0,0,0.6)` | `rgba(0,0,0,0.4)` |

En thème sombre, `accent.gold` et `accent.gold-container` partagent la même valeur ; la distinction existe parce qu'en thème clair l'or « texte » doit être assombri pour rester lisible (`#8A6D24`) alors que l'or « fond de bouton » reste proche de la marque (`#C7A24A`). Utiliser le bon token dès la V1 rend le thème clair gratuit.

### 2.2 États et opacités

| État | Règle | Valeur |
|---|---|---|
| Défaut | Token nominal | — |
| Pressé | Fond or → `accent.gold-pressed` ; surfaces → superposition `text.primary` à 8 % d'opacité | `#B8963F` / overlay 8 % |
| Désactivé | Élément entier à **40 % d'opacité** ; texte seul → `text.disabled` | opacité 0,40 |
| Focus (clavier / lecteur d'écran) | Anneau 2 px `accent.gold`, décalé de 2 px du bord de l'élément | `#D9B45B`, 2 px |
| Chargement | Skeleton (voir § 4.16), jamais de variation de couleur seule | — |

Les éléments désactivés sont exemptés des exigences de contraste WCAG, à une condition stricte : **un élément désactivé ne porte jamais d'information nécessaire à l'utilisateur**. Si l'information compte, l'élément n'est pas désactivé.

### 2.3 Le seul gradient autorisé

Un unique dégradé existe dans tout le produit, réservé aux **moments de célébration** (première interaction du jour, badge obtenu, promesse tenue, bande « Très entretenue » de l'Indice de présence) :

| Token | Définition |
|---|---|
| `gradient.gold-celebration` | Linéaire 135°, de `#E7C877` vers `#D9B45B` |

Règles : jamais en fond de texte courant (uniquement sous du texte ≥ 20 pt en graisse 600+, ou comme remplissage décoratif — barre, confetti, badge) ; jamais sur plus d'un élément par écran ; aucun autre dégradé n'est autorisé, nulle part.

### 2.4 Vérification de contraste (WCAG 2.1)

Ratios calculés selon la formule de luminance relative WCAG (arrondis à une décimale). Seuils : AA texte courant ≥ 4,5:1 ; AA texte large (≥ 18,5 px gras ou ≥ 24 px) ≥ 3:1 ; AAA texte courant ≥ 7:1.

| Paire | Ratio | Verdict | Usage autorisé |
|---|---|---|---|
| `text.primary` / `bg.base` | 17,4:1 | AAA | Tout texte |
| `text.primary` / `surface.card` | 15,4:1 | AAA | Tout texte |
| `text.primary` / `surface.raised` | 13,8:1 | AAA | Tout texte |
| `text.secondary` / `bg.base` | 8,1:1 | AAA | Tout texte |
| `text.secondary` / `surface.card` | 7,1:1 | AAA | Tout texte |
| `text.secondary` / `surface.raised` | 6,4:1 | AA | Tout texte |
| `accent.gold` / `bg.base` | 9,9:1 | AAA | Tout texte, y compris petit corps |
| `accent.gold` / `surface.card` | 8,8:1 | AAA | Tout texte, y compris petit corps |
| `accent.gold-pressed` / `bg.base` | 7,0:1 | AA (à la limite AAA) | État transitoire |
| `accent.on-gold` / `accent.gold` | 9,3:1 | AAA | Libellés de boutons or |
| `accent.on-gold` / `accent.gold-pressed` | 6,5:1 | AA | État pressé |
| `feedback.success` / `surface.card` | 8,6:1 | AAA | Tout texte |
| `feedback.warning` / `surface.card` | 8,0:1 | AAA | Tout texte |
| `feedback.error` / `bg.base` | 5,3:1 | AA | Texte courant |
| `feedback.error` / `surface.card` | 4,7:1 | AA | Texte courant |
| `feedback.error` / `surface.raised` | 4,3:1 | **Sous AA texte courant** | Icônes et texte large uniquement — texte courant interdit |
| `feedback.error-text` / `surface.raised` | 5,7:1 | AA | Tout texte — **correction obligatoire** |
| `feedback.error-text` / `surface.card` | 6,3:1 | AA | Tout texte |
| `feedback.error-text` / `bg.base` | 7,2:1 | AAA | Tout texte |
| `text.disabled` / `surface.card` | 3,3:1 | Exempté (inactif) | Éléments désactivés uniquement, jamais informatifs |

**Correction actée.** `feedback.error` (`#C96A5E`) tombe à 4,3:1 sur `surface.raised` — précisément la surface des modales et toasts où s'affichent les messages d'erreur. Le token `feedback.error-text` (`#DE8478`) est donc **obligatoire pour tout texte courant d'erreur**, sur toutes les surfaces ; `feedback.error` reste réservé aux icônes, bordures et textes larges. Cette paire était le seul échec de la palette : toutes les autres paires de texte courant sont AA, et la grande majorité AAA.

**Bordures et contraste non textuel.** `border.subtle` (1,3:1 sur carte) est volontairement discret : il est **décoratif**. Aucun composant ne doit être identifiable par cette bordure seule — les champs de saisie sont identifiés par leur remplissage `surface.card` et leur libellé, les cartes par leur fond. L'indicateur de focus (anneau or, 8,8:1) satisfait largement l'exigence non textuelle de 3:1 (WCAG 1.4.11).

### 2.5 Règle absolue : jamais la couleur seule

Aucune information n'est portée uniquement par la couleur. Chaque état coloré est doublé d'un libellé texte ou d'une icône : l'Indice de présence affiche toujours son libellé (« Bien entretenue »), une erreur de champ affiche toujours un message et une icône, un filtre actif change de remplissage *et* de graisse. Cette règle est un critère de recette, pas une recommandation.

---

## 3. Typographie

### 3.1 Police

**Police officielle : Inter (variable)**, embarquée dans l'application, identique sur iOS et Android.

* Licence SIL Open Font License — aucune contrainte commerciale.
* Fonte variable : toutes les graisses en un seul fichier, interpolation propre pour les animations de graisse.
* Excellente lisibilité en petit corps sur fond sombre, chiffres tabulaires natifs, large couverture des diacritiques françaises.

**Repli système** (si Inter ne peut être chargée) : SF Pro (iOS) / Roboto (Android). Le repli doit rester exceptionnel — la police fait partie de l'identité.

### 3.2 Échelle typographique

Tailles en points logiques ; interligne fixe faisant partie du token.

| Token | Taille / interligne | Graisse | Usage |
|---|---|---|---|
| `type.display` | 32 / 40 | 700 | Grand chiffre d'accueil, écrans de célébration, onboarding |
| `type.title` | 24 / 32 | 600–700 | Titres d'écran |
| `type.subtitle` | 20 / 28 | 600 | Titres de section, titres de cartes importantes |
| `type.body` | 16 / 24 | 400 (500 en emphase) | Texte courant, libellés de boutons (600), champs |
| `type.secondary` | 14 / 20 | 400 | Méta-informations, sous-titres de cellules |
| `type.caption` | 12 / 16 | 500 | Légendes, badges, libellés d'onglets |

### 3.3 Règles

* **Graisses autorisées : 400, 500, 600, 700.** Rien d'autre. Les titres sont toujours en 600 ou 700 ; le texte courant n'est jamais en dessous de 400.
* **Rien sous 12 pt**, nulle part, y compris dans les badges.
* **Chiffres tabulaires obligatoires pour toute statistique** (Indice de présence, compteurs, durées, XP) : `FontFeature.tabularFigures()` en Flutter. Les chiffres ne « sautent » jamais quand une valeur change.
* Les libellés de boutons sont en `type.body` graisse 600, jamais en capitales.
* Pas d'italique dans l'interface ; l'italique est réservé aux citations éditoriales (encarts bienveillants).

### 3.4 Dynamic Type / agrandissement système

Le support de l'agrandissement de police système est **obligatoire jusqu'à 130 % minimum** (`textScaleFactor` plafonné à 1,3 pour préserver les mises en page, jamais en dessous). Règles : les hauteurs de composants contenant du texte s'étirent (jamais de texte tronqué verticalement) ; les cartes passent en hauteur intrinsèque ; seuls le `type.display` et les éléments purement décoratifs peuvent être exclus de la mise à l'échelle. Tout écran est recetté à 130 % avant validation.

---

## 4. Espacements, rayons et élévation

### 4.1 Grille d'espacement — base 4 pt

Échelle unique : **4 / 8 / 12 / 16 / 20 / 24 / 32 / 40 / 48**. Toute marge, tout padding, tout écart provient de cette échelle.

| Usage | Valeur |
|---|---|
| Marges latérales d'écran | 20 |
| Écart entre cartes | 12 |
| Padding interne des cartes | 16 (grandes cartes : 20) |
| Écart titre de section → contenu | 12 |
| Écart entre sections | 32 |
| Écart icône → libellé | 8 |

### 4.2 Rayons

| Token | Valeur | Usage |
|---|---|---|
| `radius.card` | 24 px | Cartes, bottom sheets, modales, états vides |
| `radius.button` | 16 px | Boutons, toasts |
| `radius.field` | 12 px | Champs de saisie, cellules calendrier sélectionnées |
| `radius.pill` | 999 px | Pastilles, badges, tags, FAB, avatars, barres de progression |

### 4.3 Élévation

Sur fond sombre, l'élévation s'exprime d'abord par la **couleur de surface** (`bg.base` → `surface.card` → `surface.raised`), pas par l'ombre. Une seule ombre existe : `shadow.raised` = `0 8px 24px rgba(0,0,0,0.35)`, réservée aux éléments flottants (FAB, bouton + central, toasts).

---

## 5. Composants

Chaque composant est spécifié avec son anatomie, ses variantes, ses états et ses tokens. Les états standard — défaut, pressé, désactivé, focus — suivent le § 2.2 sauf mention contraire. Toutes les cibles tactiles font au moins 44 × 44 pt, même quand le dessin est plus petit.

### 5.1 Bouton

**Anatomie** : conteneur (`radius.button`), libellé `type.body` 600, icône optionnelle 20 px à gauche du libellé (écart 8).

**Dimensions** : hauteur 52 (standard) ou 44 (compact, dans les cartes) ; padding horizontal 24 ; pleine largeur par défaut dans les écrans de flux.

| Variante | Fond | Libellé | Bordure | Usage |
|---|---|---|---|---|
| **Primaire or** | `accent.gold-container` | `accent.on-gold` | — | Une seule par écran : l'action principale (« Enregistrer ») |
| **Secondaire contour** | transparent | `accent.gold` | 1 px `border.subtle` | Action alternative (« Annuler », « Plus tard ») |
| **Tertiaire texte** | transparent | `accent.gold` | — | Actions discrètes, liens d'action |
| **Destructif** | transparent | `feedback.error` | 1 px `feedback.error` | Suppression, archivage — jamais plein rouge |

**États** : pressé → primaire `accent.gold-pressed`, autres → overlay 8 % ; désactivé → 40 % d'opacité ; chargement → libellé remplacé par trois points animés (le bouton garde sa largeur), bouton non réactivable pendant l'opération.

**Accessibilité** : le libellé du bouton est son label lecteur d'écran ; un bouton en chargement annonce « en cours ».

### 5.2 Carte relation

Le composant central du produit.

**Anatomie** : conteneur `surface.card`, `radius.card`, padding 16 ; avatar rond 56 px (photo, ou initiales `accent.gold` sur `surface.raised`) ; prénom `type.body` 600 `text.primary` ; méta « Dernière interaction : il y a 5 jours » `type.secondary` `text.secondary` ; barre de progression de l'Indice de présence (§ 5.14) avec son libellé ; chevron `chevron-right` 20 px `text.secondary`.

**Variantes** : standard · compacte (hauteur 72, sans barre de progression, pour les listes de sélection) · **à raviver** (identique, libellé « À entretenir » + bande `feedback.warning` — pas de triangle d'alerte, pas de rouge, pas de compteur culpabilisant) · **En mémoire** (badge fleur `flower-2`, aucun indice affiché, aucune notification).

**États** : pressé (overlay 8 %) ; skeleton (§ 5.16).

**Accessibilité** : label = « {Prénom}, {libellé de l'indice}, dernière interaction il y a {n} jours ».

### 5.3 Carte générique

**Anatomie** : conteneur `surface.card`, `radius.card`, padding 16–20 ; en-tête optionnel (titre `type.subtitle` + action tertiaire à droite) ; contenu libre ; les images internes prennent `radius.field`.

**Variantes** : simple · média (photo pleine largeur en tête, coins supérieurs 24) · éditoriale (citation bienveillante, filet gauche 2 px `accent.gold`, texte en italique autorisé) · statistique (grand chiffre `type.display` chiffres tabulaires + libellé `type.secondary`).

### 5.4 Champ de saisie

**Anatomie** : libellé au-dessus `type.secondary` `text.secondary` ; conteneur hauteur 52, `surface.card`, `radius.field`, bordure 1 px `border.subtle` ; texte saisi `type.body` `text.primary` ; placeholder `text.disabled` (jamais porteur d'instruction indispensable) ; icônes optionnelles 20 px (gauche : contexte, droite : action — effacer, œil).

**Variantes** : texte · multiligne (hauteur libre, min 96) · sélection (chevron-down à droite, ouvre une bottom sheet — pas de menu déroulant flottant) · date (ouvre le sélecteur natif).

**États** : focus → bordure 2 px `accent.gold` ; erreur → bordure 2 px `feedback.error` + message sous le champ (`type.secondary`, `feedback.error-text`, icône `circle-alert` 16 px) ; désactivé → 40 %.

**Accessibilité** : le libellé est lié au champ ; le message d'erreur est annoncé au lecteur d'écran dès son apparition.

### 5.5 Bottom sheet

**Anatomie** : conteneur `surface.raised`, coins supérieurs `radius.card`, poignée 36 × 4 px `border.subtle` centrée (marge 8), titre optionnel `type.subtitle`, contenu, safe-area respectée ; voile `overlay.modal`.

**Comportement** : hauteur au contenu (max 90 % de l'écran) ; fermeture par glissement, par le voile, ou par bouton « Fermer » (obligatoire pour l'accessibilité) ; c'est le composant de sélection standard (types d'interaction, catégories, feuille de création du « + »).

### 5.6 Modale

Réservée aux **confirmations bloquantes** (suppression, déconnexion, fin d'essai). Tout le reste passe par une bottom sheet.

**Anatomie** : conteneur `surface.raised`, `radius.card`, largeur écran − 40, centré ; titre `type.subtitle` ; corps `type.body` `text.secondary` ; deux boutons maximum, empilés — action engageante en primaire ou destructif, « Annuler » en secondaire. Voile `overlay.modal`, non fermable par tap sur le voile quand l'action est irréversible.

### 5.7 Barre d'onglets

**Anatomie** : hauteur 64 + safe-area, fond `bg.base`, filet supérieur 1 px `border.subtle` ; **5 onglets : Accueil · Relations · + · Souvenirs · Profil** (ordre figé, conforme au PRD) ; item = icône 24 px + libellé `type.caption`.

**Bouton + central** : cercle 56 px `accent.gold-container`, icône `plus` 28 px `accent.on-gold`, `shadow.raised`, dépassant de 12 px au-dessus de la barre. Il ouvre la **feuille de création contextuelle** (interaction, souvenir, promesse, relation), l'onglet actif présélectionnant le type. C'est le seul « + » de l'application (voir § 5.8).

**États** : actif → icône et libellé `accent.gold` ; inactif → `text.secondary` ; jamais d'onglet désactivé.

**Accessibilité** : labels « Accueil », « Relations », « Ajouter », « Souvenirs », « Profil » ; état « sélectionné » annoncé.

### 5.8 FAB

Le FAB est **normalisé pour ne pas concurrencer le + central** : aucun écran doté de la barre d'onglets n'affiche de FAB. Le FAB n'existe que sur les écrans poussés sans barre d'onglets où une création contextuelle s'impose (ex. : ajout de photo dans un album).

**Anatomie** : cercle 56 px, `radius.pill`, `accent.gold-container`, icône 24 px `accent.on-gold`, `shadow.raised`, position bas-droite (marges 20), disparaît au défilement vers le bas, réapparaît au défilement vers le haut.

### 5.9 Pastille / badge

**Anatomie** : conteneur `radius.pill`, hauteur 20, padding horizontal 8, texte `type.caption`.

**Variantes** : compteur (fond `accent.gold-container`, texte `accent.on-gold`, max « 99+ ») · statut (fond `surface.raised`, texte de la couleur sémantique concernée, toujours accompagné d'un libellé) · point de nouveauté (8 px, `accent.gold`, toujours doublé d'une mention texte à proximité).

### 5.10 Tag / filtre

**Anatomie** : conteneur `radius.pill`, hauteur 36, padding horizontal 16, libellé `type.secondary`, icône optionnelle 16 px.

**États** : inactif → fond `surface.card`, bordure 1 px `border.subtle`, texte `text.secondary` ; **actif → fond `accent.gold-container`, texte `accent.on-gold` graisse 600** (le changement de graisse double le changement de couleur) ; pressé → overlay 8 %.

**Comportement** : rangée défilante horizontale, marge 20 en entrée, écart 8 ; sélection simple ou multiple selon le contexte, annoncée au lecteur d'écran (« filtre Photos, activé »).

### 5.11 Notification in-app (toast)

**Anatomie** : conteneur `surface.raised`, `radius.button`, `shadow.raised`, padding 12–16 ; icône 20 px (couleur sémantique) ; message `type.secondary` `text.primary`, deux lignes max ; action tertiaire optionnelle (« Annuler »).

**Variantes** : succès (`circle-check`, `feedback.success`) · information (`info`, `accent.gold`) · erreur (`circle-alert`, `feedback.error` — texte en `feedback.error-text` si le message est coloré).

**Comportement** : apparition en bas (au-dessus de la barre d'onglets), disparition automatique après 4 s (persistante si elle porte une action « Annuler » de suppression) ; une seule à la fois ; annoncée au lecteur d'écran sans voler le focus.

### 5.12 Cellule calendrier

**Anatomie** : cellule 44 × 44 pt ; chiffre du jour `type.body` chiffres tabulaires ; jusqu'à 3 points d'événements 4 px sous le chiffre (`accent.gold` anniversaires/dates importantes, `text.secondary` autres — la vue détail liste toujours les événements en texte).

**États** : jour courant → cercle bordure 1,5 px `accent.gold`, chiffre `accent.gold` ; sélectionné → disque `accent.gold-container`, chiffre `accent.on-gold` ; hors mois → chiffre `text.disabled` ; avec événements → points visibles.

**Accessibilité** : label = « {jour} {mois}, {n} événements » ; navigation jour par jour au lecteur d'écran.

### 5.13 Barre de progression — Indice de présence

Un seul composant paramétrable pour l'indice, la progression du cercle et l'XP.

**Anatomie** : rail hauteur 8 px, `radius.pill`, fond `border.subtle` ; remplissage animé (220 ms, easeOutCubic) ; **libellé texte obligatoire** à proximité immédiate (`type.secondary`), valeur numérique en chiffres tabulaires.

**Les quatre bandes de l'Indice de présence** (libellés PRD, figés — le rouge est proscrit) :

| Plage | Libellé | Couleur de remplissage |
|---|---|---|
| 90–100 | Très entretenue | `accent.gold` (ou `gradient.gold-celebration`) |
| 75–89 | Bien entretenue | `feedback.success` |
| 50–74 | À entretenir | `feedback.warning` |
| 0–49 | Peu entretenue | `text.secondary` |

**Jamais de rouge, jamais de vocabulaire anxiogène** (« danger », « négligée » sont interdits par le PRD). La couleur est toujours doublée du libellé. Variante circulaire (cercle du tableau de bord) : mêmes règles, trait 8 px, valeur au centre en `type.display`.

### 5.14 État vide

Chaque liste principale (Accueil jour 1, Relations, Souvenirs, Promesses, Calendrier, Ligne de vie) possède un état vide dessiné — c'est le premier écran que voit chaque nouvel utilisateur.

**Anatomie** : illustration au trait or (style du logo : trait fin 1,5–2 px, `accent.gold`, 96–120 px) ; titre `type.subtitle` `text.primary` ; texte d'invitation `type.body` `text.secondary`, deux lignes max, ton bienveillant (« Vos souvenirs vivront ici ») ; **bouton d'action primaire** menant directement à la création. Centré verticalement dans la zone de contenu.

### 5.15 Chargement (skeleton)

**Jamais de spinner plein écran.** Le chargement reproduit la géométrie de l'écran cible : blocs `surface.raised` aux rayons des composants réels (cartes 24, avatars 999, lignes de texte 4), animation de pulsation d'opacité 0,6 → 1,0 sur 1 200 ms (désactivée si « réduire les animations »). Un indicateur circulaire discret (24 px, `accent.gold`) est toléré uniquement en pied de liste (pagination) et dans les boutons.

### 5.16 État d'erreur

**Anatomie** : icône `circle-alert` 48 px `feedback.error` ; titre `type.subtitle` (« Une erreur est survenue ») ; message `type.body` `feedback.error-text` ou `text.secondary`, exprimé en langage humain, sans code technique ; **bouton « Réessayer »** secondaire. En variante de champ : voir § 5.4. Les erreurs ne culpabilisent jamais l'utilisateur et proposent toujours une issue.

### 5.17 État hors-ligne

Le hors-ligne est un mode de fonctionnement, pas une erreur (le PRD garantit création et consultation sans réseau).

**Anatomie** : bandeau discret sous l'en-tête — fond `surface.raised`, icône `cloud-off` 16 px, texte `type.caption` `text.secondary` : « Hors ligne — vos modifications seront synchronisées ». Aucun voile bloquant, aucune modale. Au retour du réseau, le bandeau devient « Synchronisation… » puis disparaît ; les actions réellement impossibles hors ligne (export, paiement) affichent l'état d'erreur § 5.16 avec un message explicite.

---

## 6. Iconographie

### 6.1 Pack officiel : Lucide

**Bibliothèque officielle : [Lucide](https://lucide.dev)** (paquet `lucide_flutter` / actifs SVG).

* **Trait fin cohérent avec le logo** : les icônes Lucide sont dessinées au trait 2 px sur grille 24, dans l'esprit exact du double cœur au trait fin doré de la marque.
* **Licence ISC** (permissive), aucune redevance, usage commercial libre.
* Plus de 1 500 glyphes, couverture complète des besoins V1, cohérence géométrique stricte.

**Réglages normatifs** : tailles **20 / 24 / 28 px** (20 dans les cellules et champs, 24 par défaut et dans la barre d'onglets, 28 pour le + central et les en-têtes) ; épaisseur de trait **1,5 à 2 px** (1,5 en taille 20, 2 en 24 et 28) ; couleur via tokens uniquement (`text.secondary` par défaut, `accent.gold` actif, couleurs sémantiques en feedback).

**Les émojis sont réservés au contenu saisi par l'utilisateur** (titres de souvenirs, notes) et sont **interdits dans l'interface** : navigation, catégories, types d'interaction et actions utilisent exclusivement Lucide. Cette règle rembourse la dette identifiée par l'audit (rendu non maîtrisé, dissonance premium, sémantique fragile, stéréotypes des émojis de personnes).

### 6.2 Table des glyphes V1 (~40)

| Fonction | Glyphe Lucide | | Fonction | Glyphe Lucide |
|---|---|---|---|---|
| **Navigation** | | | **Domaine** | |
| Accueil | `house` | | Anniversaire | `cake` |
| Relations | `users` | | Calendrier | `calendar-days` |
| Ajouter (central) | `plus` | | Promesse | `handshake` |
| Souvenirs | `book-heart` | | Souvenir / journal | `notebook-pen` |
| Profil | `circle-user-round` | | Ligne de vie | `milestone` |
| **Types d'interaction** | | | Capsule temporelle | `hourglass` |
| Appel | `phone` | | En mémoire | `flower-2` |
| Message | `message-circle` | | Badge / défi | `trophy` |
| Repas | `utensils` | | Statistiques | `chart-line` |
| Sortie | `ticket` | | Premium | `gem` |
| Voyage | `plane` | | Historique | `history` |
| Visite | `door-open` | | **Système** | |
| Cadeau | `gift` | | Notifications | `bell` |
| Moment ensemble | `heart-handshake` | | Paramètres | `settings` |
| Photo souvenir | `camera` | | Recherche | `search` |
| Événement important | `star` | | Succès | `circle-check` |
| **Actions** | | | Information | `info` |
| Modifier | `pencil` | | Erreur | `circle-alert` |
| Supprimer | `trash-2` | | Hors ligne | `cloud-off` |
| Archiver | `archive` | | Synchronisation | `refresh-cw` |
| Exporter | `download` | | Sécurité | `shield-check` |
| Filtrer | `sliders-horizontal` | | Confidentialité | `lock` |
| Valider | `check` | | Voir / masquer | `eye` / `eye-off` |
| Fermer | `x` | | Lieu | `map-pin` |
| Retour | `arrow-left` | | Durée | `clock` |
| Ouvrir (chevron) | `chevron-right` | | Email | `mail` |
| Déconnexion | `log-out` | | Célébration | `party-popper` |

Tout besoin de glyphe hors de cette table est une demande d'évolution du design system, pas un choix d'écran. Les icônes « cœur » (`heart`) sont réservées à la catégorie Partenaire et ne servent jamais à autre chose — l'audit a relevé trois sens différents pour ❤️ dans les maquettes ; cette ambiguïté est levée.

---

## 7. Animations et haptique

### 7.1 Durées et courbes

| Token | Durée | Usage |
|---|---|---|
| `motion.fast` | 150 ms | Retours pressés, bascules, cases, changements d'état locaux |
| `motion.standard` | 220 ms | Transitions d'écrans, apparition de sheets et modales, remplissage des barres |
| `motion.expressive` | 350 ms | Moments émotionnels uniquement : célébration, ouverture d'une capsule, révélation d'un badge |

**Courbe standard : easeOutCubic** (`Curves.easeOutCubic`) pour toute entrée ; easeInCubic pour les sorties ; easeInOutCubic pour les déplacements sur place. Aucune animation « lente » sur les actions fréquentes : la consigne historique « transitions lentes » est explicitement remplacée par « rapide par défaut, expressif réservé aux célébrations ».

### 7.2 Transitions d'écrans

* Push (ouvrir une fiche) : glissement horizontal + fondu, 220 ms ; geste retour natif respecté sur les deux plateformes.
* Bottom sheet : montée depuis le bas, 220 ms, voile en fondu synchronisé.
* Modale : fondu + échelle 0,96 → 1, 220 ms.
* Changement d'onglet : fondu croisé 150 ms, sans glissement.

### 7.3 Haptique

Sobre et signifiante — jamais décorative :

| Moment | Retour |
|---|---|
| Enregistrement d'une interaction (le geste central du produit) | Impact léger (`HapticFeedback.lightImpact`) |
| Première interaction du jour (célébration) | Notification de succès (`HapticFeedback.mediumImpact` unique) |
| Sélection dans une liste ou un sélecteur | Tick de sélection |
| Erreur bloquante | Vibration d'erreur système, une seule |

### 7.4 Célébration discrète

À la **première interaction enregistrée du jour** : pluie de confettis or sobre — 12 à 18 particules maximum, formes simples (points et traits fins), couleurs limitées à `accent.gold` et `#E7C877` (les deux teintes du gradient), 350 ms d'émission, retombée douce, aucun son. Une fois par jour, jamais empilée avec une autre animation. Même mécanique, plus courte, pour un badge obtenu.

### 7.5 « Réduire les animations »

Le réglage système (iOS Reduce Motion / Android « Supprimer les animations ») est **respecté intégralement** : les transitions deviennent des fondus de 150 ms sans déplacement, la pulsation des skeletons est figée, les confettis sont remplacés par une simple apparition en fondu du message de célébration, l'haptique est conservée (elle ne relève pas de ce réglage).

---

## 8. Accessibilité — synthèse normative

1. **Contraste** : AA minimum (4,5:1 texte courant, 3:1 texte large et éléments d'interface signifiants) sur toutes les paires ; les valeurs de ce document sont vérifiées (§ 2.4) et tout ajout de couleur repasse par l'outillage de contraste avant intégration.
2. **Cibles tactiles** : 44 × 44 pt minimum, y compris pour les éléments dessinés plus petits (chevrons, points du calendrier, croix de fermeture) — la zone tactile déborde du dessin.
3. **Couleur jamais seule** (§ 2.5) : libellé ou icône systématique — critère de recette bloquant.
4. **Lecteurs d'écran** : chaque composant du § 5 embarque son label dans sa spécification ; les images de l'utilisateur reçoivent une description saisie ou un libellé générique daté (« Photo du 5 mars 2026 avec Emma ») ; les toasts sont annoncés sans vol de focus ; l'ordre de lecture suit l'ordre visuel.
5. **Tailles dynamiques** : agrandissement système supporté jusqu'à 130 % minimum, recette de chaque écran à 130 % (§ 3.4).
6. **Focus visible** : anneau or 2 px sur tout élément interactif navigable au clavier ou au commutateur.
7. **Réduire les animations** : respecté intégralement (§ 7.5).

---

## Annexe — Récapitulatif des tokens non chromatiques

| Famille | Tokens |
|---|---|
| Espacement | 4 / 8 / 12 / 16 / 20 / 24 / 32 / 40 / 48 |
| Rayons | card 24 · button 16 · field 12 · pill 999 |
| Typographie | display 32/40 · title 24/32 · subtitle 20/28 · body 16/24 · secondary 14/20 · caption 12/16 — graisses 400/500/600/700 |
| Icônes | 20 / 24 / 28 px — trait 1,5–2 px — Lucide |
| Motion | fast 150 ms · standard 220 ms · expressive 350 ms — easeOutCubic |
| Élévation | bg.base → surface.card → surface.raised · shadow.raised 0 8 24 rgba(0,0,0,0.35) |
| Tactile | cible minimale 44 × 44 pt |

Ce document est la référence unique du Sprint 0 pour tout développement d'interface. Toute dérogation est un arbitrage à consigner ici, jamais une décision locale d'écran.
