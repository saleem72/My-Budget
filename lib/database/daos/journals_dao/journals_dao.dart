//

import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../entities/entities_imports.dart';
import '../../models/journal_entry.dart';

part 'journals_dao.g.dart';

@DriftAccessor(tables: [Journals, Accounts, Debentures, DebentureItems])
class JournalsDao extends DatabaseAccessor<AppDatabase>
    with _$JournalsDaoMixin {
  JournalsDao(AppDatabase db) : super(db);

  Future addJournalEntry(JournalEntry model) async {
    // create debenture
    final debenture = DebenturesCompanion.insert(source: 1, sourceId: 0);
    final debentureId = await into(debentures).insert(debenture);

    // create debenture items
    /// create cashier part
    into(debentureItems).insert(DebentureItemsCompanion.insert(
      debentureId: debentureId,
      account: 3,
      date: model.date,
      debit: model.isCredit ? Value(model.amount) : const Value(null),
      credit: model.isCredit ? const Value(null) : Value(model.amount),
      notes: Value(model.notes),
      releatedAccount: model.releatedAccountId,
    ));

    /// create related part
    into(debentureItems).insert(DebentureItemsCompanion.insert(
      debentureId: debentureId,
      account: model.releatedAccountId,
      date: model.date,
      credit: model.isCredit ? Value(model.amount) : const Value(null),
      debit: model.isCredit ? const Value(null) : Value(model.amount),
      notes: Value(model.notes),
      releatedAccount: 3,
    ));

    final journalId = await into(journals).insert(JournalsCompanion.insert(
      date: model.date,
      debentureId: debentureId,
      related: model.releatedAccountId,
      isCredit: model.isCredit,
      amount: model.amount,
      notes: Value(model.notes),
    ));

    // we need to update source id after we create the journal
    final updatedDebenture = debenture.copyWith(
      id: Value(debentureId),
      sourceId: Value(journalId),
    );
    update(debentures).replace(updatedDebenture);
  }

  Future editJournalEntry(JournalEntry model) async {
    // delete old debentureItems

    final items = await (select(debentureItems)
          ..where((tbl) => tbl.debentureId.equals(model.debentureId)))
        .get();

    for (final item in items) {
      delete(debentureItems).delete(item);
    }

    // create debenture items
    /// create cashier part
    into(debentureItems).insert(DebentureItemsCompanion.insert(
      debentureId: model.debentureId,
      account: 3,
      date: model.date,
      debit: model.isCredit ? Value(model.amount) : const Value(null),
      credit: model.isCredit ? const Value(null) : Value(model.amount),
      notes: Value(model.notes),
      releatedAccount: model.releatedAccountId,
    ));

    /// create related part
    into(debentureItems).insert(DebentureItemsCompanion.insert(
      debentureId: model.debentureId,
      account: model.releatedAccountId,
      date: model.date,
      credit: model.isCredit ? Value(model.amount) : const Value(null),
      debit: model.isCredit ? const Value(null) : Value(model.amount),
      notes: Value(model.notes),
      releatedAccount: model.releatedAccountId,
    ));

    final oldJournal = (await (select(journals)
              ..where((tbl) => tbl.id.equals(model.id)))
            .get())
        .first;

    final newJournal = oldJournal.copyWith(
      amount: model.amount,
      related: model.releatedAccountId,
      notes: Value(model.notes ?? ''),
      isCredit: model.isCredit,
    );
    update(journals).replace(newJournal);
  }

  Stream<List<JournalEntry>> watchJournalForDate(DateTime date) {
    return (select(journals)
          ..where((row) {
            final rowDate = row.date;
            final sameYear = rowDate.year.equals(date.year);
            final sameMonth = rowDate.month.equals(date.month);
            final sameDay = rowDate.day.equals(date.day);
            return sameYear & sameMonth & sameDay;
          }))
        .join([
      leftOuterJoin(accounts, journals.related.equalsExp(accounts.id)),
    ]).map((p0) {
      final journal = p0.readTable(journals);
      final related = p0.readTable(accounts);

      return JournalEntry(
        id: journal.id,
        date: journal.date,
        debentureId: journal.debentureId,
        releatedAccountId: related.id,
        releatedAccount: related.title,
        isCredit: journal.isCredit,
        amount: journal.amount,
        notes: journal.notes,
      );
    }).watch();
  }

  Future<List<JournalEntry>> getJournalForDate(DateTime date) {
    print('getJournalForDate date: $date');
    return (select(journals)
          ..where((row) {
            final rowDate = row.date;
            final sameYear = rowDate.year.equals(date.year);
            final sameMonth = rowDate.month.equals(date.month);
            final sameDay = rowDate.day.equals(date.day);
            return sameYear & sameMonth & sameDay;
          }))
        .join([
      leftOuterJoin(accounts, journals.related.equalsExp(accounts.id)),
    ]).map((p0) {
      final journal = p0.readTable(journals);
      final related = p0.readTable(accounts);

      return JournalEntry(
        id: journal.id,
        date: journal.date,
        debentureId: journal.debentureId,
        releatedAccountId: related.id,
        releatedAccount: related.title,
        isCredit: journal.isCredit,
        amount: journal.amount,
        notes: journal.notes,
      );
    }).get();
  }

  Future deleteJournalEntry(JournalEntry entry) async {
    // delete journal
    final journalToDelete = (await (select(journals)
              ..where((tbl) => tbl.id.equals(entry.id)))
            .get())
        .first;
    delete(journals).delete(journalToDelete);

    // delete main debenture
    final debenture = (await (select(debentures)
              ..where((tbl) => tbl.id.equals(entry.debentureId)))
            .get())
        .first;
    delete(debentures).delete(debenture);
  }

  Future<int> debentureItemsCount() async {
    return (await select(debentureItems).get()).length;
  }
}
