//

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../helpers/localization/language.dart';
import 'database_creation_procedures.dart';
import 'daos/daos_imports.dart';
import 'entities/entities_imports.dart';
import 'models/main_accounts.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [
    Subjects,
    Accounts,
    Debentures,
    DebentureItems,
    Bills,
    BillItems,
    Journals,
  ],
  daos: [
    SubjectsDao,
    AccountsDao,
    DebenturesDao,
    BillsDao,
    JournalsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase({required this.arabicAccounts}) : super(_openConnection());
  final bool arabicAccounts;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
      onCreate: (m) async {
        await m.createAll();
        await batch((batch) {
          batch.insertAll(subjects, DatabaseUtils.mainSubjects());
          batch.insertAll(subjects, DatabaseUtils.clothesSubSubjects());
          batch.insertAll(subjects, DatabaseUtils.shirtsSubSubjects());
          batch.insertAll(subjects, DatabaseUtils.foodSubSubjects());
          batch.insertAll(subjects, DatabaseUtils.electricitySubSubjects());

          batch.insertAll(accounts, DatabaseUtils.allAccounts());
          // batch.insertAll(accounts, DatabaseUtils.mainAccounts());
          // batch.insertAll(accounts, DatabaseUtils.indebtedSubAccounts());
          // batch.insertAll(accounts, DatabaseUtils.creditSubAccounts());
        });
      },
    );
  }

  @override
  int get schemaVersion => 1;

  Future localizeAccounts(Language language) async {
    for (final item in MainAccounts.values) {
      await _localizeaccount(item, language);
    }

    for (final item in CreditMainAccounts.values) {
      await _localizeaccount(item, language);
    }

    for (final item in DebitMainAccounts.values) {
      await _localizeaccount(item, language);
    }
  } //الص

  Future _localizeaccount(AppAccount item, Language language) async {
    final list = await ((select(accounts)
          ..where((tbl) => tbl.id.equals(item.id)))
        .get());
    final account = list.first;
    await update(accounts).replace(account.copyWith(
        title: language == Language.arabic ? item.arabic : item.english));
  }
}
