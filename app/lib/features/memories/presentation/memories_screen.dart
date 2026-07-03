import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/app_providers.dart';
import '../../../data/local/database.dart';
import '../../common/presence_ui.dart';

class MemoriesScreen extends ConsumerStatefulWidget {
  const MemoriesScreen({super.key});

  @override
  ConsumerState<MemoriesScreen> createState() => _MemoriesScreenState();
}

class _MemoriesScreenState extends ConsumerState<MemoriesScreen> {
  String _filter = 'all'; // all | photo | note

  @override
  Widget build(BuildContext context) {
    final memories = ref.watch(memoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Souvenirs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Ajouter un souvenir',
            onPressed: () => AddMemorySheet.show(context),
          ),
        ],
      ),
      body: memories.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Réessaie dans un instant.')),
        data: (all) {
          final items = _filter == 'all'
              ? all
              : [
                  for (final m in all)
                    if (m.type == _filter) m,
                ];
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: context.gutter,
              vertical: AmioraSpacing.x2,
            ),
            children: [
              Wrap(
                spacing: AmioraSpacing.x2,
                children: [
                  for (final (key, label) in const [
                    ('all', 'Tout'),
                    ('photo', 'Photos'),
                    ('note', 'Notes'),
                  ])
                    ChoiceChip(
                      label: Text(label),
                      selected: _filter == key,
                      onSelected: (_) => setState(() => _filter = key),
                    ),
                ],
              ),
              const SizedBox(height: AmioraSpacing.x4),
              if (items.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: AmioraSpacing.x12),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.photo_outlined,
                        size: 64,
                        color: AmioraColors.gold,
                      ),
                      const SizedBox(height: AmioraSpacing.x4),
                      Text(
                        all.isEmpty
                            ? 'Tes souvenirs vivront ici.\nLe premier compte double.'
                            : 'Aucun souvenir de ce type.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AmioraColors.text2),
                      ),
                      const SizedBox(height: AmioraSpacing.x5),
                      if (all.isEmpty)
                        FilledButton.icon(
                          onPressed: () => AddMemorySheet.show(context),
                          icon: const Icon(Icons.add),
                          label: const Text('Ajouter un souvenir'),
                        ),
                    ],
                  ),
                ),
              ..._groupedByMonth(context, items),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _groupedByMonth(BuildContext context, List<Memory> items) {
    final widgets = <Widget>[];
    String? currentMonth;
    for (final m in items) {
      final month = _monthLabel(m.createdAt);
      if (month != currentMonth) {
        currentMonth = month;
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(
              top: AmioraSpacing.x3,
              bottom: AmioraSpacing.x3,
            ),
            child: Text(
              month.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AmioraColors.text3,
                    letterSpacing: 1,
                  ),
            ),
          ),
        );
      }
      widgets
        ..add(_MemoryCard(memory: m))
        ..add(const SizedBox(height: AmioraSpacing.x3));
    }
    return widgets;
  }

  String _monthLabel(DateTime d) {
    const months = [
      'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre',
    ];
    return '${months[d.month - 1]} ${d.year}';
  }
}

class _MemoryCard extends ConsumerWidget {
  const _MemoryCard({required this.memory});

  final Memory memory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AmioraSpacing.x4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              memory.type == 'photo'
                  ? Icons.photo_outlined
                  : Icons.sticky_note_2_outlined,
              color: AmioraColors.gold,
            ),
            const SizedBox(width: AmioraSpacing.x3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (memory.title?.isNotEmpty ?? false)
                    Text(
                      memory.title!,
                      style: theme.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  if (memory.body?.isNotEmpty ?? false)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        memory.body!,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: AmioraColors.text2),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  const SizedBox(height: AmioraSpacing.x1),
                  Text(
                    frenchDate(memory.createdAt),
                    style: theme.textTheme.bodySmall!
                        .copyWith(color: AmioraColors.text3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Création d'un souvenir : note (texte) liée à une ou plusieurs personnes.
/// La capture photo arrive avec le module média (upload compressé, Phase 4
/// de l'ordre de développement).
class AddMemorySheet extends ConsumerStatefulWidget {
  const AddMemorySheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const AddMemorySheet(),
    );
  }

  @override
  ConsumerState<AddMemorySheet> createState() => _AddMemorySheetState();
}

class _AddMemorySheetState extends ConsumerState<AddMemorySheet> {
  final _title = TextEditingController();
  final _body = TextEditingController();
  final _selected = <String>{};
  bool _saving = false;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_body.text.trim().isEmpty || _selected.isEmpty || _saving) return;
    setState(() => _saving = true);
    final db = ref.read(databaseProvider);
    await db.insertMemory(
      MemoriesCompanion.insert(
        id: const Uuid().v4(),
        type: 'note',
        title: Value(_title.text.trim().isEmpty ? null : _title.text.trim()),
        body: Value(_body.text.trim()),
        createdAt: DateTime.now(),
      ),
      _selected.toList(),
    );
    ref.read(dbTickProvider.notifier).state++;
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Souvenir préservé 💛')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rels = ref.watch(relationshipsProvider).valueOrNull ?? const [];
    final canSave =
        _body.text.trim().isNotEmpty && _selected.isNotEmpty && !_saving;

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
          Text('Ajouter un souvenir', style: theme.textTheme.titleMedium),
          const SizedBox(height: AmioraSpacing.x4),
          TextField(
            controller: _title,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(labelText: 'Titre (facultatif)'),
          ),
          const SizedBox(height: AmioraSpacing.x3),
          TextField(
            controller: _body,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Que veux-tu retenir ?',
              hintText: '« Papa m’a raconté son enfance… »',
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AmioraSpacing.x4),
          Wrap(
            spacing: AmioraSpacing.x2,
            runSpacing: AmioraSpacing.x2,
            children: [
              for (final rel in rels)
                FilterChip(
                  label: Text(rel.firstName),
                  selected: _selected.contains(rel.id),
                  onSelected: (v) => setState(() {
                    v ? _selected.add(rel.id) : _selected.remove(rel.id);
                  }),
                ),
            ],
          ),
          const SizedBox(height: AmioraSpacing.x4),
          FilledButton(
            onPressed: canSave ? _save : null,
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}
