//

// ignore_for_file: depend_on_referenced_packages

import 'package:drift/drift.dart';
import 'package:my_budget/database/entities/entities_imports.dart';
import 'package:collection/collection.dart';
import 'package:my_budget/database/models/journal_entry.dart';

import '../../app_database.dart';

part 'debentures_dao.g.dart';

@DriftAccessor(tables: [Debentures, Accounts])
class DebenturesDao extends DatabaseAccessor<AppDatabase>
    with _$DebenturesDaoMixin {
  DebenturesDao(AppDatabase db) : super(db);

  Future insertDebenture(DebenturesCompanion model) async =>
      into(debentures).insert(model);

  Future deleteDebenture(DebenturesCompanion model) async =>
      delete(debentures).delete(model);

  Future updateDebenture(Debenture model) async =>
      update(debentures).replace(model);

  Future<Debenture?> getDebentureById({required int id}) async {
    final query = select(debentures)..where((tbl) => tbl.id.equals(id));

    final result = await query.get();
    return result.firstOrNull;
  }

  // Future<List<DebentureItem>> getDebentureByDebit(
  //     {required int debitId}) async {
  //   final query = select(debentureItems)
  //     ..where((tbl) => tbl.debit.equals(debitId));

  //   final result = await query.get();
  //   return result;
  // }

  Future addJournalEntry(JournalEntry entry) async {
    /*
    final debenture = DebenturesCompanion.insert(source: 1, sourceId: 1);
    final debentureId = await into(debentures).insert(debenture);

    const cashierId = 3;
    final related = entry.accountId;
    final cashierPart = TransactionsCompanion.insert(
      debentureId: debentureId,
      source: cashierId,
      related: related,
      date: entry.date,
      amount: entry.amount,
      notes: Value(entry.notes),
      isCredit: Value(entry.isIn),
    );

    final accountPart = TransactionsCompanion.insert(
      debentureId: debentureId,
      source: related,
      related: cashierId,
      date: entry.date,
      amount: entry.amount,
      notes: Value(entry.notes),
      isCredit: Value(!entry.isIn),
    );

    into(transactions).insert(cashierPart);
    into(transactions).insert(accountPart);
    */
  }

  /*
  Stream<List<JournalEntry>> watchOtherJournalForDate(DateTime date) {
    final otherAccounts = db.alias(db.accounts, 'other');
    return (select(transactions)
          ..where((row) {
            final cashier = row.source.equals(3);
            final rowDate = row.date;
            final sameYear = rowDate.year.equals(date.year);
            final sameMonth = rowDate.month.equals(date.month);
            final sameDay = rowDate.day.equals(date.day);
            return cashier & sameYear;
          }))
        .join([
      leftOuterJoin(accounts, transactions.related.equalsExp(accounts.id)),
      leftOuterJoin(
          otherAccounts, transactions.source.equalsExp(otherAccounts.id)),
    ]).map((p0) {
      final debentureItem = p0.readTable(transactions);
      final related = p0.readTable(accounts);
      final source = p0.readTable(otherAccounts);
      final label =
          (debentureItem.notes != null && debentureItem.notes?.length == 0)
              ? debentureItem.id.toString()
              : debentureItem.notes;
      print(' $label ${debentureItem.date}, $date');
      return JournalEntry.fromTransaction(
          item: debentureItem, source: source, related: related);
    }).watch();
    
  }

  Future<List<JournalEntry>> getOtherStatmentForAccountById(int accountId) {
    final otherAccounts = db.alias(db.accounts, 'other');
    return (select(transactions)
          ..where((row) {
            return row.source.equals(accountId);
          }))
        .join([
      leftOuterJoin(accounts, transactions.related.equalsExp(accounts.id)),
      leftOuterJoin(
          otherAccounts, transactions.source.equalsExp(otherAccounts.id)),
    ]).map((p0) {
      final debentureItem = p0.readTable(transactions);
      final related = p0.readTable(accounts);
      final source = p0.readTable(otherAccounts);
      return JournalEntry.fromTransaction(
          item: debentureItem,
          source: source,
          related: related,
          isStatment: true);
      // return item.copyWith(
      //   relatedAccount: credit.title,
      // );
    }).get();
  }
  */
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
