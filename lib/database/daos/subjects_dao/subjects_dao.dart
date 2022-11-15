//

import 'package:my_budget/database/entities/subjects.dart';
import 'package:drift/drift.dart';
import 'package:my_budget/database/models/object_label.dart';
import 'package:my_budget/database/models/subject_title.dart';
import 'package:my_budget/database/models/subject_with_childs.dart';
import 'package:my_budget/database/models/tree_node.dart';

import '../../app_database.dart';

part 'subjects_dao.g.dart';

@DriftAccessor(tables: [Subjects])
class SubjectsDao extends DatabaseAccessor<AppDatabase>
    with _$SubjectsDaoMixin {
  SubjectsDao(AppDatabase db) : super(db);

  Future<List<Subject>> getAllSubjects() async => await select(subjects).get();

  Stream<List<SubjectWithChilds>> watchAllSubjects() {
    return select(subjects)
        .map((item) {
          return SubjectWithChilds.fromSubject(item, false);
        })
        .watch()
        .map((array) {
          // array.forEach((element) {
          //   print(element.toString());
          // });
          // final aaa = SortableTreeNodeList.sortTree(array);
          final aaa = array.sortTree();
          final bbb = aaa.map((e) => e as SubjectWithChilds).toList();
          return bbb;
        });
  }

  Future<int> addSubject(SubjectsCompanion model) async {
    final id = await into(subjects).insert(model);
    return id;
  }

  Future deleteSubject(int id) async {
    final modelList =
        await (select(subjects)..where((tbl) => tbl.id.equals(id))).get();

    if (modelList.isNotEmpty) {
      final model = modelList.first;
      delete(subjects).delete(model);
    }
  }

  Future<List<SubjectTitle>> subjectsTitles() async => select(subjects)
      .map((p0) => SubjectTitle(id: p0.id, title: p0.title))
      .get();
}
