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

  Future localizeAccounts() async {
    for (final item in MainAccounts.values) {
      await _localizeaccount(item);
    }
  }

  Future _localizeaccount(MainAccounts item) async {
    final list = await ((select(accounts)
          ..where((tbl) => tbl.id.equals(item.id)))
        .get());
    final account = list.first;
    await update(accounts).replace(account.copyWith(title: item.arabic));
  }
}

enum MainAccounts { debit, credit, cashier, salary, purchases, bills }

extension MainAccountsDetails on MainAccounts {
  int get id {
    switch (this) {
      case MainAccounts.debit:
        return 1;
      case MainAccounts.credit:
        return 2;
      case MainAccounts.cashier:
        return 3;
      case MainAccounts.salary:
        return 4;
      case MainAccounts.purchases:
        return 5;
      case MainAccounts.bills:
        return 6;
    }
  }

  int? get parentId {
    switch (this) {
      case MainAccounts.debit:
        return null;
      case MainAccounts.credit:
        return null;
      case MainAccounts.cashier:
        return 2;
      case MainAccounts.salary:
        return 2;
      case MainAccounts.purchases:
        return 1;
      case MainAccounts.bills:
        return 1;
    }
  }

  bool get isCredit {
    switch (this) {
      case MainAccounts.debit:
        return false;
      case MainAccounts.credit:
        return true;
      case MainAccounts.cashier:
        return false;
      case MainAccounts.salary:
        return true;
      case MainAccounts.purchases:
        return false;
      case MainAccounts.bills:
        return false;
    }
  }

  String get english {
    switch (this) {
      case MainAccounts.debit:
        return 'Debit';
      case MainAccounts.credit:
        return 'Credit';
      case MainAccounts.cashier:
        return 'Cashier';
      case MainAccounts.salary:
        return 'Salary';
      case MainAccounts.purchases:
        return 'Purchases';
      case MainAccounts.bills:
        return 'Bills';
    }
  }

  String get arabic {
    switch (this) {
      case MainAccounts.debit:
        return 'مدين';
      case MainAccounts.credit:
        return 'دائن';
      case MainAccounts.cashier:
        return 'الصندوق';
      case MainAccounts.salary:
        return 'الراتب';
      case MainAccounts.purchases:
        return 'المشتريات';
      case MainAccounts.bills:
        return 'الفواتير';
    }
  }
}
