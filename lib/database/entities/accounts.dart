//

import 'package:drift/drift.dart';

class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer()
      .nullable()
      .customConstraint('REFERENCES accounts(id) ON DELETE CASCADE')();
  TextColumn get title => text().withLength(min: 2)();
}
