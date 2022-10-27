//

import 'package:drift/drift.dart';
import 'package:my_budget/database/models/account_with_childs.dart';
import 'package:my_budget/database/models/tree_node.dart';

import '../../app_database.dart';
import '../../entities/accounts.dart';
import '../../models/object_label.dart';

part 'accounts_dao.g.dart';

@DriftAccessor(tables: [Accounts])
class AccountsDao extends DatabaseAccessor<AppDatabase>
    with _$AccountsDaoMixin {
  AccountsDao(AppDatabase db) : super(db);

  Future<List<Account>> getAllAccounts() async => await select(accounts).get();

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

  Future<List<ObjectTitle>> accountsTitles() async => select(accounts)
      .map((p0) => ObjectTitle(id: p0.id, title: p0.title))
      .get();

  Future updateAccount(Account account) async =>
      update(accounts).replace(account);
}
