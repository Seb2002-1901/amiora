import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/logging/logger.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/subscription/subscription_service.dart';

/// Paywall (PRD V1.2 : essai 14 jours · 5,99 CHF/mois · 44,99 CHF/an,
/// lecture seule après expiration, jamais de confiscation).
///
/// Branché sur RevenueCat quand REVENUECAT_API_KEY est fournie : prix
/// réels du store, achat, restauration. Sans clé (mode local/bêta),
/// l'écran reste consultable avec les tarifs de référence.
class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  /// Offre sélectionnée : annuelle par défaut (recommandée).
  bool _annualSelected = true;
  bool _busy = false;

  Offerings? _offerings;
  bool _loadFailed = false;
  bool _loading = SubscriptionService.isConfigured;

  @override
  void initState() {
    super.initState();
    if (SubscriptionService.isConfigured) _loadOfferings();
  }

  Future<void> _loadOfferings() async {
    setState(() {
      _loading = true;
      _loadFailed = false;
    });
    try {
      final offerings = await SubscriptionService.offerings();
      if (!mounted) return;
      setState(() {
        _offerings = offerings;
        _loading = false;
      });
    } on Exception {
      Log.info('paywall_offerings_error');
      if (!mounted) return;
      setState(() {
        _loadFailed = true;
        _loading = false;
      });
    }
  }

  Package? get _selectedPackage {
    final current = _offerings?.current;
    if (current == null) return null;
    return _annualSelected ? current.annual : current.monthly;
  }

  Future<void> _buy() async {
    if (!SubscriptionService.isConfigured) {
      _notify("L'achat sera activé à la connexion de RevenueCat.");
      return;
    }
    final package = _selectedPackage;
    if (package == null) {
      _notify('Offre indisponible pour le moment — réessaie plus tard.');
      return;
    }
    setState(() => _busy = true);
    try {
      final info = await SubscriptionService.purchase(package);
      if (!mounted) return;
      final active = info?.entitlements
              .active[SubscriptionService.entitlementId]?.isActive ??
          false;
      if (active) {
        unawaited(HapticFeedback.lightImpact());
        _notify('Bienvenue. Ton essai de 14 jours commence maintenant.');
        unawaited(Navigator.of(context).maybePop());
      }
    } on PlatformException catch (e) {
      if (!mounted) return;
      if (PurchasesErrorHelper.getErrorCode(e) !=
          PurchasesErrorCode.purchaseCancelledError) {
        _notify("L'achat n'a pas abouti. Rien n'a été débité — réessaie.");
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _restore() async {
    if (!SubscriptionService.isConfigured) {
      _notify('Restauration disponible dès la connexion de RevenueCat.');
      return;
    }
    setState(() => _busy = true);
    try {
      final info = await SubscriptionService.restore();
      if (!mounted) return;
      final active = info?.entitlements
              .active[SubscriptionService.entitlementId]?.isActive ??
          false;
      if (active) {
        unawaited(HapticFeedback.lightImpact());
        _notify('Abonnement retrouvé — accès complet rétabli.');
        unawaited(Navigator.of(context).maybePop());
      } else {
        _notify('Aucun abonnement actif trouvé pour ce compte.');
      }
    } on PlatformException {
      if (!mounted) return;
      _notify('Restauration impossible pour le moment — réessaie.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _notify(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _select(bool annual) {
    if (_annualSelected == annual) return;
    HapticFeedback.selectionClick();
    setState(() => _annualSelected = annual);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Prix : ceux du store quand RevenueCat répond, sinon référence PRD.
    final annualPrice =
        _offerings?.current?.annual?.storeProduct.priceString ?? '44,99 CHF';
    final monthlyPrice =
        _offerings?.current?.monthly?.storeProduct.priceString ?? '5,99 CHF';

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
                if (_loadFailed) ...[
                  _OfferError(onRetry: _loadOfferings),
                  const SizedBox(height: AmioraSpacing.x3),
                ],
                // Les cartes passent côte à côte quand la largeur le permet.
                Wrap(
                  spacing: AmioraSpacing.x3,
                  runSpacing: AmioraSpacing.x3,
                  children: [
                    _PriceCard(
                      title: 'Annuel',
                      price: annualPrice,
                      per: '/an',
                      note: '≈ 3,75 CHF par mois',
                      recommended: true,
                      selected: _annualSelected,
                      loading: _loading,
                      onTap: () => _select(true),
                    ),
                    _PriceCard(
                      title: 'Mensuel',
                      price: monthlyPrice,
                      per: '/mois',
                      note: 'Souplesse maximale',
                      selected: !_annualSelected,
                      loading: _loading,
                      onTap: () => _select(false),
                    ),
                  ],
                ),
                const SizedBox(height: AmioraSpacing.x5),
                FilledButton(
                  onPressed: _busy || _loading ? null : _buy,
                  child: _busy
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: AmioraColors.onGold,
                          ),
                        )
                      : const Text('Commencer — 14 jours gratuits'),
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
                    onPressed: _busy ? null : _restore,
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

/// Échec de chargement des offres : message doux + nouvelle tentative.
class _OfferError extends StatelessWidget {
  const _OfferError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AmioraSpacing.x3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AmioraRadii.field),
        border: Border.all(color: AmioraColors.border),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.wifi_off_outlined,
            color: AmioraColors.text2,
            size: 20,
          ),
          const SizedBox(width: AmioraSpacing.x2),
          Expanded(
            child: Text(
              'Tarifs du store indisponibles — les prix affichés sont '
              'indicatifs.',
              style: theme.textTheme.bodySmall!
                  .copyWith(color: AmioraColors.text2),
            ),
          ),
          TextButton(onPressed: onRetry, child: const Text('Réessayer')),
        ],
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
    required this.selected,
    required this.loading,
    required this.onTap,
    this.recommended = false,
  });

  final String title;
  final String price;
  final String per;
  final String note;
  final bool recommended;
  final bool selected;
  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            color: selected
                ? AmioraColors.gold.withValues(alpha: 0.07)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AmioraRadii.card),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AmioraRadii.card),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOut,
                padding: const EdgeInsets.all(AmioraSpacing.x4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AmioraRadii.card),
                  border: Border.all(
                    color: selected ? AmioraColors.gold : AmioraColors.border,
                    width: selected ? 1.5 : 1,
                  ),
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
                    if (loading)
                      // Squelette discret le temps des tarifs du store.
                      Container(
                        width: 110,
                        height: 24,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: AmioraColors.surfaceRaised,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      )
                    else
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
