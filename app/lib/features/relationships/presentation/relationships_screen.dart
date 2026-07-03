import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/app_providers.dart';
import '../../../domain/presence/presence_score.dart';
import '../../common/relationship_card.dart';

class RelationshipsScreen extends ConsumerStatefulWidget {
  const RelationshipsScreen({super.key});

  @override
  ConsumerState<RelationshipsScreen> createState() =>
      _RelationshipsScreenState();
}

class _RelationshipsScreenState extends ConsumerState<RelationshipsScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final relationships = ref.watch(relationshipsProvider);
    final scoreMap = ref.watch(scoresProvider).valueOrNull ?? const {};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_outlined),
            tooltip: 'Ajouter une relation',
            onPressed: () => context.push('/relationships/add'),
          ),
        ],
      ),
      body: relationships.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Réessaie dans un instant.')),
        data: (rels) {
          final filtered = _query.isEmpty
              ? rels
              : [
                  for (final r in rels)
                    if (r.firstName.toLowerCase().contains(_query) ||
                        (r.lastName ?? '').toLowerCase().contains(_query))
                      r,
                ];
          final sorted = [...filtered]..sort((a, b) {
              int rank(String id) => switch (scoreMap[id]) {
                    PresenceScore(:final display) => display,
                    _ => 999,
                  };
              return rank(a.id).compareTo(rank(b.id));
            });

          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: context.gutter,
              vertical: AmioraSpacing.x2,
            ),
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Rechercher…',
                  prefixIcon: Icon(Icons.search, color: AmioraColors.text3),
                ),
                onChanged: (v) => setState(() => _query = v.toLowerCase()),
              ),
              const SizedBox(height: AmioraSpacing.x4),
              if (sorted.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: AmioraSpacing.x10),
                  child: Center(
                    child: Text(
                      rels.isEmpty
                          ? 'Aucune relation pour le moment.'
                          : 'Aucun résultat.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AmioraColors.text2),
                    ),
                  ),
                ),
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
