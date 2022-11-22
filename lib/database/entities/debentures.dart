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
  IntColumn get debentureId => integer()
      .customConstraint('REFERENCES debentures(id) ON DELETE CASCADE')();

  IntColumn get account => integer().references(Accounts, #id)();
  IntColumn get releatedAccount => integer().references(Accounts, #id)();
  DateTimeColumn get date => dateTime()();
  RealColumn get debit => real().nullable()();
  RealColumn get credit => real().nullable()();
  TextColumn get notes => text().nullable()();
}
