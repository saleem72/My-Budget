import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_budget/database/models/subject_with_childs.dart';
import 'package:my_budget/database/models/tree_node.dart';

class SubjectsTreeSelectedNodeCubit extends Cubit<TreeNode?> {
  SubjectsTreeSelectedNodeCubit() : super(null);

  selectNode(TreeNode node) {
    if (state != node) {
      emit(node);
    }
  }
}
