import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/router.dart';
import 'core/theme/theme.dart';
import 'data/app_providers.dart';
import 'data/remote/auth_repository.dart';
import 'data/subscription/subscription_service.dart';
import 'data/sync/sync_service.dart';

class AmioraApp extends ConsumerStatefulWidget {
  const AmioraApp({super.key});

  @override
  ConsumerState<AmioraApp> createState() => _AmioraAppState();
}

class _AmioraAppState extends ConsumerState<AmioraApp> {
  Timer? _debounce;
  Timer? _periodic;

  @override
  void initState() {
    super.initState();
    // Synchronisation périodique discrète (architecture § 4).
    _periodic = Timer.periodic(const Duration(minutes: 5), (_) {
      ref.read(syncServiceProvider).synchronize();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _periodic?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Chaque mutation locale déclenche une poussée débouncée.
    ref.listen(dbTickProvider, (_, __) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(seconds: 3), () {
        ref.read(syncServiceProvider).synchronize();
      });
    });
    // À la connexion : lier l'abonné RevenueCat puis rapatrier les données.
    ref.listen(sessionProvider, (_, next) {
      final session = next.valueOrNull;
      if (session != null) {
        SubscriptionService.logIn(session.user.id);
        ref.read(syncServiceProvider).synchronize();
      }
    });
    return MaterialApp.router(
      title: 'AMIORA',
      theme: buildAmioraTheme(),
      routerConfig: appRouter,
      locale: const Locale('fr'),
      supportedLocales: const [Locale('fr')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
