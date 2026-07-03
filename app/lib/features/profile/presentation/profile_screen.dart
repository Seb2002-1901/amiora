import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/app_providers.dart';
import '../../common/presence_ui.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relCount =
        ref.watch(relationshipsProvider).valueOrNull?.length ?? 0;
    final inMemoriam = ref.watch(inMemoriamProvider).valueOrNull ?? const [];

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
                // Statut d'abonnement réel branché avec RevenueCat (Phase 5).
                ActionChip(
                  label: const Text('Essai — abonnement en Phase 5'),
                  side: const BorderSide(color: AmioraColors.gold),
                  labelStyle: const TextStyle(color: AmioraColors.gold),
                  onPressed: () => context.push('/paywall'),
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
          Center(
            child: TextButton(
              style: TextButton.styleFrom(foregroundColor: AmioraColors.text3),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'La connexion au compte arrive avec l’authentification (Phase 2).',
                  ),
                ),
              ),
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
          onTap: onTap,
        ),
      ),
    );
  }
}
