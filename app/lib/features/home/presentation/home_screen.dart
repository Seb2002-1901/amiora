import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/app_providers.dart';
import '../../../domain/presence/presence_bands.dart';
import '../../../domain/presence/presence_score.dart';
import '../../common/presence_ui.dart';
import '../../common/relationship_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relationships = ref.watch(relationshipsProvider);
    final scores = ref.watch(scoresProvider);

    return Scaffold(
      body: relationships.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            _ErrorState(onRetry: () => ref.invalidate(relationshipsProvider)),
        data: (rels) {
          if (rels.isEmpty) return const _EmptyState();
          final scoreMap = scores.valueOrNull ?? const {};

          // Cercle global : moyenne des scores affichés (livrable 01 § 4.3).
          final displays = [
            for (final r in rels)
              if (scoreMap[r.id] case PresenceScore(:final display)) display,
          ];
          final circle = displays.isEmpty
              ? null
              : (displays.reduce((a, b) => a + b) / displays.length).round();

          // Tri « attention utile » : scores les plus bas d'abord.
          final sorted = [...rels]..sort((a, b) {
              int rank(String id) => switch (scoreMap[id]) {
                    PresenceScore(:final display) => display,
                    _ => 999,
                  };
              return rank(a.id).compareTo(rank(b.id));
            });

          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: context.gutter,
              vertical: AmioraSpacing.x4,
            ),
            children: [
              Text(
                frenchDayDate(DateTime.now()),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AmioraColors.text3),
              ),
              Text('Bonjour', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: AmioraSpacing.x4),
              if (circle != null) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AmioraSpacing.x4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Ton cercle',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Text(
                              '$circle',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: bandColor(presenceBand(circle)),
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AmioraSpacing.x3),
                        PresenceBar(score: circle),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AmioraSpacing.x4),
              ],
              Text(
                'Tes relations',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AmioraSpacing.x3),
              for (final rel in sorted) ...[
                RelationshipCard(relationship: rel, result: scoreMap[rel.id]),
                const SizedBox(height: AmioraSpacing.x3),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.gutter * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_outline,
              size: 72,
              color: AmioraColors.gold,
            ),
            const SizedBox(height: AmioraSpacing.x5),
            Text(
              'Commence par ajouter une personne qui compte pour toi',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AmioraSpacing.x2),
            Text(
              "Trois proches suffisent pour qu'AMIORA prenne vie.",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AmioraColors.text2),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AmioraSpacing.x6),
            FilledButton.icon(
              onPressed: () => context.push('/relationships/add'),
              icon: const Icon(Icons.add),
              label: const Text('Ajouter une personne'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.gutter * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quelque chose n'a pas fonctionné",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AmioraSpacing.x4),
            OutlinedButton(onPressed: onRetry, child: const Text('Réessayer')),
          ],
        ),
      ),
    );
  }
}
