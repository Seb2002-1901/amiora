import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/app_providers.dart';
import '../../common/access.dart';
import '../../common/presence_ui.dart';

/// « En mémoire » (PRD V1.2, décision 9 V1.1) : conserve l'histoire d'une
/// personne décédée. Score gelé, aucune notification, souvenirs préservés.
/// Route `/in-memoriam/all` : liste ; `/in-memoriam/<id>` : mémorial.
class InMemoriamScreen extends ConsumerWidget {
  const InMemoriamScreen({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (id != null && id != 'all') {
      return _MemorialView(relationshipId: id!);
    }
    final inMemoriam = ref.watch(inMemoriamProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('En mémoire')),
      body: inMemoriam.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Réessaie dans un instant.')),
        data: (rels) {
          if (rels.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.gutter * 2),
                child: Text(
                  'Cet espace conserve l’histoire des personnes '
                  'qui ne sont plus là.\nLeurs souvenirs restent.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AmioraColors.text2),
                ),
              ),
            );
          }
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: context.gutter,
              vertical: AmioraSpacing.x4,
            ),
            children: [
              for (final rel in rels) ...[
                Card(
                  child: ListTile(
                    leading: InitialAvatar(name: rel.firstName),
                    title: Text(rel.firstName),
                    subtitle: const Text('En mémoire'),
                    trailing:
                        const Icon(Icons.chevron_right, color: AmioraColors.text3),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => _MemorialView(relationshipId: rel.id),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AmioraSpacing.x3),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _MemorialView extends ConsumerWidget {
  const _MemorialView({required this.relationshipId});

  final String relationshipId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relationship = ref.watch(relationshipProvider(relationshipId));
    final interactions = ref.watch(interactionsProvider(relationshipId));

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
                      rel.firstName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AmioraSpacing.x2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AmioraSpacing.x3,
                        vertical: AmioraSpacing.x1,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AmioraRadii.pill),
                        border: Border.all(color: AmioraColors.gold),
                      ),
                      child: const Text(
                        'En mémoire',
                        style: TextStyle(color: AmioraColors.gold),
                      ),
                    ),
                    const SizedBox(height: AmioraSpacing.x3),
                    Text(
                      'Les souvenirs restent.\nAucune notification ne sera envoyée.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AmioraColors.text2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AmioraSpacing.x5),
              Text(
                'SON HISTOIRE',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AmioraColors.text3,
                      letterSpacing: 1,
                    ),
              ),
              const SizedBox(height: AmioraSpacing.x3),
              switch (interactions) {
                AsyncData(:final value) when value.isEmpty => Text(
                    'Les moments partagés apparaîtront ici.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AmioraColors.text2),
                  ),
                AsyncData(:final value) => Column(
                    children: [
                      for (final i in value) ...[
                        Card(
                          child: ListTile(
                            leading: Icon(
                              interactionTypeIcon(i.type),
                              color: AmioraColors.gold,
                            ),
                            title: Text(interactionTypeLabel(i.type)),
                            subtitle: i.note == null ? null : Text(i.note!),
                            trailing: Text(
                              frenchDate(i.occurredAt),
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
                  onPressed: () async {
                    if (!ensureWritable(context, ref)) return;
                    await ref
                        .read(databaseProvider)
                        .setRelationshipStatus(relationshipId, 'active');
                    ref.read(dbTickProvider.notifier).state++;
                    if (context.mounted) Navigator.of(context).pop();
                  },
                  child: const Text('Rétablir la relation active'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
