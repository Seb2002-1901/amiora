import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/app_providers.dart';
import '../../../data/local/database.dart';
import '../../common/access.dart';
import '../../common/presence_ui.dart';

class PromisesScreen extends ConsumerStatefulWidget {
  const PromisesScreen({super.key});

  @override
  ConsumerState<PromisesScreen> createState() => _PromisesScreenState();
}

class _PromisesScreenState extends ConsumerState<PromisesScreen> {
  String _status = 'todo'; // todo | in_progress | done

  @override
  Widget build(BuildContext context) {
    final promises = ref.watch(promisesProvider);
    final rels = ref.watch(relationshipsProvider).valueOrNull ?? const [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Promesses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Nouvelle promesse',
            onPressed: () {
              if (!ensureWritable(context, ref)) return;
              AddPromiseSheet.show(context);
            },
          ),
        ],
      ),
      body: promises.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Réessaie dans un instant.')),
        data: (all) {
          final items = [
            for (final p in all)
              if (p.status == _status) p,
          ];
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: context.gutter,
              vertical: AmioraSpacing.x2,
            ),
            children: [
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'todo', label: Text('À faire')),
                  ButtonSegment(value: 'in_progress', label: Text('En cours')),
                  ButtonSegment(value: 'done', label: Text('Terminées')),
                ],
                selected: {_status},
                onSelectionChanged: (s) => setState(() => _status = s.first),
                showSelectedIcon: false,
              ),
              const SizedBox(height: AmioraSpacing.x4),
              if (items.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: AmioraSpacing.x10),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.volunteer_activism_outlined,
                        size: 64,
                        color: AmioraColors.gold,
                      ),
                      const SizedBox(height: AmioraSpacing.x4),
                      Text(
                        'Les petites promesses renforcent\nles grandes relations.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AmioraColors.text2),
                      ),
                    ],
                  ),
                ),
              for (final p in items) ...[
                _PromiseCard(
                  promise: p,
                  relationName: _nameOf(rels, p.relationshipId),
                ),
                const SizedBox(height: AmioraSpacing.x3),
              ],
            ],
          );
        },
      ),
    );
  }

  String _nameOf(List<Relationship> rels, String id) {
    for (final r in rels) {
      if (r.id == id) return r.firstName;
    }
    return '';
  }
}

class _PromiseCard extends ConsumerWidget {
  const _PromiseCard({required this.promise, required this.relationName});

  final Promise promise;
  final String relationName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final done = promise.status == 'done';

    Future<void> setStatus(String status) async {
      await ref.read(databaseProvider).setPromiseStatus(promise.id, status);
      ref.read(dbTickProvider.notifier).state++;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AmioraSpacing.x3,
          vertical: AmioraSpacing.x2,
        ),
        child: Row(
          children: [
            Checkbox(
              value: done,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              onChanged: (v) {
                if (!ensureWritable(context, ref)) return;
                setStatus(v! ? 'done' : 'todo');
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    promise.title,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      decoration: done ? TextDecoration.lineThrough : null,
                      color: done ? AmioraColors.text3 : AmioraColors.text,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    [
                      if (relationName.isNotEmpty) relationName,
                      if (promise.dueDate != null)
                        frenchDate(promise.dueDate!),
                    ].join(' · '),
                    style: theme.textTheme.bodySmall!
                        .copyWith(color: AmioraColors.text3),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: AmioraColors.text3),
              onSelected: (action) async {
                if (action == 'delete') {
                  // Supprimer reste libre en lecture seule (PRD V1.2).
                  await ref
                      .read(databaseProvider)
                      .softDeletePromise(promise.id);
                  ref.read(dbTickProvider.notifier).state++;
                } else {
                  if (!ensureWritable(context, ref)) return;
                  await setStatus(action);
                }
              },
              itemBuilder: (_) => [
                if (promise.status != 'in_progress')
                  const PopupMenuItem(
                    value: 'in_progress',
                    child: Text('Marquer « en cours »'),
                  ),
                if (promise.status != 'todo')
                  const PopupMenuItem(
                    value: 'todo',
                    child: Text('Remettre « à faire »'),
                  ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Supprimer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddPromiseSheet extends ConsumerStatefulWidget {
  const AddPromiseSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const AddPromiseSheet(),
    );
  }

  @override
  ConsumerState<AddPromiseSheet> createState() => _AddPromiseSheetState();
}

class _AddPromiseSheetState extends ConsumerState<AddPromiseSheet> {
  final _title = TextEditingController();
  String? _relationshipId;
  DateTime? _dueDate;
  bool _saving = false;

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_title.text.trim().isEmpty || _relationshipId == null || _saving) {
      return;
    }
    setState(() => _saving = true);
    await ref.read(databaseProvider).insertPromise(
          PromisesCompanion.insert(
            id: const Uuid().v4(),
            relationshipId: _relationshipId!,
            title: _title.text.trim(),
            dueDate: Value(_dueDate),
          ),
        );
    ref.read(dbTickProvider.notifier).state++;
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Promesse notée — elle compte.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rels = ref.watch(relationshipsProvider).valueOrNull ?? const [];
    final canSave =
        _title.text.trim().isNotEmpty && _relationshipId != null && !_saving;

    // Défilement : la feuille ne déborde jamais (clavier ouvert,
    // grandes tailles de texte).
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: AmioraSpacing.x4,
        right: AmioraSpacing.x4,
        bottom: MediaQuery.viewInsetsOf(context).bottom + AmioraSpacing.x4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Nouvelle promesse', style: theme.textTheme.titleMedium),
          const SizedBox(height: AmioraSpacing.x4),
          TextField(
            controller: _title,
            autofocus: true,
            maxLength: 120,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Promesse',
              hintText: '« Aller voir Grand-maman dimanche »',
              counterText: '',
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AmioraSpacing.x4),
          Wrap(
            spacing: AmioraSpacing.x2,
            runSpacing: AmioraSpacing.x2,
            children: [
              for (final rel in rels)
                ChoiceChip(
                  label: Text(rel.firstName),
                  selected: _relationshipId == rel.id,
                  onSelected: (_) =>
                      setState(() => _relationshipId = rel.id),
                ),
            ],
          ),
          const SizedBox(height: AmioraSpacing.x4),
          OutlinedButton.icon(
            icon: const Icon(Icons.event_outlined, size: 20),
            label: Text(
              _dueDate == null
                  ? 'Échéance (facultative)'
                  : frenchDate(_dueDate!),
            ),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) setState(() => _dueDate = picked);
            },
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
