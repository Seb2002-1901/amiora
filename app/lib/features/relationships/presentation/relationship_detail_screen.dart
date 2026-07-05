import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/app_providers.dart';
import '../../../domain/presence/presence_bands.dart';
import '../../../domain/presence/presence_score.dart';
import '../../common/access.dart';
import '../../common/presence_ui.dart';
import '../../interactions/presentation/add_interaction_sheet.dart';

class RelationshipDetailScreen extends ConsumerWidget {
  const RelationshipDetailScreen({super.key, required this.id});

  final String id;

  /// Cycle de vie d'une relation : l'archivage est proposé avant toute
  /// suppression (maquette état F) ; « En mémoire » gèle score et rappels.
  Future<void> _showLifecycleSheet(BuildContext context, WidgetRef ref) async {
    if (!ensureWritable(context, ref)) return;
    final action = await showModalBottomSheet<String>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AmioraSpacing.x4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Que souhaites-tu faire ?',
                style: Theme.of(sheetContext).textTheme.titleMedium,
              ),
              const SizedBox(height: AmioraSpacing.x2),
              Text(
                'Archiver met la relation en pause, sans rappels. '
                '« En mémoire » conserve son histoire pour toujours.',
                style: Theme.of(sheetContext)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AmioraColors.text2),
              ),
              const SizedBox(height: AmioraSpacing.x4),
              OutlinedButton(
                onPressed: () => Navigator.of(sheetContext).pop('archived'),
                child: const Text('Archiver'),
              ),
              const SizedBox(height: AmioraSpacing.x2),
              OutlinedButton(
                onPressed: () =>
                    Navigator.of(sheetContext).pop('in_memoriam'),
                child: const Text('Mettre en mémoire'),
              ),
              TextButton(
                onPressed: () => Navigator.of(sheetContext).pop(),
                child: const Text('Annuler'),
              ),
            ],
          ),
        ),
      ),
    );
    if (action != null) {
      await ref.read(databaseProvider).setRelationshipStatus(id, action);
      ref.read(dbTickProvider.notifier).state++;
      if (context.mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relationship = ref.watch(relationshipProvider(id));
    final interactions = ref.watch(interactionsProvider(id));
    final result = ref.watch(scoresProvider).valueOrNull?[id];

    return Scaffold(
      appBar: AppBar(),
      body: relationship.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Réessaie dans un instant.')),
        data: (rel) {
          if (rel == null) {
            return const Center(child: Text('Relation introuvable.'));
          }
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: context.gutter,
              vertical: AmioraSpacing.x2,
            ),
            children: [
              Center(
                child: Column(
                  children: [
                    InitialAvatar(name: rel.firstName, size: 88),
                    const SizedBox(height: AmioraSpacing.x3),
                    Text(
                      [rel.firstName, rel.lastName ?? ''].join(' ').trim(),
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AmioraSpacing.x1),
                    Text(
                      categoryLabel(rel.category),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AmioraColors.text2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AmioraSpacing.x5),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AmioraSpacing.x4),
                  child: switch (result) {
                    PresenceScore(:final display) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Indice de présence',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              Text(
                                '$display',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color:
                                          bandColor(presenceBand(display)),
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AmioraSpacing.x3),
                          PresenceBar(score: display),
                          if (interactions.valueOrNull?.isNotEmpty ?? false)
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: AmioraSpacing.x2),
                              child: Text(
                                'Dernière interaction : '
                                '${daysAgoLabel(interactions.value!.first.occurredAt)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AmioraColors.text3),
                              ),
                            ),
                        ],
                      ),
                    PresenceNewRelation() => Row(
                        children: [
                          const Icon(
                            Icons.spa_outlined,
                            color: AmioraColors.gold,
                          ),
                          const SizedBox(width: AmioraSpacing.x3),
                          Expanded(
                            child: Text(
                              'Nouvelle relation — enregistre un premier '
                              'moment ensemble pour faire vivre son indice.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: AmioraColors.text2),
                            ),
                          ),
                        ],
                      ),
                    _ => const SizedBox(height: 40),
                  },
                ),
              ),
              const SizedBox(height: AmioraSpacing.x4),
              FilledButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Enregistrer une interaction'),
                onPressed: () {
                  if (!ensureWritable(context, ref)) return;
                  AddInteractionSheet.show(context, preselectedId: id);
                },
              ),
              const SizedBox(height: AmioraSpacing.x5),
              Text(
                'Dernières interactions',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AmioraSpacing.x3),
              switch (interactions) {
                AsyncData(:final value) when value.isEmpty => Text(
                    'Rien encore — le premier moment compte double.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AmioraColors.text2),
                  ),
                AsyncData(:final value) => Column(
                    children: [
                      for (final i in value.take(10)) ...[
                        Card(
                          child: ListTile(
                            leading: Icon(
                              interactionTypeIcon(i.type),
                              color: AmioraColors.gold,
                            ),
                            title: Text(interactionTypeLabel(i.type)),
                            subtitle: i.note == null ? null : Text(i.note!),
                            trailing: Text(
                              daysAgoLabel(i.occurredAt),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AmioraColors.text3),
                            ),
                          ),
                        ),
                        const SizedBox(height: AmioraSpacing.x2),
                      ],
                    ],
                  ),
                _ => const SizedBox.shrink(),
              },
              const SizedBox(height: AmioraSpacing.x4),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: AmioraColors.text3,
                  ),
                  onPressed: () => _showLifecycleSheet(context, ref),
                  child: const Text('Archiver ou mettre en mémoire'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
