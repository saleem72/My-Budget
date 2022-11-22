// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'journal_entry.dart';

class AccountSummary {
  final List<StatementEntry> statments;
  final double previousBalance;
  AccountSummary({
    required this.statments,
    required this.previousBalance,
  });
}
