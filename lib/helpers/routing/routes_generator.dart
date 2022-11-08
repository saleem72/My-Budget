//

import 'package:flutter/material.dart';
import 'package:my_budget/helpers/routing/nav_links.dart';
import 'package:my_budget/helpers/routing/routing_error_screen.dart';
import 'package:my_budget/screens/sreens_imports.dart';

import '../../database/app_database.dart';

class RoutesGenerator {
  RoutesGenerator._();

  static Route<dynamic> generate(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case NavLinks.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case NavLinks.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case NavLinks.subjects:
        return MaterialPageRoute(builder: (_) => const SubjectsScreen());
      case NavLinks.accounts:
        return MaterialPageRoute(builder: (_) => const AccountsScreen());
      case NavLinks.journal:
        return MaterialPageRoute(builder: (_) => const JournalScreen());
      case NavLinks.accountStatment:
        return MaterialPageRoute(builder: (_) => const AccountStatmentScreen());
      case NavLinks.bills:
        return MaterialPageRoute(builder: (_) => const BillsScreen());
      case NavLinks.addBill:
        final bill = arguments as Bill?;
        return MaterialPageRoute(builder: (_) => AddBillScreen(bill: bill));
      case NavLinks.aboutUs:
        return MaterialPageRoute(builder: (_) => const AboutUsScreen());
      default:
        final String errorMessage = '${settings.name} is not valid route';
        return MaterialPageRoute(
            builder: (_) => RoutingErrorScreen(errorMessage: errorMessage));
    }
  }
}
