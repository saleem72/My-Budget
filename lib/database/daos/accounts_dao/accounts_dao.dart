//

import 'package:drift/drift.dart';
import 'package:my_budget/database/models/account_with_childs.dart';
import 'package:my_budget/database/models/tree_node.dart';
import 'package:collection/collection.dart';

import '../../app_database.dart';
import '../../entities/accounts.dart';
import '../../models/account_title.dart';

part 'accounts_dao.g.dart';

@DriftAccessor(tables: [Accounts])
class AccountsDao extends DatabaseAccessor<AppDatabase>
    with _$AccountsDaoMixin {
  AccountsDao(AppDatabase db) : super(db);

  Future<List<Account>> getAllAccounts() async => await select(accounts).get();

  Future<Account?> getAccountForId(int id) async {
    final temp =
        await ((select(accounts)..where((tbl) => tbl.id.equals(id))).get());
    return temp.firstOrNull;
  }

  Future<Account?> getAccountForTitle(String title) async {
    final temp = await ((select(accounts)
          ..where((tbl) => tbl.title.equals(title)))
        .get());
    return temp.firstOrNull;
  }

  Stream<List<AccountWithChilds>> watchAllAccounts() {
    return select(accounts)
        .map((item) => AccountWithChilds.fromSubject(item))
        .watch()
        .map((array) {
      // array.forEach((element) {
      //   print(element.toString());
      // });
      final aaa = array.sortTree();
      return aaa.map((e) => e as AccountWithChilds).toList();
    });
  }

  Future<List<AccountTitle>> accountsTitles() async => select(accounts)
      .map((p0) =>
          AccountTitle(id: p0.id, title: p0.title, isCredit: p0.isCredit))
      .get();

  Future updateAccount(Account account) async =>
      update(accounts).replace(account);
}
