import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../core/logging/logger.dart';

/// Abonnement (PRD V1.2) : essai 14 jours · 5,99 CHF/mois · 44,99 CHF/an,
/// lecture seule après expiration — jamais de confiscation.
///
/// Gardé par configuration : sans REVENUECAT_API_KEY (clé PUBLIQUE du SDK,
/// une par plateforme), l'application reste en accès complet (mode local /
/// bêta sans paiement). La vérité serveur arrive par le webhook RevenueCat
/// (supabase/functions/revenuecat-webhook) qui alimente `subscriptions`.
abstract final class SubscriptionService {
  static const String apiKey = String.fromEnvironment('REVENUECAT_API_KEY');
  static const String entitlementId = 'premium';

  /// Les achats intégrés n'existent que sur iOS/Android.
  static bool get isConfigured =>
      apiKey.isNotEmpty && !kIsWeb;

  static bool _initialized = false;

  static Future<void> initIfConfigured({String? appUserId}) async {
    if (!isConfigured || _initialized) return;
    await Purchases.configure(
      PurchasesConfiguration(apiKey)..appUserID = appUserId,
    );
    _initialized = true;
    Log.info('revenuecat_initialized');
  }

  /// Lie l'abonné à l'identifiant Supabase (app_user_id du webhook).
  static Future<void> logIn(String userId) async {
    if (!isConfigured || !_initialized) return;
    await Purchases.logIn(userId);
  }

  static Future<CustomerInfo?> customerInfo() async {
    if (!isConfigured || !_initialized) return null;
    return Purchases.getCustomerInfo();
  }

  static Future<Offerings?> offerings() async {
    if (!isConfigured || !_initialized) return null;
    return Purchases.getOfferings();
  }

  static Future<CustomerInfo?> purchase(Package package) async {
    if (!isConfigured || !_initialized) return null;
    final info = await Purchases.purchasePackage(package);
    Log.info('subscription_purchase_completed');
    return info;
  }

  static Future<CustomerInfo?> restore() async {
    if (!isConfigured || !_initialized) return null;
    return Purchases.restorePurchases();
  }
}

/// État d'accès de l'utilisateur.
enum AccessState {
  /// Accès complet (droit actif, essai en cours, ou mode local/bêta).
  full,

  /// Abonnement expiré : consulter, exporter, supprimer — jamais créer.
  readOnly,
}

/// État d'accès courant. Sans RevenueCat configuré : accès complet.
final accessStateProvider = StreamProvider<AccessState>((ref) async* {
  if (!SubscriptionService.isConfigured) {
    yield AccessState.full;
    return;
  }
  final info = await SubscriptionService.customerInfo();
  yield _stateFrom(info);
  await for (final update in _customerInfoStream()) {
    yield _stateFrom(update);
  }
});

AccessState _stateFrom(CustomerInfo? info) {
  if (info == null) return AccessState.full;
  final active = info
      .entitlements.active[SubscriptionService.entitlementId]?.isActive;
  return (active ?? false) ? AccessState.full : AccessState.readOnly;
}

Stream<CustomerInfo> _customerInfoStream() {
  late final void Function(CustomerInfo) listener;
  return Stream<CustomerInfo>.multi((controller) {
    listener = controller.add;
    Purchases.addCustomerInfoUpdateListener(listener);
    controller.onCancel = () {
      Purchases.removeCustomerInfoUpdateListener(listener);
    };
  });
}

/// Vrai quand la création est interdite (mode lecture seule).
final isReadOnlyProvider = Provider<bool>((ref) {
  return ref.watch(accessStateProvider).valueOrNull == AccessState.readOnly;
});
