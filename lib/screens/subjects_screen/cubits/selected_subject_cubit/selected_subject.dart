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
    print('selectedSubjectCubit selected: $state');
  }

  void selectNodeById(int? id) {
    emit(id);
    print('selectedSubjectCubit selected: $state');
  }
}
