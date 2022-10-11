//
//

import 'package:equatable/equatable.dart';

import '../app_database.dart';
import 'tree_node.dart';

class SubjectWithChilds extends Equatable with TreeNode {
  @override
  final int id;

  @override
  final int? parentId;

  final String title;

  @override
  final List<SubjectWithChilds> childs;
  SubjectWithChilds({
    required this.id,
    this.parentId,
    required this.title,
    required this.childs,
  });

  factory SubjectWithChilds.fromSubject(Subject subject) {
    return SubjectWithChilds(
      id: subject.id,
      parentId: subject.parentId,
      title: subject.title,
      childs: [],
    );
  }

  @override
  List<Object?> get props => [id, parentId, title];
}
