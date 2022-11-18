// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

import '../app_database.dart';

class BudgetDatabaseCubit extends Cubit<String?> {
  final bool? arabicAccounts;
  final AppDatabase _database;
  BudgetDatabaseCubit({this.arabicAccounts})
      : _database = AppDatabase(arabicAccounts: arabicAccounts ?? false),
        super(null);

  AppDatabase get database => _database;
}
