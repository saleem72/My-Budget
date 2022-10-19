import 'package:bloc/bloc.dart';
import 'package:my_budget/database/models/subject_with_childs.dart';

import '../../../database/app_database.dart';

class SubjectsTreeSelectedNodeCubit extends Cubit<SubjectWithChilds?> {
  SubjectsTreeSelectedNodeCubit({
    required this.database,
  }) : super(null);
  final AppDatabase database;
  selectNode(SubjectWithChilds node) {
    print('SubjectsTreeSelectedNodeCubit, selectNode');
    if (state != node) {
      emit(node);
    }
  }

  Future addSubject() async {
    print('Subject is about to be added');
  }

  Future deleteSubject() async {
    print('Subject is about to be DELETED');
  }
}
