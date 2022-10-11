//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/buget_database_cubit/budget_database_cubit.dart';
import 'package:my_budget/styling/pallet.dart';

import 'screens/sreens_imports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Budjet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Pallet.appBarSwatch,
      ),
      home: const MainBolcsProviderScreen(),
    );
  }
}

class MainBolcsProviderScreen extends StatelessWidget {
  const MainBolcsProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => BudgetDatabaseCubit())],
      child: const HomeScreen(),
    );
  }
}
