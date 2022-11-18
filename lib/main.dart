//

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_theme/json_theme.dart';
import 'package:my_budget/database/buget_database_cubit/budget_database_cubit.dart';
import 'package:my_budget/dependancy_injection.dart' as di;
import 'package:my_budget/helpers/localization/locale_cubit/locale_cubit.dart';
import 'package:my_budget/helpers/routing/nav_links.dart';
import 'package:my_budget/helpers/routing/routes_generator.dart';
import 'package:my_budget/helpers/safe/safe.dart';
import 'package:my_budget/styling/pallet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'styling/styling.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();

  final themeStr =
      await rootBundle.loadString('assets/jsons/another_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(MyApp(themeData: theme));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final Safe safe = di.locator();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocaleCubit(safe: safe)),
        BlocProvider(create: (_) => BudgetDatabaseCubit()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, state) {
          return MaterialApp(
            title: 'My Budjet',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: state,
            theme: ThemeData(
              primarySwatch: Pallet.appBarSwatch,
            ),
            onGenerateRoute: RoutesGenerator.generate,
            initialRoute: NavLinks.initial,
          );
        },
      ),
    );
  }
}
