//

import 'package:drift/drift.dart';

import 'app_database.dart';

class DatabaseUtils {
  DatabaseUtils._();

// indebted credit
  static List<AccountsCompanion> mainAccounts() => [
        AccountsCompanion.insert(
            id: const Value(1), title: 'Debit', isCredit: false),
        AccountsCompanion.insert(
            id: const Value(2), title: 'Credit', isCredit: true),
      ];

// cashier salary
  static List<AccountsCompanion> indebtedSubAccounts() => [
        AccountsCompanion.insert(
            id: const Value(3),
            parentId: const Value(2),
            title: 'Cashier',
            isCredit: false),
        AccountsCompanion.insert(
          id: const Value(4),
          parentId: const Value(2),
          title: 'Salary',
          isCredit: true,
        ),
      ];

// cashier salary
  static List<AccountsCompanion> creditSubAccounts() => [
        AccountsCompanion.insert(
          id: const Value(5),
          parentId: const Value(1),
          title: 'Purchases',
          isCredit: false,
        ),
        AccountsCompanion.insert(
          id: const Value(6),
          parentId: const Value(1),
          title: 'Bills',
          isCredit: false,
        ),
      ];

  static List<SubjectsCompanion> mainSubjects() => [
        SubjectsCompanion.insert(id: const Value(1), title: 'Food'),
        SubjectsCompanion.insert(id: const Value(2), title: 'Electricity'),
        SubjectsCompanion.insert(id: const Value(3), title: 'CLothes'),
      ];

  static List<SubjectsCompanion> foodSubSubjects() => [
        SubjectsCompanion.insert(parentId: const Value(1), title: 'Bread'),
        SubjectsCompanion.insert(parentId: const Value(1), title: 'Apple'),
        SubjectsCompanion.insert(parentId: const Value(1), title: 'Banana'),
      ];

  static List<SubjectsCompanion> electricitySubSubjects() => [
        SubjectsCompanion.insert(parentId: const Value(2), title: 'Microwave'),
        SubjectsCompanion.insert(parentId: const Value(2), title: 'TV'),
        SubjectsCompanion.insert(parentId: const Value(2), title: 'Fan'),
      ];

  static List<SubjectsCompanion> clothesSubSubjects() => [
        SubjectsCompanion.insert(
            id: const Value(4), parentId: const Value(3), title: 'Shirt'),
        SubjectsCompanion.insert(
            id: const Value(5), parentId: const Value(3), title: 'Dresses'),
        SubjectsCompanion.insert(parentId: const Value(3), title: 'Trousers'),
      ];

  static List<SubjectsCompanion> shirtsSubSubjects() => [
        SubjectsCompanion.insert(parentId: const Value(4), title: 'Green'),
        SubjectsCompanion.insert(parentId: const Value(4), title: 'Pink'),
        SubjectsCompanion.insert(parentId: const Value(4), title: 'White'),
        SubjectsCompanion.insert(parentId: const Value(5), title: 'Type 1'),
        SubjectsCompanion.insert(parentId: const Value(5), title: 'Type 2'),
        SubjectsCompanion.insert(parentId: const Value(5), title: 'Type 3'),
      ];

  static List<AccountsCompanion> allAccounts() {
    final List<AccountsCompanion> array = [];
    for (final account in MainAccounts.values) {
      final item = AccountsCompanion.insert(
        id: Value(account.id),
        parentId: Value(account.parentId),
        isCredit: account.isCredit,
        title: account.english,
      );
      array.add(item);
    }
    return array;
  }
}
