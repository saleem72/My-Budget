//

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'database_creation_procedures.dart';
import 'daos/daos_imports.dart';
import 'entities/entities_imports.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}

@DriftDatabase(
  tables: [Subjects],
  daos: [SubjectsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
      onCreate: (m) async {
        await m.createAll();
        await batch((batch) {
          batch.insertAll(subjects, mainSubjects());
          batch.insertAll(subjects, clothesSubSubjects());
          batch.insertAll(subjects, shirtsSubSubjects());
          batch.insertAll(subjects, foodSubSubjects());
          batch.insertAll(subjects, electricitySubSubjects());
        });
      },
    );
  }

  @override
  int get schemaVersion => 1;
}
