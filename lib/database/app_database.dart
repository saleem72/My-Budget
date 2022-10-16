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
  tables: [Subjects, Accounts, Debentures, DebentureItems],
  daos: [SubjectsDao, AccountsDao, DebenturesDao],
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

          batch.insertAll(accounts, mainAccounts());
          batch.insertAll(accounts, indebtedSubAccounts());
          batch.insertAll(accounts, creditSubAccounts());
        });
      },
    );
  }

  @override
  int get schemaVersion => 1;
}

// indebted credit
List<AccountsCompanion> mainAccounts() => [
      AccountsCompanion.insert(id: const Value(1), title: 'Debit'),
      AccountsCompanion.insert(id: const Value(2), title: 'Credit'),
    ];

// cashier salary
List<AccountsCompanion> indebtedSubAccounts() => [
      AccountsCompanion.insert(
          id: const Value(3), parentId: const Value(1), title: 'Cashier'),
      AccountsCompanion.insert(parentId: const Value(1), title: 'Salary'),
    ];

// cashier salary
List<AccountsCompanion> creditSubAccounts() => [
      AccountsCompanion.insert(parentId: const Value(2), title: 'Purchases'),
      AccountsCompanion.insert(parentId: const Value(2), title: 'Bills'),
    ];
