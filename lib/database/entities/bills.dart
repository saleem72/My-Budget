//

import 'package:drift/drift.dart';

class Bills extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get date => dateTime()();
  RealColumn get total => real()();
}

class BillItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer()
      .nullable()
      .customConstraint('REFERENCES bills(id) ON DELETE CASCADE')();

  IntColumn get subjectId => integer()
      .nullable()
      .customConstraint('REFERENCES subjects(id) ON DELETE CASCADE')();
  IntColumn get quantity => integer().withDefault(const Constant(1))();

  RealColumn get price => real()();
  TextColumn get notes => text().nullable()();
}
