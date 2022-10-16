//

import 'package:drift/drift.dart';
import 'package:my_budget/database/entities/entities_imports.dart';
import 'package:collection/collection.dart';
import 'package:my_budget/database/models/journal_entry.dart';

import '../../app_database.dart';

part 'debentures_dao.g.dart';

@DriftAccessor(tables: [Debentures, DebentureItems, Accounts])
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

  Future<List<DebentureItem>> getDebentureByDebit(
      {required int debitId}) async {
    final query = select(debentureItems)
      ..where((tbl) => tbl.debit.equals(debitId));

    final result = await query.get();
    return result;
  }

  Future addJournalEntry(JournalEntry entry) async {
    final debenture = DebenturesCompanion.insert(source: 1, sourceId: 1);
    final debentureId = await into(debentures).insert(debenture);

    const cashierId = 3;
    final related = entry.accountId;

    final debentureItem1 = DebentureItemsCompanion.insert(
      debentureId: debentureId,
      debit: cashierId,
      credit: related,
      date: entry.date,
      amount: entry.isIn ? entry.amount : -entry.amount,
    );

    final debentureItem2 = DebentureItemsCompanion.insert(
      debentureId: debentureId,
      debit: related,
      credit: cashierId,
      date: entry.date,
      amount: entry.isIn ? -entry.amount : entry.amount,
    );

    into(debentureItems).insert(debentureItem1);
    into(debentureItems).insert(debentureItem2);
  }

  //
  Stream<List<JournalEntry>> watchJournalForDate(DateTime date) {
    return (select(debentureItems)
          ..where((row) {
            return row.debit.equals(3) &
                row.date.year.equals(date.year) &
                row.date.month.equals(date.month) &
                row.date.day.equals(date.day);
          }))
        .join([
      leftOuterJoin(accounts, debentureItems.credit.equalsExp(accounts.id))
    ]).map((p0) {
      final debentureItem = p0.readTable(debentureItems);
      final credit = p0.readTable(accounts);
      final item = JournalEntry.fromDebentureItem(debentureItem);
      return item.copyWith(
        relatedAccount: credit.title,
      );
    }).watch();
  }

  Future<List<JournalEntry>> getStatmentForAccount(Account account) {
    return (select(debentureItems)
          ..where((row) {
            return row.debit.equals(account.id);
          }))
        .join([
      leftOuterJoin(accounts, debentureItems.credit.equalsExp(accounts.id))
    ]).map((p0) {
      final debentureItem = p0.readTable(debentureItems);
      final credit = p0.readTable(accounts);
      final item = JournalEntry.fromDebentureItem(debentureItem);
      return item.copyWith(
        relatedAccount: credit.title,
      );
    }).get();
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
