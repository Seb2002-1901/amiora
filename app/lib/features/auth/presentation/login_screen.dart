import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show OAuthProvider;

import '../../../core/errors/app_exception.dart';
import '../../../core/layout/breakpoints.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/remote/auth_repository.dart';
import '../../../data/remote/supabase_service.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  /// Enchaîne une action d'authentification : verrouille l'interface et
  /// affiche les erreurs avec douceur. Aucune navigation ici : le routeur
  /// (refreshListenable) redirige de lui-même quand la session arrive —
  /// le retour de signInWithOAuth signifie seulement « navigateur ouvert ».
  Future<void> _run(
    Future<void> Function() action, {
    String? successMessage,
  }) async {
    setState(() => _busy = true);
    try {
      await action();
      if (mounted && successMessage != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(successMessage)));
      }
    } on AppException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final auth = ref.read(authRepositoryProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: context.gutter,
                vertical: AmioraSpacing.x6,
              ),
              children: [
                Center(
                  child: Text(
                    'AMIORA',
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: AmioraColors.gold,
                      letterSpacing: 6,
                    ),
                  ),
                ),
                const SizedBox(height: AmioraSpacing.x2),
                Center(
                  child: Text(
                    'Heureux de te revoir.',
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: AmioraColors.text2),
                  ),
                ),
                const SizedBox(height: AmioraSpacing.x6),
                if (!SupabaseService.isConfigured) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AmioraSpacing.x4),
                      child: Text(
                        'Mode local : le compte en ligne sera activé quand '
                        'le backend sera configuré. Tes données vivent sur '
                        'cet appareil.',
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: AmioraColors.text2),
                      ),
                    ),
                  ),
                  const SizedBox(height: AmioraSpacing.x4),
                  FilledButton(
                    onPressed: () => context.go('/home'),
                    child: const Text('Continuer en local'),
                  ),
                ] else ...[
                  OutlinedButton.icon(
                    icon: const Icon(Icons.apple, size: 22),
                    label: const Text('Continuer avec Apple'),
                    onPressed: _busy
                        ? null
                        : () => _run(
                              () => auth
                                  .signInWithProvider(OAuthProvider.apple),
                              successMessage:
                                  'Connexion en cours dans le navigateur…',
                            ),
                  ),
                  const SizedBox(height: AmioraSpacing.x3),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.g_mobiledata, size: 28),
                    label: const Text('Continuer avec Google'),
                    onPressed: _busy
                        ? null
                        : () => _run(
                              () => auth
                                  .signInWithProvider(OAuthProvider.google),
                              successMessage:
                                  'Connexion en cours dans le navigateur…',
                            ),
                  ),
                  const SizedBox(height: AmioraSpacing.x4),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AmioraSpacing.x3,
                        ),
                        child: Text(
                          'ou',
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: AmioraColors.text3),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: AmioraSpacing.x4),
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    // Rebuild à chaque frappe : active « Mot de passe
                    // oublié ? » dès que l'adresse est saisie.
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AmioraSpacing.x3),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration:
                        const InputDecoration(labelText: 'Mot de passe'),
                  ),
                  const SizedBox(height: AmioraSpacing.x4),
                  FilledButton(
                    onPressed: _busy
                        ? null
                        : () => _run(
                              () => auth.signInWithEmail(
                                email: _email.text.trim(),
                                password: _password.text,
                              ),
                            ),
                    child: _busy
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Se connecter'),
                  ),
                  const SizedBox(height: AmioraSpacing.x3),
                  Center(
                    child: TextButton(
                      onPressed: _busy || _email.text.trim().isEmpty
                          ? null
                          : () => _run(
                                () =>
                                    auth.sendPasswordReset(_email.text.trim()),
                                successMessage:
                                    'E-mail de réinitialisation envoyé.',
                              ),
                      child: const Text('Mot de passe oublié ?'),
                    ),
                  ),
                  const SizedBox(height: AmioraSpacing.x2),
                  Center(
                    child: TextButton(
                      onPressed: () => context.go('/signup'),
                      child: const Text('Créer un compte'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
