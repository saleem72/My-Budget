//

// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables

import '../app_database.dart';
import 'tree_node.dart';

class AccountWithChilds extends TreeNode {
  @override
  final int id;

  @override
  final int? parentId;

  @override
  final String title;

  @override
  bool isExpanded;

  @override
  final List<AccountWithChilds> childs;

  final bool isCredit;

  final Account? account;
  AccountWithChilds({
    required this.id,
    this.parentId,
    required this.title,
    required this.childs,
    required this.isCredit,
    this.isExpanded = false,
    this.account,
  });

  factory AccountWithChilds.fromSubject(Account account) {
    return AccountWithChilds(
      id: account.id,
      parentId: account.parentId,
      title: account.title,
      isCredit: account.isCredit,
      account: account,
      childs: [],
    );
  }

  @override
  List<Object?> get props => [id];
}
