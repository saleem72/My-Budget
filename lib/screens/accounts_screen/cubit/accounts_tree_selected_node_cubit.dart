// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_budget/database/models/account_with_childs.dart';

import '../../../database/app_database.dart';

class AccountsTreeSelectedNodeCubit extends Cubit<AccountWithChilds?> {
  final AppDatabase database;
  AccountsTreeSelectedNodeCubit({
    required this.database,
  }) : super(null);
  selectNode(AccountWithChilds node) {
    debugPrint('SubjectsTreeSelectedNodeCubit, selectNode');
    if (state != node) {
      emit(node);
    }
  }

  Future addSubject() async {
    debugPrint('Subject is about to be added');
  }

  Future deleteSubject() async {
    debugPrint('Subject is about to be DELETED');
  }
}
