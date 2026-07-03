import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/tokens.dart';
import '../../data/local/database.dart';
import '../../domain/presence/presence_bands.dart';
import '../../domain/presence/presence_score.dart';
import 'presence_ui.dart';

/// Carte relation (design system § 5.2) : avatar, nom, catégorie,
/// dernière interaction, indice avec libellé de bande.
class RelationshipCard extends StatelessWidget {
  const RelationshipCard({
    super.key,
    required this.relationship,
    required this.result,
  });

  final Relationship relationship;
  final PresenceResult? result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AmioraRadii.card),
        onTap: () => context.push('/relationships/${relationship.id}'),
        child: Padding(
          padding: const EdgeInsets.all(AmioraSpacing.x4),
          child: Row(
            children: [
              InitialAvatar(name: relationship.firstName),
              const SizedBox(width: AmioraSpacing.x3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: relationship.firstName,
                        style: theme.textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text:
                                '  · ${categoryLabel(relationship.category)}',
                            style: theme.textTheme.bodySmall!
                                .copyWith(color: AmioraColors.text3),
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _subtitle,
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: AmioraColors.text2),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AmioraSpacing.x3),
              _ScoreBadge(result: result),
            ],
          ),
        ),
      ),
    );
  }

  String get _subtitle => switch (result) {
        PresenceNewRelation() => 'Nouvelle relation',
        PresenceScore() =>
          'Attention souhaitée : ${cadenceLabel(relationship.category)}',
        _ => '',
      };
}

class _ScoreBadge extends StatelessWidget {
  const _ScoreBadge({required this.result});

  final PresenceResult? result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    switch (result) {
      case PresenceScore(:final display):
        final band = presenceBand(display);
        final color = bandColor(band);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$display',
              style: theme.textTheme.titleMedium!.copyWith(color: color),
            ),
            Text(
              presenceBandLabel(band),
              style: theme.textTheme.bodySmall!.copyWith(color: color),
            ),
          ],
        );
      case PresenceNewRelation():
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AmioraSpacing.x3,
            vertical: AmioraSpacing.x1,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AmioraRadii.pill),
            border: Border.all(color: AmioraColors.gold),
          ),
          child: Text(
            'Nouvelle',
            style: theme.textTheme.bodySmall!
                .copyWith(color: AmioraColors.gold),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
