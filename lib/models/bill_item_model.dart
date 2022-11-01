// ignore_for_file: public_member_api_docs, sort_constructors_first
//

class BillItemModel {
  final int subjectId;
  final String subject;
  final int quantity;
  final double price;
  final String? notes;

  double get total => quantity * price;

  BillItemModel({
    required this.subjectId,
    required this.subject,
    required this.quantity,
    required this.price,
    this.notes,
  });
}
