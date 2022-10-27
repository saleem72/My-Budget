//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/buget_database_cubit/budget_database_cubit.dart';
import 'package:my_budget/dependancy_injection.dart' as di;
import 'package:my_budget/helpers/localization/locale_cubit/locale_cubit.dart';
import 'package:my_budget/helpers/routing/nav_links.dart';
import 'package:my_budget/helpers/routing/routes_generator.dart';
import 'package:my_budget/styling/pallet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'screens/sreens_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BudgetDatabaseCubit()),
        BlocProvider(create: (_) => LocaleCubit(safe: di.locator())),
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
            initialRoute: NavLinks.home,
          );
        },
      ),
    );
  }
}

class MainBolcsProviderScreen extends StatelessWidget {
  const MainBolcsProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => BudgetDatabaseCubit())],
      child: MaterialApp(
        title: 'My Budjet',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('ar'),
        theme: ThemeData(
          primarySwatch: Pallet.appBarSwatch,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
