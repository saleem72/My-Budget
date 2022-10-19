//

import 'package:flutter/material.dart';
import 'package:my_budget/database/models/subject_with_childs.dart';

import '../models/tree_node.dart';

class SortableTreeNodeList {
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

  static List<TreeNode> sortTree(List<TreeNode> array) {
    final List<TreeNode> sortedArray = [];
    final nullList =
        array.where((element) => element.parentId == null).toList();
    final valueList =
        array.where((element) => element.parentId != null).toList();
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
    debugPrint(resultArray.length.toString());
    return resultArray;
  }

  static SubjectWithChilds? _getSubjectParent(
      List<SubjectWithChilds> array, int id) {
    for (final subject in array) {
      if (subject.id == id) {
        return subject;
      }
    }

    for (final subject in array) {
      final parent = _getSubjectParent(subject.childs, id);
      if (parent != null) {
        return parent;
      }
    }

    return null;
  }

  static List<SubjectWithChilds> sortSubjectsTree(
      List<SubjectWithChilds> array) {
    final List<SubjectWithChilds> sortedArray = [];
    final nullList =
        array.where((element) => element.parentId == null).toList();
    final valueList =
        array.where((element) => element.parentId != null).toList();
    valueList.sort((a, b) => a.parentId!.compareTo(b.parentId!));

    sortedArray.addAll(nullList);
    sortedArray.addAll(valueList);

    final List<SubjectWithChilds> resultArray = [];
    for (final subject in sortedArray) {
      if (subject.parentId == null) {
        resultArray.add(subject);
      } else {
        // Fetch the parent
        final parent = _getSubjectParent(resultArray, subject.parentId!);
        if (parent != null) {
          parent.childs.add(subject);
        }
      }
    }
    return resultArray;
  }
}
