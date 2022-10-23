//

import 'package:equatable/equatable.dart';

abstract class TreeNode extends Equatable {
  int get id;
  int? get parentId;
  String get title;
  List<TreeNode> get childs;

  bool get isExpanded;
  set isExpanded(bool isExpanded);

  List<int> _expandedChilds(TreeNode node) {
    if (node.childs.isNotEmpty) {
      List<int> allExpandedChilds = [];
      for (final child in node.childs) {
        final array = _expandedChilds(child);
        if (array.isNotEmpty) {
          allExpandedChilds.addAll(array);
        }
      }

      if (node.isExpanded) {
        allExpandedChilds.add(node.id);
      }
      return allExpandedChilds;
    } else {
      if (node.isExpanded) {
        return [id];
      } else {
        return [];
      }
    }
  }

  List<int> getExpandedNodes() {
    final result = _expandedChilds(this);
    return result;
  }
}

extension MyCustomList on List<TreeNode> {
  TreeNode? _nodeForId(List<TreeNode> array, int id) {
    for (final node in array) {
      if (node.id == id) {
        return node;
      }
      if (node.childs.isNotEmpty) {
        final optional = _nodeForId(node.childs, id);
        if (optional != null) {
          return optional;
        }
      } else {
        return null;
      }
    }
    return null;
  }

  static TreeNode? _getParent(List<TreeNode> array, int id) {
    for (final subject in array) {
      if (subject.id == id) {
        return subject;
      }
    }

    for (final subject in array) {
      final parent = _getParent(subject.childs, id);
      if (parent != null) {
        return parent;
      }
    }

    return null;
  }

  List<TreeNode> sortTree() {
    final List<TreeNode> sortedArray = [];
    final nullList = where((element) => element.parentId == null).toList();
    final valueList = where((element) => element.parentId != null).toList();
    valueList.sort((a, b) => a.parentId!.compareTo(b.parentId!));

    sortedArray.addAll(nullList);
    sortedArray.addAll(valueList);

    final List<TreeNode> resultArray = [];
    for (final subject in sortedArray) {
      if (subject.parentId == null) {
        resultArray.add(subject);
      } else {
        // Fetch the parent
        final parent = _getParent(resultArray, subject.parentId!);
        if (parent != null) {
          parent.childs.add(subject);
        }
      }
    }
    return resultArray;
  }

  TreeNode? nodeForId(int id) {
    return _nodeForId(this, id);
  }
}
