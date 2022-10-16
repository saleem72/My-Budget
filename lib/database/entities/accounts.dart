//

import 'package:drift/drift.dart';

class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer().nullable().references(Accounts, #id)();
  TextColumn get title => text().withLength(min: 2)();
}
