import 'package:flutter/material.dart';

import '../../common/placeholder_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(title: 'Bienvenue sur AMIORA', phase: 1);
  }
}
