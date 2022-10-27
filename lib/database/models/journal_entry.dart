// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:my_budget/database/entities/debentures.dart';

import '../app_database.dart';

class JournalEntry {
  final int id;
  final bool isIn;
  final DateTime date;
  final String relatedAccount;
  final int accountId;
  final double amount;
  final String? notes;

  JournalEntry({
    required this.id,
    this.isIn = false,
    required this.date,
    required this.relatedAccount,
    required this.amount,
    required this.accountId,
    this.notes,
  });

  factory JournalEntry.fromDebentureItem(DebentureItem item) {
    return JournalEntry(
      id: item.id,
      isIn: item.amount > 0,
      date: item.date,
      relatedAccount: '',
      amount: item.amount,
      accountId: item.credit,
      notes: item.notes,
    );
  }

  factory JournalEntry.fromTransaction({
    required Transaction item,
    required Account source,
    required Account related,
    bool isStatment = false,
  }) {
    return JournalEntry(
      id: item.id,
      isIn: isStatment
          ? source.isCredit
              ? !item.isCredit
              : item.isCredit
          : item.isCredit,
      date: item.date,
      relatedAccount: related.title,
      amount: item.amount,
      accountId: item.source,
      notes: 'Hello there', // item.notes,
    );
  }

  static JournalEntry example = JournalEntry(
    id: 1,
    date: DateTime.now().add(-const Duration(days: 5)),
    relatedAccount: 'Purchase',
    accountId: 1,
    amount: 32.15,
    notes: '',
  );

  static List<JournalEntry> dummyData = [
    JournalEntry(
      id: 1,
      date: DateTime.now().add(-const Duration(days: 5)),
      relatedAccount: 'Purchase',
      accountId: 1,
      amount: 32.15,
      notes: '',
    ),
    JournalEntry(
      id: 2,
      isIn: true,
      date: DateTime.now().add(-const Duration(days: 3)),
      relatedAccount: 'ابو غياث',
      accountId: 1,
      amount: 32.15,
      notes: '',
    ),
    JournalEntry(
      id: 3,
      date: DateTime.now().add(const Duration(days: 5)),
      relatedAccount: 'Bills',
      accountId: 1,
      amount: 32.15,
      notes: '',
    ),
    JournalEntry(
      id: 4,
      isIn: true,
      date: DateTime.now().add(const Duration(days: 3)),
      relatedAccount: 'Telephone',
      accountId: 1,
      amount: 32.15,
      notes: '',
    ),
    JournalEntry(
      id: 5,
      date: DateTime.now().add(-const Duration(days: 5)),
      relatedAccount: 'Electricity',
      accountId: 1,
      amount: 32.15,
      notes: '',
    ),
    JournalEntry(
      id: 6,
      isIn: true,
      date: DateTime.now().add(-const Duration(days: 5)),
      relatedAccount: 'Food',
      accountId: 1,
      amount: 32.15,
      notes: '',
    ),
  ];

  JournalEntry copyWith({
    int? id,
    bool? isIn,
    DateTime? date,
    String? relatedAccount,
    int? accountId,
    double? amount,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      isIn: isIn ?? this.isIn,
      date: date ?? this.date,
      relatedAccount: relatedAccount ?? this.relatedAccount,
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      notes: '',
    );
  }
}
