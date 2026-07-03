import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/subscription/subscription_service.dart';

/// Garde d'écriture (mode lecture seule après expiration — PRD V1.2) :
/// consulter, exporter, supprimer restent libres ; créer et modifier
/// redirigent vers la réactivation. Retourne vrai si l'écriture est permise.
bool ensureWritable(BuildContext context, WidgetRef ref) {
  if (!ref.read(isReadOnlyProvider)) return true;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text(
        'Ton abonnement a expiré — tes souvenirs restent à toi. '
        'Réactive AMIORA pour continuer à créer.',
      ),
      action: SnackBarAction(
        label: 'Réactiver',
        onPressed: () => context.push('/paywall'),
      ),
    ),
  );
  return false;
}
