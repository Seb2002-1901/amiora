import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/navigation/tap_guard.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/app_providers.dart';
import '../../../data/remote/auth_repository.dart';
import '../../../data/remote/supabase_service.dart';
import '../../../data/subscription/subscription_service.dart';
import '../../common/presence_ui.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  /// Déconnexion réelle : confirmation, puis signOut — le routeur
  /// (refreshListenable) ramène vers /login quand la session tombe.
  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Se déconnecter ?'),
        content: const Text(
          'Tes données restent sur cet appareil et sur le serveur.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Se déconnecter'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref.read(authRepositoryProvider).signOut();
    } on Exception {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('La déconnexion a échoué. Réessaie dans un instant.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relCount =
        ref.watch(relationshipsProvider).valueOrNull?.length ?? 0;
    final inMemoriam = ref.watch(inMemoriamProvider).valueOrNull ?? const [];
    final session = ref.watch(sessionProvider).valueOrNull;
    // Statut d'accès réel : bêta sans RevenueCat, sinon état du droit.
    final readOnly = SubscriptionService.isConfigured &&
        ref.watch(accessStateProvider).valueOrNull == AccessState.readOnly;
    final accessLabel = !SubscriptionService.isConfigured
        ? 'Accès complet (bêta)'
        : readOnly
            ? 'Lecture seule'
            : 'Abonnement actif';

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: context.gutter,
          vertical: AmioraSpacing.x4,
        ),
        children: [
          Center(
            child: Column(
              children: [
                const InitialAvatar(name: 'S', size: 88),
                const SizedBox(height: AmioraSpacing.x3),
                Text(
                  'Ton cercle',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AmioraSpacing.x1),
                Text(
                  '$relCount relation${relCount > 1 ? 's' : ''} active${relCount > 1 ? 's' : ''}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AmioraColors.text2),
                ),
                const SizedBox(height: AmioraSpacing.x3),
                Chip(
                  label: Text(accessLabel),
                  side: const BorderSide(color: AmioraColors.gold),
                  labelStyle: const TextStyle(color: AmioraColors.gold),
                ),
                if (readOnly)
                  TextButton(
                    onPressed: () => context.push('/paywall'),
                    child: const Text('Réactiver AMIORA'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AmioraSpacing.x6),
          _NavCard(
            icon: Icons.calendar_month_outlined,
            label: 'Calendrier',
            onTap: () => context.push('/calendar'),
          ),
          _NavCard(
            icon: Icons.volunteer_activism_outlined,
            label: 'Promesses',
            onTap: () => context.push('/promises'),
          ),
          _NavCard(
            icon: Icons.query_stats_outlined,
            label: 'Statistiques',
            onTap: () => context.push('/profile/statistics'),
          ),
          _NavCard(
            icon: Icons.favorite_outline,
            label: 'En mémoire',
            trailing: inMemoriam.isEmpty ? null : '${inMemoriam.length}',
            onTap: () => context.push('/in-memoriam/all'),
          ),
          _NavCard(
            icon: Icons.settings_outlined,
            label: 'Paramètres',
            onTap: () => context.push('/profile/settings'),
          ),
          const SizedBox(height: AmioraSpacing.x5),
          // Visible seulement en mode connecté avec une session ouverte.
          if (SupabaseService.isConfigured && session != null)
            Center(
              child: TextButton(
                style:
                    TextButton.styleFrom(foregroundColor: AmioraColors.text3),
                onPressed: () => _signOut(context, ref),
                child: const Text('Se déconnecter'),
              ),
            ),
        ],
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  const _NavCard({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final String? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AmioraSpacing.x3),
      child: Card(
        child: ListTile(
          leading: Icon(icon, color: AmioraColors.gold),
          title: Text(label),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (trailing != null)
                Text(
                  trailing!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AmioraColors.text3),
                ),
              const SizedBox(width: AmioraSpacing.x2),
              const Icon(Icons.chevron_right, color: AmioraColors.text3),
            ],
          ),
          onTap: () {
            if (TapGuard.allow()) onTap();
          },
        ),
      ),
    );
  }
}
