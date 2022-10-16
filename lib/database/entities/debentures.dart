// debentures

import 'package:drift/drift.dart';
import 'package:my_budget/database/entities/accounts.dart';

class Debentures extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get source => integer()();
  IntColumn get sourceId => integer()();
}

class DebentureItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get debentureId => integer().references(Debentures, #id)();
  IntColumn get debit => integer().references(Accounts, #id)();
  IntColumn get credit => integer().references(Accounts, #id)();
  DateTimeColumn get date => dateTime()();
  RealColumn get amount => real()();
  TextColumn get notes => text().nullable()();
}
