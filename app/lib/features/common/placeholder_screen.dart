import 'package:flutter/material.dart';

import '../../core/layout/breakpoints.dart';
import '../../core/theme/tokens.dart';

/// Écran provisoire d'une fonctionnalité planifiée : affiche le titre
/// réel de l'écran et sa phase de construction (PRD V1.2 — ordre de
/// développement obligatoire). Remplacé au fil des phases.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.phase,
    this.withAppBar = true,
  });

  final String title;
  final int phase;
  final bool withAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: withAppBar ? AppBar(title: Text(title)) : null,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.gutter),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AmioraSpacing.x2),
                Text(
                  'À construire — Phase $phase',
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
      ),
    );
  }
}
