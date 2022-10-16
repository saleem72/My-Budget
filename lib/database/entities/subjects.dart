//

import 'package:drift/drift.dart';

class Subjects extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer().nullable().references(Subjects, #id)();
  TextColumn get title => text().withLength(min: 2)();
}
