//

import 'package:flutter/material.dart';
import 'package:my_budget/helpers/routing/nav_links.dart';
import 'package:my_budget/helpers/routing/routing_error_screen.dart';
import 'package:my_budget/screens/sreens_imports.dart';

class RoutesGenerator {
  RoutesGenerator._();

  static Route<dynamic> generate(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case NavLinks.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case NavLinks.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        final String errorMessage = '${settings.name} is not valid route';
        return MaterialPageRoute(
            builder: (_) => RoutingErrorScreen(errorMessage: errorMessage));
    }
  }
}
