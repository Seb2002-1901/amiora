import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/app_providers.dart';
import '../../../data/local/database.dart';
import '../../../domain/entities/entities.dart' as domain;
import '../../../domain/presence/presence_score.dart' show kDefaultCadenceDays;
import '../../common/presence_ui.dart';

class AddRelationshipScreen extends ConsumerStatefulWidget {
  const AddRelationshipScreen({super.key});

  @override
  ConsumerState<AddRelationshipScreen> createState() =>
      _AddRelationshipScreenState();
}

class _AddRelationshipScreenState extends ConsumerState<AddRelationshipScreen> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  domain.RelationshipCategory _category = domain.RelationshipCategory.family;
  DateTime? _birthday;
  bool _saving = false;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final firstName = _firstName.text.trim();
    if (firstName.isEmpty || _saving) return;
    setState(() => _saving = true);

    final db = ref.read(databaseProvider);
    final id = const Uuid().v4();
    await db.insertRelationship(
      RelationshipsCompanion.insert(
        id: id,
        firstName: firstName,
        lastName: Value(
          _lastName.text.trim().isEmpty ? null : _lastName.text.trim(),
        ),
        category: _category.name,
        cadenceDays: kDefaultCadenceDays[_category]!,
        createdAt: DateTime.now(),
        birthday: Value(_birthday),
      ),
    );
    ref.read(dbTickProvider.notifier).state++;
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$firstName fait partie de ton cercle 💛')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une relation')),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: context.gutter,
            vertical: AmioraSpacing.x4,
          ),
          children: [
            Center(child: InitialAvatar(name: _firstName.text, size: 88)),
            const SizedBox(height: AmioraSpacing.x6),
            TextField(
              controller: _firstName,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Prénom'),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: AmioraSpacing.x4),
            TextField(
              controller: _lastName,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Nom (facultatif)'),
            ),
            const SizedBox(height: AmioraSpacing.x5),
            Text('Catégorie', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AmioraSpacing.x3),
            Wrap(
              spacing: AmioraSpacing.x2,
              runSpacing: AmioraSpacing.x2,
              children: [
                for (final c in domain.RelationshipCategory.values)
                  ChoiceChip(
                    label: Text(categoryLabel(c.name)),
                    selected: _category == c,
                    onSelected: (_) => setState(() => _category = c),
                  ),
              ],
            ),
            const SizedBox(height: AmioraSpacing.x3),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AmioraSpacing.x3),
                child: Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      size: 20,
                      color: AmioraColors.gold,
                    ),
                    const SizedBox(width: AmioraSpacing.x3),
                    Expanded(
                      child: Text(
                        'Attention proposée : ${cadenceLabel(_category.name)}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AmioraColors.text2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AmioraSpacing.x5),
            OutlinedButton.icon(
              icon: const Icon(Icons.cake_outlined),
              label: Text(
                _birthday == null
                    ? 'Anniversaire (facultatif)'
                    : 'Anniversaire : ${frenchDate(_birthday!)}',
              ),
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime(1990),
                  firstDate: DateTime(1920),
                  lastDate: DateTime.now(),
                );
                if (picked != null) setState(() => _birthday = picked);
              },
            ),
            const SizedBox(height: AmioraSpacing.x6),
            FilledButton(
              onPressed: _firstName.text.trim().isEmpty ? null : _save,
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
