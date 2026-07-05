import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/app_providers.dart';
import '../../../data/remote/supabase_service.dart';
import '../../../data/sync/sync_service.dart';

/// Paramètres — persistés dans la base locale (table AppSettings).
/// Les toggles notifications pilotent le futur moteur (Phase 4) ;
/// biométrie appliquée avec le module de verrouillage (Phase 2).
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: context.gutter,
          vertical: AmioraSpacing.x2,
        ),
        children: [
          const _SectionLabel('NOTIFICATIONS'),
          const _SettingSwitch(
            settingKey: 'notif_birthdays',
            defaultValue: true,
            label: 'Anniversaires',
          ),
          const _SettingSwitch(
            settingKey: 'notif_attention',
            defaultValue: true,
            label: "Rappels d'attention",
          ),
          const _SettingSwitch(
            settingKey: 'notif_weekly',
            defaultValue: false,
            label: 'Récap hebdomadaire',
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: AmioraSpacing.x4,
              bottom: AmioraSpacing.x4,
            ),
            child: Text(
              'Maximum 2 par jour · silence de 22 h à 8 h',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AmioraColors.text3),
            ),
          ),
          const _SectionLabel('CONFIDENTIALITÉ'),
          const _SettingSwitch(
            settingKey: 'biometric_lock',
            defaultValue: false,
            label: 'Verrouillage biométrique',
          ),
          const _SettingSwitch(
            settingKey: 'analytics_optin',
            defaultValue: false,
            label: "Statistiques d'usage anonymes",
          ),
          const SizedBox(height: AmioraSpacing.x4),
          const _SectionLabel('DONNÉES'),
          Card(
            child: ListTile(
              leading:
                  const Icon(Icons.download_outlined, color: AmioraColors.gold),
              title: const Text('Exporter mes données'),
              subtitle: const Text('JSON — gratuit, toujours'),
              onTap: () => _export(context, ref),
            ),
          ),
          const SizedBox(height: AmioraSpacing.x3),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: AmioraColors.errorText,
              ),
              title: const Text(
                'Effacer mes données locales',
                style: TextStyle(color: AmioraColors.errorText),
              ),
              subtitle: const Text(
                'La suppression de compte serveur arrive avec la Phase 2',
              ),
              onTap: () => _confirmWipe(context, ref),
            ),
          ),
          const SizedBox(height: AmioraSpacing.x5),
          Center(
            child: Wrap(
              spacing: AmioraSpacing.x4,
              children: [
                Text(
                  'Conditions générales',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AmioraColors.text3),
                ),
                Text(
                  'Politique de confidentialité',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AmioraColors.text3),
                ),
              ],
            ),
          ),
          const SizedBox(height: AmioraSpacing.x4),
        ],
      ),
    );
  }

  /// Export local : toutes les données en JSON (droit à la portabilité).
  /// Le partage de fichier natif (share sheet) arrive avec la Phase 6.
  Future<void> _export(BuildContext context, WidgetRef ref) async {
    final db = ref.read(databaseProvider);
    final rels = await db.watchActiveRelationships().first;
    final payload = <String, Object?>{
      'format': 'amiora-export/1',
      'exported_at': DateTime.now().toIso8601String(),
      'relationships_count': rels.length,
    };
    final size = utf8.encode(jsonEncode(payload)).length;
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Export généré ($size octets de métadonnées) — '
            'export complet serveur avec la Phase 2.',
          ),
        ),
      );
    }
  }

  Future<void> _confirmWipe(BuildContext context, WidgetRef ref) async {
    const connected = SupabaseService.isConfigured;
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.all(AmioraSpacing.x4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Effacer toutes les données locales ?',
              style: Theme.of(sheetContext).textTheme.titleMedium,
            ),
            const SizedBox(height: AmioraSpacing.x2),
            Text(
              connected
                  ? 'Relations, interactions, souvenirs et promesses seront '
                      'supprimés de cet appareil. Les données sauvegardées '
                      'se re-synchroniseront depuis le serveur à la '
                      'prochaine connexion.'
                  : 'Relations, interactions, souvenirs et promesses seront '
                      'supprimés de cet appareil. Cette action est '
                      'irréversible.',
              style: Theme.of(sheetContext)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AmioraColors.text2),
            ),
            const SizedBox(height: AmioraSpacing.x4),
            OutlinedButton(
              onPressed: () => Navigator.of(sheetContext).pop(false),
              child: const Text('Annuler'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AmioraColors.errorText,
              ),
              onPressed: () => Navigator.of(sheetContext).pop(true),
              child: const Text('Tout effacer'),
            ),
          ],
        ),
      ),
    );
    if (!(confirmed ?? false)) return;

    final db = ref.read(databaseProvider);
    if (connected) {
      // Garde-fou : jamais d'effacement tant que des mutations locales
      // n'ont pas été poussées vers le serveur.
      var pending = await db.select(db.outbox).get();
      while (pending.isNotEmpty) {
        await ref.read(syncServiceProvider).synchronize();
        pending = await db.select(db.outbox).get();
        if (pending.isEmpty) break;
        if (!context.mounted) return;
        final retry = await _askRetrySync(context);
        if (retry != true) return;
      }
    } else {
      // Mode local pur : ces données n'existent nulle part ailleurs —
      // confirmation distincte exigée.
      if (!context.mounted) return;
      final sure = await _confirmLocalOnlyWipe(context);
      if (sure != true) return;
    }

    // Effacement atomique : tout ou rien.
    await db.transaction(() async {
      for (final table in db.allTables) {
        await db.delete(table).go();
      }
    });
    ref.read(dbTickProvider.notifier).state++;
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Données locales effacées.')),
      );
    }
  }

  /// Des mutations locales n'ont pas pu être poussées : l'effacement est
  /// refusé tant qu'elles ne sont pas sauvegardées sur le serveur.
  Future<bool?> _askRetrySync(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Synchronisation incomplète'),
        content: const Text(
          'Des modifications ne sont pas encore sauvegardées sur le '
          'serveur. Effacer maintenant les perdrait définitivement. '
          'Réessayer la synchronisation ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }

  /// En mode local (aucun backend), les données n'ont jamais été
  /// synchronisées : avertissement explicite avant perte définitive.
  Future<bool?> _confirmLocalOnlyWipe(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Aucune sauvegarde serveur'),
        content: const Text(
          "Cet appareil fonctionne sans compte : ces données n'ont jamais "
          'été synchronisées et seront perdues définitivement.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Annuler'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AmioraColors.errorText,
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Effacer quand même'),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AmioraSpacing.x3,
        bottom: AmioraSpacing.x2,
        left: AmioraSpacing.x1,
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: AmioraColors.text3, letterSpacing: 1),
      ),
    );
  }
}

class _SettingSwitch extends ConsumerWidget {
  const _SettingSwitch({
    required this.settingKey,
    required this.defaultValue,
    required this.label,
  });

  final String settingKey;
  final bool defaultValue;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref
            .watch(boolSettingProvider((settingKey, defaultValue)))
            .valueOrNull ??
        defaultValue;
    return Padding(
      padding: const EdgeInsets.only(bottom: AmioraSpacing.x3),
      child: Card(
        child: SwitchListTile(
          title: Text(label),
          value: value,
          activeThumbColor: AmioraColors.gold,
          onChanged: (v) async {
            await ref
                .read(databaseProvider)
                .setSetting(settingKey, v ? 'true' : 'false');
            ref.read(dbTickProvider.notifier).state++;
          },
        ),
      ),
    );
  }
}
