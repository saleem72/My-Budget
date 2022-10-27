// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:my_budget/database/models/tree_node.dart';

class SelectedSubjectCubit extends Cubit<int?> {
  SelectedSubjectCubit() : super(null);

  void selectNode(TreeNode node) {
    if (state == node.id) {
      emit(null);
    } else {
      emit(node.id);
    }
  }

  void selectNodeById(int? id) {
    emit(id);
  }
}
