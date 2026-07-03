import 'package:flutter/material.dart';

import '../../common/placeholder_screen.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(title: 'AMIORA Premium', phase: 5);
  }
}
