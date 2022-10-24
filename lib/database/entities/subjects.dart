//

import 'package:drift/drift.dart';

/*
A foreign key with cascade delete means that if a record in the parent table is deleted, 
then the corresponding records in the child table will automatically be deleted. 
This is called a cascade delete in SQLite.
*/

class Subjects extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer()
      .nullable()
      .customConstraint('REFERENCES subjects(id) ON DELETE CASCADE')();
  TextColumn get title => text().withLength(min: 2)();
}
