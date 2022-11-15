//

import 'package:drift/drift.dart';

import 'accounts.dart';
import 'debentures.dart';

class Journals extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get debentureId => integer().references(Debentures, #id)();
  IntColumn get related => integer().references(Accounts, #id)();
  BoolColumn get isCredit => boolean()();
  RealColumn get amount => real()();
  TextColumn get notes => text().nullable()();
}
