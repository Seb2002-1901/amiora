import 'package:flutter/material.dart';

import '../theme/tokens.dart';
import 'breakpoints.dart';

/// Destination de la coquille de navigation.
class ShellDestination {
  const ShellDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

/// Coquille adaptative de l'application (design system § 9) :
/// - compact : barre de navigation basse à 5 emplacements, « + » central ;
/// - medium/expanded : NavigationRail à gauche, contenu centré à 600 dp.
/// SafeArea est appliquée ici pour tous les écrans du shell.
class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.destinations,
    required this.onDestinationSelected,
    required this.onCreatePressed,
  });

  final Widget body;

  /// Index de branche (0..3) : Accueil, Relations, Souvenirs, Profil.
  final int selectedIndex;
  final List<ShellDestination> destinations;
  final ValueChanged<int> onDestinationSelected;

  /// Action du bouton central « + » (feuille « Ajouter une interaction »).
  final VoidCallback onCreatePressed;

  @override
  Widget build(BuildContext context) {
    final sizeClass = context.sizeClass;
    final constrainedBody = SafeArea(
      child: sizeClass == SizeClass.compact
          ? body
          : Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
                child: body,
              ),
            ),
    );

    if (sizeClass == SizeClass.compact) {
      return Scaffold(
        body: constrainedBody,
        bottomNavigationBar: _CompactNavBar(
          selectedIndex: selectedIndex,
          destinations: destinations,
          onDestinationSelected: onDestinationSelected,
          onCreatePressed: onCreatePressed,
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              backgroundColor: AmioraColors.surface,
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: AmioraSpacing.x3),
                child: _CreateButton(onPressed: onCreatePressed),
              ),
              destinations: [
                for (final d in destinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selectedIcon, color: AmioraColors.gold),
                    label: Text(d.label),
                  ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(child: constrainedBody),
        ],
      ),
    );
  }
}

class _CompactNavBar extends StatelessWidget {
  const _CompactNavBar({
    required this.selectedIndex,
    required this.destinations,
    required this.onDestinationSelected,
    required this.onCreatePressed,
  });

  final int selectedIndex;
  final List<ShellDestination> destinations;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onCreatePressed;

  @override
  Widget build(BuildContext context) {
    assert(destinations.length == 4, 'Quatre branches + le « + » central.');
    // SafeArea basse : respecte la barre de gestes iOS/Android.
    return Container(
      decoration: const BoxDecoration(
        color: AmioraColors.surface,
        border: Border(top: BorderSide(color: AmioraColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              _navItem(context, 0),
              _navItem(context, 1),
              Expanded(child: Center(child: _CreateButton(onPressed: onCreatePressed))),
              _navItem(context, 2),
              _navItem(context, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(BuildContext context, int index) {
    final d = destinations[index];
    final selected = index == selectedIndex;
    final color = selected ? AmioraColors.gold : AmioraColors.text2;
    return Expanded(
      child: InkWell(
        onTap: () => onDestinationSelected(index),
        child: Semantics(
          selected: selected,
          button: true,
          label: d.label,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(selected ? d.selectedIcon : d.icon, color: color, size: 24),
              const SizedBox(height: 2),
              Text(
                d.label,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: color, fontSize: 11),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Ajouter une interaction',
      child: Material(
        color: AmioraColors.gold,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: const SizedBox(
            width: 48,
            height: 48,
            child: Icon(Icons.add, color: AmioraColors.onGold, size: 28),
          ),
        ),
      ),
    );
  }
}
