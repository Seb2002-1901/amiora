# PARCOURS PRINCIPAL COMPLET — démonstration filmée.
c() { xdotool mousemove $1 $2 click 1; sleep ${3:-1.4}; }
t() { xdotool type --delay 45 "$1"; sleep 0.8; }
sleep 1.5                                  # accueil vide (état jour 1)
c 210 518 1.8                              # « Ajouter une personne »
t "Papa"; sleep 0.6
c 210 651 2.2                              # Enregistrer → accueil (Nouvelle relation)
c 210 868 1.6                              # + central → geste
c 40 384 0.8                               # Papa
c 61 508 0.8                               # Appel
c 210 860 2.4                              # Enregistrer → indice apparaît
c 210 868 1.4                              # + de nouveau
c 40 384 0.7; c 259 508 0.7                # Papa · Repas
c 210 860 2.2
c 294 875 1.6                              # Souvenirs
c 210 327 1.6                              # Ajouter un souvenir
c 210 657 0.7; t "Papa m'a raconte son enfance."
c 50 740 0.7                               # puce Papa
c 210 797 2.2                              # Enregistrer souvenir
c 378 875 1.6                              # Profil
c 210 385 1.8                              # Promesses
c 396 28 1.6                               # + (barre)
t "Aller voir Papa dimanche"; sleep 0.6
c 50 730 0.8                               # puce Papa (estimé)
c 210 850 2.2                              # Enregistrer promesse (estimé)
c 47 192 1.6                               # cocher la promesse (estimé)
c 340 160 2.0                              # segment Terminées (estimé)
c 24 28 1.4                                # retour
c 42 875 1.8                               # Accueil
c 210 258 2.8                              # carte Papa → fiche
c 210 640 2.0                              # « Archiver ou mettre en mémoire »
c 210 768 2.4                              # « Mettre en mémoire »
c 378 875 1.4                              # Profil
c 210 505 1.8                              # En mémoire
c 210 104 3.2                              # carte Papa → mémorial
