import 'package:bloc/bloc.dart';
import 'package:my_budget/database/models/tree_node.dart';

class OtherSubjectsSelectedCubit extends Cubit<int?> {
  OtherSubjectsSelectedCubit() : super(null);

  void selectNode(TreeNode node) {
    emit(node.id);
  }

  void selectNodeById(int? id) {
    emit(id);
  }
}
