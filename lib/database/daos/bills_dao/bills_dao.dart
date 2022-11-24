//

import 'package:drift/drift.dart';
import 'package:my_budget/database/entities/entities_imports.dart';

import '../../../models/bill_item_model.dart';
import '../../app_database.dart';
import '../../models/bill_item_with_subject.dart';

part 'bills_dao.g.dart';

@DriftAccessor(tables: [Bills, BillItems, Subjects])
class BillsDao extends DatabaseAccessor<AppDatabase> with _$BillsDaoMixin {
  BillsDao(AppDatabase db) : super(db);

  Stream<List<Bill>> watchAllBills() {
    return (select(bills)).watch();
  }

  Future<List<BillItemWithSubject>> getBillItems(int billId) async {
    return await (select(billItems)
          ..where((tbl) => tbl.parentId.equals(billId)))
        .join([
      leftOuterJoin(subjects, billItems.subjectId.equalsExp(subjects.id)),
    ]).map((p0) {
      final item = p0.readTable(billItems);
      final subject = p0.readTable(subjects);
      return BillItemWithSubject(item: item, subject: subject);
    }).get();
  }

  Future<List<Bill>> getBillsForDate(DateTime targetDate) async {
    final something = (select(bills)
          ..where((row) {
            final endDate = row.date;
            final sameYear = endDate.year.equals(targetDate.year);
            final sameMonth = endDate.month.equals(targetDate.month);
            final sameDay = endDate.day.equals(targetDate.day);
            return sameYear & sameMonth & sameDay;
          }))
        .get();
    return something;
  }

  Future insertBill({
    required DateTime date,
    required String notes,
    required double totla,
    required List<BillItemModel> items,
  }) async {
    final billId = await into(bills).insert(
      BillsCompanion.insert(
        date: date,
        notes: Value(notes),
        total: totla,
      ),
    );

    for (final item in items) {
      into(billItems).insert(
        BillItemsCompanion.insert(
          parentId: Value(billId),
          subjectId: Value(item.subjectId),
          quantity: Value(item.quantity),
          price: item.price,
          notes: Value(item.notes),
        ),
      );
    }
  }
}
