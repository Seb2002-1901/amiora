import 'package:flutter/material.dart';

import '../../../core/theme/tokens.dart';

/// Feuille « Ajouter une interaction » — le geste central du produit.
/// Contrat (PRD V1.2 + Sprint 0 livrable 2) : personne + type obligatoires,
/// tout le reste facultatif, enregistrement en moins de 10 secondes.
/// Squelette de Phase 3 : structure, grille fluide et bouton ; le câblage
/// aux repositories arrive avec la Phase 3.
class AddInteractionSheet extends StatelessWidget {
  const AddInteractionSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const AddInteractionSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      // Respecte le clavier et la barre de gestes.
      padding: EdgeInsets.only(
        left: AmioraSpacing.x4,
        right: AmioraSpacing.x4,
        bottom: MediaQuery.viewInsetsOf(context).bottom + AmioraSpacing.x4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Ajouter une interaction', style: theme.textTheme.titleMedium),
          const SizedBox(height: AmioraSpacing.x2),
          Text(
            'Avec qui, et quoi — le reste est facultatif.',
            style: theme.textTheme.bodyMedium!
                .copyWith(color: AmioraColors.text2),
          ),
          const SizedBox(height: AmioraSpacing.x4),
          // Phase 3 : rangée d'avatars (personnes), grille fluide des
          // 10 types (auto-fill ~72 dp), date pré-remplie « Aujourd'hui »,
          // lien « Ajouter des détails », haptique légère au succès.
          const PlaceholderRows(),
          const SizedBox(height: AmioraSpacing.x4),
          FilledButton(
            onPressed: null, // Activé quand personne + type sont choisis.
            child: const Text('Enregistrer'),
          ),
          const SizedBox(height: AmioraSpacing.x2),
        ],
      ),
    );
  }
}

class PlaceholderRows extends StatelessWidget {
  const PlaceholderRows({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: AmioraColors.surfaceRaised,
        borderRadius: BorderRadius.circular(AmioraRadii.field),
      ),
      alignment: Alignment.center,
      child: Text(
        'Sélection personne + type — Phase 3',
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AmioraColors.text3),
      ),
    );
  }
}
