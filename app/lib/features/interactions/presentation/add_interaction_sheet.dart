import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/logging/logger.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/app_providers.dart';
import '../../../data/local/database.dart';
import '../../../domain/entities/entities.dart' as domain;
import '../../common/presence_ui.dart';

/// Le geste central du produit (PRD V1.2) : personne + type obligatoires,
/// tout le reste facultatif, enregistrement visé en moins de 10 secondes.
/// Fonctionne de bout en bout : insertion locale, recalcul immédiat de
/// l'Indice de présence, confirmation chaleureuse.
class AddInteractionSheet extends ConsumerStatefulWidget {
  const AddInteractionSheet({super.key, this.preselectedId});

  final String? preselectedId;

  static Future<void> show(BuildContext context, {String? preselectedId}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => AddInteractionSheet(preselectedId: preselectedId),
    );
  }

  @override
  ConsumerState<AddInteractionSheet> createState() =>
      _AddInteractionSheetState();
}

class _AddInteractionSheetState extends ConsumerState<AddInteractionSheet> {
  final _stopwatch = Stopwatch()..start();
  final _selected = <String>{};
  domain.InteractionType? _type;
  DateTime _date = DateTime.now();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.preselectedId != null) _selected.add(widget.preselectedId!);
  }

  Future<void> _save(List<Relationship> rels) async {
    if (_selected.isEmpty || _type == null || _saving) return;
    setState(() => _saving = true);
    _stopwatch.stop();

    final db = ref.read(databaseProvider);
    await db.insertInteraction(
      InteractionsCompanion.insert(
        id: const Uuid().v4(),
        type: _type!.name,
        occurredAt: _date,
      ),
      _selected.toList(),
    );
    ref.read(dbTickProvider.notifier).state++;

    // Métrique produit clef : durée du geste (jamais de contenu en logs).
    Log.info(
      'interaction_logged seconds_to_complete='
      '${(_stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(1)}',
    );
    unawaited(HapticFeedback.lightImpact());

    if (mounted) {
      final names = [
        for (final r in rels)
          if (_selected.contains(r.id)) r.firstName,
      ].join(', ');
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enregistré — encore un moment avec $names 💛')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rels = ref.watch(relationshipsProvider).valueOrNull ?? const [];
    final canSave = _selected.isNotEmpty && _type != null && !_saving;

    return Padding(
      padding: EdgeInsets.only(
        left: AmioraSpacing.x4,
        right: AmioraSpacing.x4,
        bottom: MediaQuery.viewInsetsOf(context).bottom + AmioraSpacing.x4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Ajouter une interaction', style: theme.textTheme.titleMedium),
          const SizedBox(height: AmioraSpacing.x1),
          Text(
            'Avec qui, et quoi — le reste est facultatif.',
            style:
                theme.textTheme.bodyMedium!.copyWith(color: AmioraColors.text2),
          ),
          const SizedBox(height: AmioraSpacing.x4),
          if (rels.isEmpty)
            Text(
              "Ajoute d'abord une personne à ton cercle.",
              style: theme.textTheme.bodyMedium!
                  .copyWith(color: AmioraColors.text2),
            )
          else
            SizedBox(
              height: 84,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: rels.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: AmioraSpacing.x3),
                itemBuilder: (context, index) {
                  final rel = rels[index];
                  final selected = _selected.contains(rel.id);
                  return InkWell(
                    borderRadius: BorderRadius.circular(AmioraRadii.field),
                    onTap: () => setState(() {
                      selected ? _selected.remove(rel.id) : _selected.add(rel.id);
                    }),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: selected
                                  ? BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AmioraColors.gold,
                                        width: 2,
                                      ),
                                    )
                                  : null,
                              child: InitialAvatar(name: rel.firstName),
                            ),
                            if (selected)
                              const Positioned(
                                right: 0,
                                bottom: 0,
                                child: CircleAvatar(
                                  radius: 9,
                                  backgroundColor: AmioraColors.gold,
                                  child: Icon(
                                    Icons.check,
                                    size: 12,
                                    color: AmioraColors.onGold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: AmioraSpacing.x1),
                        Text(
                          rel.firstName,
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: selected
                                ? AmioraColors.gold
                                : AmioraColors.text2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: AmioraSpacing.x4),
          // Grille fluide : 4 colonnes sur 360 dp, 5 dès 393 (design § 9).
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = (constraints.maxWidth / 78).floor().clamp(3, 6);
              return GridView.count(
                crossAxisCount: columns,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AmioraSpacing.x2,
                crossAxisSpacing: AmioraSpacing.x2,
                childAspectRatio: 0.95,
                children: [
                  for (final (type, label, icon) in interactionTypes)
                    _TypeCell(
                      label: label,
                      icon: icon,
                      selected: _type == type,
                      onTap: () => setState(() => _type = type),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: AmioraSpacing.x4),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.event_outlined, size: 20),
                  label: Text(
                    daysAgoLabel(_date) == "aujourd'hui"
                        ? "Aujourd'hui"
                        : frenchDate(_date),
                  ),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) setState(() => _date = picked);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AmioraSpacing.x4),
          FilledButton(
            onPressed: canSave ? () => _save(rels) : null,
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}

class _TypeCell extends StatelessWidget {
  const _TypeCell({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AmioraColors.gold : AmioraColors.text2;
    return InkWell(
      borderRadius: BorderRadius.circular(AmioraRadii.button),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AmioraRadii.button),
          border: Border.all(
            color: selected ? AmioraColors.gold : AmioraColors.border,
          ),
          color: selected
              ? AmioraColors.gold.withValues(alpha: 0.12)
              : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(vertical: AmioraSpacing.x2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: AmioraSpacing.x1),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: color, fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
