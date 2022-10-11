import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_budget/database/models/subject_with_childs.dart';

class SubjectsTreeSelectedNodeCubit extends Cubit<SubjectWithChilds?> {
  SubjectsTreeSelectedNodeCubit() : super(null);

  selectNode(SubjectWithChilds node) {
    if (state != node) {
      emit(node);
    }
  }
}
