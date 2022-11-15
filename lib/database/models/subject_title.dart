//

import 'object_label.dart';

class SubjectTitle extends ObjectTitle {
  @override
  final int id;
  @override
  final String title;
  SubjectTitle({
    required this.id,
    required this.title,
  });

  @override
  String toString() => 'ObjectTitle(id: $id, title: $title)';
}
