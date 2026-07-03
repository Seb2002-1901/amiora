import 'package:flutter/material.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/theme/tokens.dart';

/// Paywall (PRD V1.2 : essai 14 jours · 5,99 CHF/mois · 44,99 CHF/an,
/// lecture seule après expiration, jamais de confiscation).
/// L'achat réel est branché via RevenueCat en Phase 5 — l'écran, les
/// mentions et la hiérarchie sont définitifs.
class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: context.gutter,
                vertical: AmioraSpacing.x4,
              ),
              children: [
                const Icon(
                  Icons.favorite_outline,
                  size: 56,
                  color: AmioraColors.gold,
                ),
                const SizedBox(height: AmioraSpacing.x3),
                Text(
                  'Continue de prendre soin',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: AmioraSpacing.x2),
                Text(
                  'Relations, souvenirs, rappels — sans limite,\n'
                  'sans publicité, sans exploitation de tes données.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: AmioraColors.text2),
                ),
                const SizedBox(height: AmioraSpacing.x6),
                // Les cartes passent côte à côte quand la largeur le permet.
                const Wrap(
                  spacing: AmioraSpacing.x3,
                  runSpacing: AmioraSpacing.x3,
                  children: [
                    _PriceCard(
                      title: 'Annuel',
                      price: '44,99 CHF',
                      per: '/an',
                      note: '≈ 3,75 CHF par mois',
                      recommended: true,
                    ),
                    _PriceCard(
                      title: 'Mensuel',
                      price: '5,99 CHF',
                      per: '/mois',
                      note: 'Souplesse maximale',
                    ),
                  ],
                ),
                const SizedBox(height: AmioraSpacing.x5),
                FilledButton(
                  onPressed: () =>
                      ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'L’achat intégré arrive avec RevenueCat (Phase 5).',
                      ),
                    ),
                  ),
                  child: const Text('Commencer — 14 jours gratuits'),
                ),
                const SizedBox(height: AmioraSpacing.x3),
                Text(
                  'Essai gratuit de 14 jours, puis renouvellement automatique '
                  'au tarif choisi. Annulable à tout moment dans les réglages '
                  'Apple ou Google. Après expiration : tes souvenirs restent '
                  'à toi — consultation et export garantis.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: AmioraColors.text3),
                ),
                const SizedBox(height: AmioraSpacing.x2),
                Center(
                  child: TextButton(
                    onPressed: () =>
                        ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Restauration disponible en Phase 5.'),
                      ),
                    ),
                    child: const Text('Restaurer mes achats'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PriceCard extends StatelessWidget {
  const _PriceCard({
    required this.title,
    required this.price,
    required this.per,
    required this.note,
    this.recommended = false,
  });

  final String title;
  final String price;
  final String per;
  final String note;
  final bool recommended;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(AmioraSpacing.x4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AmioraRadii.card),
              border: Border.all(
                color: recommended ? AmioraColors.gold : AmioraColors.border,
              ),
              color: recommended
                  ? AmioraColors.gold.withValues(alpha: 0.07)
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AmioraSpacing.x1),
                Text.rich(
                  TextSpan(
                    text: price,
                    style: theme.textTheme.titleLarge,
                    children: [
                      TextSpan(
                        text: per,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: AmioraColors.text3),
                      ),
                    ],
                  ),
                ),
                Text(
                  note,
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: AmioraColors.text2),
                ),
              ],
            ),
          ),
          if (recommended)
            Positioned(
              top: -11,
              left: AmioraSpacing.x4,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AmioraSpacing.x3,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: AmioraColors.gold,
                  borderRadius: BorderRadius.circular(AmioraRadii.pill),
                ),
                child: const Text(
                  'RECOMMANDÉ',
                  style: TextStyle(
                    color: AmioraColors.onGold,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
