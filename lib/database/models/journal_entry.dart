// ignore_for_file: public_member_api_docs, sort_constructors_first
//

class JournalEntry {
  final int id;
  final DateTime date;
  final int debentureId;
  final int releatedAccountId;
  final String releatedAccount;
  final bool isCredit;
  final String? notes;
  final double amount;
  JournalEntry({
    required this.id,
    required this.date,
    required this.debentureId,
    required this.releatedAccountId,
    required this.releatedAccount,
    required this.isCredit,
    this.notes,
    required this.amount,
  });

  @override
  String toString() {
    return 'JournalEntry(id: $id, releatedAccount: $releatedAccount, isIncome: $isCredit)';
  }

  JournalEntry copyWith({
    int? id,
    DateTime? date,
    int? debentureId,
    int? releatedAccountId,
    String? releatedAccount,
    bool? isCredit,
    String? notes,
    double? amount,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      date: date ?? this.date,
      debentureId: debentureId ?? this.debentureId,
      releatedAccountId: releatedAccountId ?? this.releatedAccountId,
      releatedAccount: releatedAccount ?? this.releatedAccount,
      isCredit: isCredit ?? this.isCredit,
      notes: notes ?? this.notes,
      amount: amount ?? this.amount,
    );
  }
}

class StatementEntry {
  final int id;
  final int debentureId;
  final int accountId;
  final String account;
  final int releatedAccountId;
  final String releatedAccount;
  final DateTime date;
  final double? debit;
  final double? credit;
  final String? notes;

  double get amount => credit ?? debit ?? 0;

  StatementEntry({
    required this.id,
    required this.debentureId,
    required this.accountId,
    required this.account,
    required this.releatedAccountId,
    required this.releatedAccount,
    required this.date,
    this.debit,
    this.credit,
    this.notes,
  });

  StatementEntry copyWith({
    int? id,
    int? debentureId,
    int? accountId,
    String? account,
    int? releatedAccountId,
    String? releatedAccount,
    DateTime? date,
    double? debit,
    double? credit,
    String? notes,
  }) {
    return StatementEntry(
      id: id ?? this.id,
      debentureId: debentureId ?? this.debentureId,
      accountId: accountId ?? this.accountId,
      account: account ?? this.account,
      releatedAccountId: releatedAccountId ?? this.releatedAccountId,
      releatedAccount: releatedAccount ?? this.releatedAccount,
      date: date ?? this.date,
      debit: debit ?? this.debit,
      credit: credit ?? this.credit,
      notes: notes ?? this.notes,
    );
  }

  @override
  String toString() {
    return 'StatementEntry(account: $account, releatedAccount: $releatedAccount, debit: $debit, credit: $credit)';
  }
}
