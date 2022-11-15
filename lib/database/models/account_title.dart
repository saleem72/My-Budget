//

import 'object_label.dart';

class AccountTitle extends ObjectTitle {
  @override
  final int id;
  @override
  final String title;
  final bool isCredit;
  AccountTitle({
    required this.id,
    required this.title,
    required this.isCredit,
  });

  @override
  String toString() =>
      'AccountTitle(id: $id, title: $title, isCredit: $isCredit)';
}
