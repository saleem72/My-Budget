// debentures

import 'package:drift/drift.dart';
import 'package:my_budget/database/entities/accounts.dart';

class Debentures extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// the opreation type(bill, journal, ....) which generate this Debentures
  IntColumn get source => integer()();

  /// the opreation id which generate this Debentures
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

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get debentureId => integer().references(Debentures, #id)();
  IntColumn get source => integer().references(Accounts, #id)();
  IntColumn get related => integer().references(Accounts, #id)();
  BoolColumn get isCredit => boolean().withDefault(const Constant(false))();

  DateTimeColumn get date => dateTime()();
  RealColumn get amount => real()();
  TextColumn get notes => text().nullable()();
}
