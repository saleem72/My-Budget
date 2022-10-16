//

import 'package:my_budget/database/entities/subjects.dart';
import 'package:drift/drift.dart';
import 'package:my_budget/database/extensions/sortable_tree_node_list.dart';
import 'package:my_budget/database/models/subject_with_childs.dart';

import '../../app_database.dart';

part 'subjects_dao.g.dart';

@DriftAccessor(tables: [Subjects])
class SubjectsDao extends DatabaseAccessor<AppDatabase>
    with _$SubjectsDaoMixin {
  SubjectsDao(AppDatabase db) : super(db);

  Future<List<Subject>> getAllSubjects() async => await select(subjects).get();

  Stream<List<SubjectWithChilds>> watchAllSubjects() {
    return select(subjects)
        .map((item) => SubjectWithChilds.fromSubject(item))
        .watch()
        .map((array) {
      // array.forEach((element) {
      //   print(element.toString());
      // });
      final aaa = SortableTreeNodeList.sortTree(array);
      return aaa.map((e) => e as SubjectWithChilds).toList();
    });
  }
}
