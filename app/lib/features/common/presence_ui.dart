import 'package:flutter/material.dart';

import '../../core/theme/tokens.dart';
import '../../domain/entities/entities.dart' as domain;
import '../../domain/presence/presence_bands.dart';

/// Couleur d'une bande de l'Indice — jamais de rouge (design system § 5.13).
Color bandColor(PresenceBand band) => switch (band) {
      PresenceBand.veryNurtured => AmioraColors.gold,
      PresenceBand.wellNurtured => AmioraColors.success,
      PresenceBand.toNurture => AmioraColors.warning,
      PresenceBand.littleNurtured => AmioraColors.text2,
    };

/// Libellés français des catégories (identifiants techniques anglais).
String categoryLabel(String category) => switch (category) {
      'partner' => 'Partenaire',
      'family' => 'Famille',
      'friend' => 'Ami·e',
      'child' => 'Enfant',
      'mentor' => 'Mentor',
      'professional' => 'Professionnel',
      _ => 'Autre',
    };

/// Cadence par défaut, en clair (identifiant technique de catégorie).
String cadenceLabel(String category) => switch (category) {
      'partner' => 'tous les 2 jours',
      'child' => 'tous les 3 jours',
      'family' => 'toutes les semaines',
      'friend' => 'toutes les 2 semaines',
      _ => 'tous les mois',
    };

/// Types d'interaction : libellé français + icône au trait.
const interactionTypes = <(domain.InteractionType, String, IconData)>[
  (domain.InteractionType.call, 'Appel', Icons.call_outlined),
  (domain.InteractionType.message, 'Message', Icons.chat_bubble_outline),
  (domain.InteractionType.meal, 'Repas', Icons.restaurant_outlined),
  (domain.InteractionType.outing, 'Sortie', Icons.directions_walk_outlined),
  (domain.InteractionType.trip, 'Voyage', Icons.flight_outlined),
  (domain.InteractionType.visit, 'Visite', Icons.home_outlined),
  (domain.InteractionType.gift, 'Cadeau', Icons.card_giftcard_outlined),
  (domain.InteractionType.moment, 'Moment', Icons.auto_awesome_outlined),
  (domain.InteractionType.photo, 'Photo', Icons.photo_camera_outlined),
  (domain.InteractionType.event, 'Événement', Icons.star_outline),
];

String interactionTypeLabel(String type) {
  for (final (t, label, _) in interactionTypes) {
    if (t.name == type) return label;
  }
  return type;
}

IconData interactionTypeIcon(String type) {
  for (final (t, _, icon) in interactionTypes) {
    if (t.name == type) return icon;
  }
  return Icons.favorite_outline;
}

/// Format de date français court, sans dépendre des données de locale intl.
String frenchDate(DateTime d) {
  const months = [
    'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
    'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre',
  ];
  return '${d.day} ${months[d.month - 1]} ${d.year}';
}

String frenchDayDate(DateTime d) {
  const days = [
    'lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche',
  ];
  return '${days[d.weekday - 1]} ${frenchDate(d).substring(0, frenchDate(d).lastIndexOf(' '))}';
}

/// « aujourd'hui », « hier », « il y a N jours ».
String daysAgoLabel(DateTime date) {
  final today = DateTime.now();
  final dd = DateTime(today.year, today.month, today.day)
      .difference(DateTime(date.year, date.month, date.day))
      .inDays;
  if (dd <= 0) return "aujourd'hui";
  if (dd == 1) return 'hier';
  return 'il y a $dd jours';
}

/// Avatar à initiale (design system : pas de photo par défaut).
class InitialAvatar extends StatelessWidget {
  const InitialAvatar({super.key, required this.name, this.size = 48});

  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AmioraColors.surfaceRaised,
        shape: BoxShape.circle,
        border: Border.all(color: AmioraColors.border),
      ),
      alignment: Alignment.center,
      child: Text(
        name.isEmpty ? '?' : name.characters.first.toUpperCase(),
        style: TextStyle(
          color: AmioraColors.gold,
          fontWeight: FontWeight.w600,
          fontSize: size * 0.38,
        ),
      ),
    );
  }
}

/// Barre de progression de l'Indice avec libellé de bande obligatoire.
class PresenceBar extends StatelessWidget {
  const PresenceBar({super.key, required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    final band = presenceBand(score);
    final color = bandColor(band);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: LinearProgressIndicator(
            value: score / 100,
            minHeight: 6,
            backgroundColor: AmioraColors.surfaceRaised,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const SizedBox(height: AmioraSpacing.x2),
        Text(
          presenceBandLabel(band),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: color),
        ),
      ],
    );
  }
}
