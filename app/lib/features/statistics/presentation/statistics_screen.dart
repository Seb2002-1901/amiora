import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/app_providers.dart';

/// Statistiques de l'année : calcul dérivé des vraies données locales.
/// « Les statistiques reflètent ce que tu as enregistré — pas la valeur
/// de tes relations. » (chapitre 13 : le temps passé dans l'app est un
/// anti-objectif ; on ne montre que des faits relationnels.)
class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(yearStatsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Statistiques')),
      body: stats.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Réessaie dans un instant.')),
        data: (data) {
          final hours = data.minutes ~/ 60;
          final tiles = <(String, String)>[
            ('${data.byType['call'] ?? 0}', 'Appels'),
            ('${(data.byType['outing'] ?? 0) + (data.byType['meal'] ?? 0)}',
                'Sorties & repas'),
            ('${data.byType['trip'] ?? 0}', 'Voyages'),
            ('${data.byType['visit'] ?? 0}', 'Visites'),
            ('${data.memories}', 'Souvenirs'),
            ('$hours h', 'Temps ensemble'),
          ];
          final total = data.byType.values.fold(0, (a, b) => a + b);

          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: context.gutter,
              vertical: AmioraSpacing.x4,
            ),
            children: [
              Text(
                'Cette année',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AmioraColors.text3, letterSpacing: 1),
              ),
              const SizedBox(height: AmioraSpacing.x3),
              // Grille fluide (design § 9.2 : jamais de colonnes codées).
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns =
                      (constraints.maxWidth / 160).floor().clamp(2, 4);
                  return GridView.count(
                    crossAxisCount: columns,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: AmioraSpacing.x3,
                    crossAxisSpacing: AmioraSpacing.x3,
                    childAspectRatio: 1.6,
                    children: [
                      for (final (value, label) in tiles)
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(AmioraSpacing.x3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontFeatures: const [
                                          FontFeature.tabularFigures(),
                                        ],
                                      ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  label,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: AmioraColors.text2),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AmioraSpacing.x5),
              if (total == 0)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: AmioraSpacing.x6),
                    child: Text(
                      'Enregistre tes premiers moments —\nles chiffres suivront.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AmioraColors.text2),
                    ),
                  ),
                )
              else
                Text(
                  'Les statistiques reflètent ce que tu as enregistré — '
                  'pas la valeur de tes relations.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AmioraColors.text3),
                ),
            ],
          );
        },
      ),
    );
  }
}
