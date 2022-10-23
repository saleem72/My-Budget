//

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
  AccountWithChilds({
    required this.id,
    this.parentId,
    required this.title,
    required this.childs,
    this.isExpanded = false,
  });

  factory AccountWithChilds.fromSubject(Account subject) {
    return AccountWithChilds(
      id: subject.id,
      parentId: subject.parentId,
      title: subject.title,
      childs: [],
    );
  }

  @override
  List<Object?> get props => [id];
}
