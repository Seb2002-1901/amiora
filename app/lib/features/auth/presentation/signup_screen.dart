import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/errors/app_exception.dart';
import '../../../core/layout/breakpoints.dart';
import '../../../core/theme/tokens.dart';
import '../../../data/remote/auth_repository.dart';
import '../../../data/remote/supabase_service.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _accepted = false;
  bool _busy = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  /// Validation raisonnable d'une adresse : partie locale, @, domaine, point.
  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  bool get _valid =>
      _accepted &&
      _emailPattern.hasMatch(_email.text.trim()) &&
      _password.text.length >= 10 &&
      !_busy;

  Future<void> _signup() async {
    setState(() => _busy = true);
    try {
      await ref.read(authRepositoryProvider).signUpWithEmail(
            email: _email.text.trim(),
            password: _password.text,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Compte créé — vérifie ta boîte e-mail.'),
          ),
        );
        context.go('/home');
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
    return Scaffold(
      appBar: AppBar(title: const Text('Créer mon compte')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: context.gutter,
                vertical: AmioraSpacing.x4,
              ),
              children: [
                if (!SupabaseService.isConfigured)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AmioraSpacing.x4),
                      child: Text(
                        'Mode local : la création de compte en ligne sera '
                        'activée quand le backend sera configuré.',
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: AmioraColors.text2),
                      ),
                    ),
                  )
                else ...[
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AmioraSpacing.x3),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Mot de passe',
                      helperText: 'Au moins 10 caractères.',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AmioraSpacing.x4),
                  CheckboxListTile(
                    value: _accepted,
                    onChanged: (v) => setState(() => _accepted = v ?? false),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "J'accepte les Conditions générales et la "
                      'Politique de confidentialité.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: AmioraSpacing.x3),
                  FilledButton(
                    onPressed: _valid ? _signup : null,
                    child: const Text('Créer mon compte'),
                  ),
                  const SizedBox(height: AmioraSpacing.x3),
                  Center(
                    child: Text(
                      'Tes données restent privées : jamais partagées, '
                      'jamais vendues, jamais de publicité.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: AmioraColors.text3),
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
