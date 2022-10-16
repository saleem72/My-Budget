//

import 'package:drift/drift.dart';
import 'package:my_budget/database/models/account_with_childs.dart';

import '../../app_database.dart';
import '../../entities/accounts.dart';
import '../../extensions/sortable_tree_node_list.dart';

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
      final aaa = SortableTreeNodeList.sortTree(array);
      return aaa.map((e) => e as AccountWithChilds).toList();
    });
  }
}
