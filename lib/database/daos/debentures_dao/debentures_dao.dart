//

// ignore_for_file: depend_on_referenced_packages

import 'package:drift/drift.dart';
import 'package:my_budget/database/entities/entities_imports.dart';
import 'package:collection/collection.dart';
import 'package:my_budget/database/models/account_summary.dart';
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

  Future addBillEntries(JournalEntry entry) async {
    final debenture = DebenturesCompanion.insert(source: 1, sourceId: 1);
    final debentureId = await into(debentures).insert(debenture);

    final cashierPart = DebentureItemsCompanion.insert(
      debentureId: debentureId,
      account: 3,
      date: entry.date,
      debit: entry.isCredit ? Value(entry.amount) : const Value(null),
      credit: entry.isCredit ? const Value(null) : Value(entry.amount),
      notes: Value(entry.notes),
      releatedAccount: entry.releatedAccountId,
    );

    final accountPart = DebentureItemsCompanion.insert(
      debentureId: debentureId,
      account: entry.releatedAccountId,
      date: entry.date,
      credit: entry.isCredit ? Value(entry.amount) : const Value(null),
      debit: entry.isCredit ? const Value(null) : Value(entry.amount),
      notes: Value(entry.notes),
      releatedAccount: entry.releatedAccountId,
    );

    into(debentureItems).insert(cashierPart);
    into(debentureItems).insert(accountPart);
  }

  AccountSummary _filterStatments(
      bool isCredit, List<StatementEntry> list, DateTime startDate) {
    final balanceList =
        list.where((element) => element.date.compareTo(startDate) < 0).toList();
    final double inCome = balanceList.fold(
        0, (previousValue, element) => previousValue + (element.credit ?? 0));
    final double outCome = balanceList.fold(
        0, (previousValue, element) => previousValue + (element.debit ?? 0));
    final double balance = isCredit ? inCome - outCome : outCome - inCome;
    final fliteredList = list
        .where((element) => element.date.compareTo(startDate) >= 0)
        .toList();

    fliteredList.sort(((a, b) => a.date.compareTo(b.date)));
    return AccountSummary(statments: fliteredList, previousBalance: balance);
  }

  Future<AccountSummary> getStatmentForAccountById(
    int accountId,
    DateTime startDate,
  ) async {
    final otherAccounts = db.alias(db.accounts, 'other');

    final account = (await (select(accounts)
              ..where((tbl) => tbl.id.equals(accountId)))
            .get())
        .first;

    final list = await (select(debentureItems)
          ..where((row) {
            return row.account.equals(accountId);
          }))
        .join([
      leftOuterJoin(
          accounts, debentureItems.releatedAccount.equalsExp(accounts.id)),
      leftOuterJoin(
          otherAccounts, debentureItems.account.equalsExp(otherAccounts.id)),
    ]).map((p0) {
      final debentureItem = p0.readTable(debentureItems);
      final related = p0.readTable(accounts);
      final source = p0.readTable(otherAccounts);
      return StatementEntry(
        id: debentureItem.id,
        debentureId: debentureItem.debentureId,
        accountId: source.id,
        account: source.title,
        releatedAccountId: related.id,
        releatedAccount: related.title,
        date: debentureItem.date,
        credit: debentureItem.credit,
        debit: debentureItem.debit,
        notes: debentureItem.notes,
      );
      // return item.copyWith(
      //   relatedAccount: credit.title,
      // );
    }).get();
    return _filterStatments(account.isCredit, list, startDate);
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
