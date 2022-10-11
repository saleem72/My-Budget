import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../app_database.dart';

class BudgetDatabaseCubit extends Cubit<String?> {
  final AppDatabase _database = AppDatabase();
  BudgetDatabaseCubit() : super(null);

  AppDatabase get database => _database;
}
