/// Bandes d'affichage de l'Indice de présence (PRD V1.2).
/// Terminologie interdite : « danger », « toxique », « négligée »,
/// « mauvaise relation » — jamais dans l'interface ni dans le code visible.
library;

enum PresenceBand { veryNurtured, wellNurtured, toNurture, littleNurtured }

PresenceBand presenceBand(int score) {
  if (score >= 90) return PresenceBand.veryNurtured;
  if (score >= 75) return PresenceBand.wellNurtured;
  if (score >= 50) return PresenceBand.toNurture;
  return PresenceBand.littleNurtured;
}

String presenceBandLabel(PresenceBand band) => switch (band) {
      PresenceBand.veryNurtured => 'Très entretenue',
      PresenceBand.wellNurtured => 'Bien entretenue',
      PresenceBand.toNurture => 'À entretenir',
      PresenceBand.littleNurtured => 'Peu entretenue',
    };
