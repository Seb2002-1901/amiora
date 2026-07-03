import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/tokens.dart';

/// Splash : logo et slogan, puis entrée dans l'application.
/// (Phase 1 : redirection selon l'état d'authentification Supabase.)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 900), () {
      if (mounted) context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'AMIORA',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: AmioraColors.gold,
                      letterSpacing: 8,
                    ),
              ),
              const SizedBox(height: AmioraSpacing.x3),
              Text(
                'Prends soin des personnes qui comptent.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AmioraColors.text2),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
