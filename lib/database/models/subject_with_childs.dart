// ignore_for_file: public_member_api_docs, sort_constructors_first
//
//

import 'dart:convert';

import 'package:my_budget/database/models/tree_node.dart';

import '../app_database.dart';

class SubjectWithChilds extends TreeNode {
  @override
  final int id;
  @override
  final int? parentId;
  @override
  final String title;
  @override
  bool isExpanded;
  @override
  List<SubjectWithChilds> childs;
  SubjectWithChilds({
    required this.id,
    this.parentId,
    required this.title,
    required this.childs,
    this.isExpanded = false,
  });

  factory SubjectWithChilds.fromSubject(Subject subject, bool isExpanded) {
    return SubjectWithChilds(
      id: subject.id,
      parentId: subject.parentId,
      title: subject.title,
      isExpanded: isExpanded,
      childs: [],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'parentId': parentId,
      'title': title,
      'childs': childs.map((x) => x.toMap()).toList(),
    };
  }

  factory SubjectWithChilds.fromMap(Map<String, dynamic> map) {
    return SubjectWithChilds(
      id: map['id'] as int,
      parentId: map['parentId'] != null ? map['parentId'] as int : null,
      title: map['title'] as String,
      childs: List<SubjectWithChilds>.from(
        (map['childs'] as List<int>).map<SubjectWithChilds>(
          (x) => SubjectWithChilds.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectWithChilds.fromJson(String source) =>
      SubjectWithChilds.fromMap(json.decode(source) as Map<String, dynamic>);

  SubjectWithChilds copyWith({
    int? id,
    int? parentId,
    bool? isExpanded,
    String? title,
    List<SubjectWithChilds>? childs,
  }) {
    return SubjectWithChilds(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      title: title ?? this.title,
      childs: childs ?? this.childs,
    );
  }

  @override
  List<Object?> get props => [id];
}
