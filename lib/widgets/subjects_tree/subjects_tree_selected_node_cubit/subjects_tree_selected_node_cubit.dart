// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_budget/database/models/tree_node.dart';
import 'package:drift/drift.dart' as drift;

import '../../../database/app_database.dart';

class TreeSelectedNodeCubit extends Cubit<TreeNode?> {
  TreeSelectedNodeCubit({
    required this.database,
  }) : super(null);
  final AppDatabase database;
  selectNode(TreeNode node) {
    if (state != node) {
      emit(node);
    } else {
      emit(null);
    }
  }

  Future addSubject(String subjectTitle) async {
    final parentId = state?.id;
    final model = SubjectsCompanion.insert(
      parentId: drift.Value(parentId),
      title: subjectTitle,
    );
    database.subjectsDao.addSubject(model);
  }

  Future deleteSubject() async {
    debugPrint('Subject is about to be DELETED');
  }

  Future addAccount() async {
    debugPrint('Subject is about to be added');
  }

  Future deleteAccount() async {
    debugPrint('Subject is about to be DELETED');
  }
}
