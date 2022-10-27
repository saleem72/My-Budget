// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart' as drift;

import '../../../../database/app_database.dart';
import '../../../../database/models/tree_node.dart';
import '../../../../helpers/constants.dart';

class SubjectsCubit extends Cubit<bool> {
  SubjectsCubit({
    required this.database,
  }) : super(true);

  List<TreeNode> subjects = [];
  final AppDatabase database;

  void setSubjects(List<TreeNode> data) {
    final selected = getExpandedNodes();
    subjects = data;
    for (final id in selected) {
      final node = subjects.nodeForId(id);
      node?.isExpanded = true;
    }

    emit(!state);
  }

  Future deleteSubject(int? subjectId) async {
    if (subjectId != null) {
      database.subjectsDao.deleteSubject(subjectId);
    }
  }

  Future<int> addSubject(int? parentId, String subjectTitle) async {
    expandSelected(parentId);

    final model = SubjectsCompanion.insert(
      parentId: drift.Value(parentId),
      title: subjectTitle,
    );
    final addedNodeId = await database.subjectsDao.addSubject(model);
    return addedNodeId;
  }

  void expandSelected(int? id) {
    if (id != null) {
      final selected = subjects.nodeForId(id);
      if (selected != null) {
        selected.isExpanded = true;

        emit(!state);
      } else {
        // ignore: avoid_print
        print('Node was not found');
      }
    }
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
    return subjects.getExpandedNodes();
    // final childsExpanded = subjects.map((e) => e.getExpandedNodes()).toList();
    // List<int> allExpandedChilds = [];
    // for (var element in childsExpanded) {
    //   allExpandedChilds.addAll(element);
    // }
    // return allExpandedChilds;
  }

  TreeNode? nodeFromTitle(String title) {
    return subjects.nodeFromTilte(title);
  }

  List<TreeNode> treeToList() {
    return subjects.treeToList();
  }
}
