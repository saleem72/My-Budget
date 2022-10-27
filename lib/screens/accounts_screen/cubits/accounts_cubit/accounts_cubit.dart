//

import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart' as drift;
import 'package:my_budget/database/models/account_with_childs.dart';

import '../../../../database/app_database.dart';
import '../../../../database/models/tree_node.dart';
import '../../../../helpers/constants.dart';

class AccountsCubit extends Cubit<bool> {
  AccountsCubit({
    required this.database,
  }) : super(true);

  List<AccountWithChilds> accounts = [];
  final AppDatabase database;

  void setAccounts(List<AccountWithChilds> data) {
    final selected = getExpandedNodes();
    accounts = data;
    for (final id in selected) {
      final node = accounts.nodeForId(id);
      node?.isExpanded = true;
    }

    emit(!state);
  }

  Future deleteAccount(int? subjectId) async {
    if (subjectId != null) {
      database.subjectsDao.deleteSubject(subjectId);
    }
  }

  Future<int> addAccount(int? parentId, String accountTitle) async {
    expandSelected(parentId);

    final model = SubjectsCompanion.insert(
      parentId: drift.Value(parentId),
      title: accountTitle,
    );
    final addedNodeId = await database.subjectsDao.addSubject(model);
    return addedNodeId;
  }

  void expandSelected(int? id) {
    print(getExpandedNodes());
    if (id != null) {
      final selected = accounts.nodeForId(id);
      if (selected != null) {
        selected.isExpanded = true;

        emit(!state);
      } else {
        print('Node was not found');
      }
    }

    print(getExpandedNodes());
  }

  double heightForNode(TreeNode node) {
    const tileHeight = Constants.subjectTileHeight;
    if (!node.isExpanded) {
      return tileHeight;
    } else {
      if (node.childs.isEmpty) {
        return tileHeight;
      } else {
        final childsHeights = node.childs.map((e) => heightForNode(e)).toList();
        final totalHeight =
            childsHeights.reduce((value, element) => value + element);
        final result = totalHeight;

        return result + tileHeight;
      }
    }
  }

  void toggleExpandedForNode(TreeNode node) {
    node.isExpanded = !node.isExpanded;
    emit(!state);
  }

  List<int> getExpandedNodes() {
    return accounts.getExpandedNodes();
    // final childsExpanded = subjects.map((e) => e.getExpandedNodes()).toList();
    // List<int> allExpandedChilds = [];
    // for (var element in childsExpanded) {
    //   allExpandedChilds.addAll(element);
    // }
    // return allExpandedChilds;
  }

  TreeNode? nodeFromTitle(String title) {
    final list = accounts.treeToList();
    final nodes = list.where(
        (element) => element.title.toLowerCase().contains(title.toLowerCase()));

    final names = nodes.map((e) => e.title).toList();
    print(names);
    return accounts.nodeFromTilte(title);
  }

  List<TreeNode> treeToList() {
    return accounts.treeToList();
  }
}
