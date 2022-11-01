//

import 'package:drift/drift.dart';
import 'package:my_budget/database/entities/entities_imports.dart';
import 'package:my_budget/database/models/object_label.dart';

import '../../app_database.dart';
import '../../models/bill_item_with_subject.dart';

part 'bills_dao.g.dart';

@DriftAccessor(tables: [Bills, BillItems, Subjects])
class BillsDao extends DatabaseAccessor<AppDatabase> with _$BillsDaoMixin {
  BillsDao(AppDatabase db) : super(db);

  Stream<List<ObjectTitle>> watchAllBills() => select(bills)
      .map((p0) => ObjectTitle(id: p0.id, title: p0.id.toString()))
      .watch();

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
}
