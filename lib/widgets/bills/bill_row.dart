//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../database/app_database.dart';
import '../popup_widget.dart';

class BillRow extends StatelessWidget {
  BillRow({
    Key? key,
    required this.bill,
    required this.index,
    required this.onTap,
  }) : super(key: key);
  final int index;
  final Bill bill;
  final Function onTap;
  final DateFormat dateFormatter = DateFormat('d - MMM');
  final NumberFormat numFormatter = NumberFormat('#,##0.##');
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () => onTap(),
        child: PopupWidget(
          child: Row(
            children: [
              SizedBox(
                width: 24,
                child: Text(
                  index.toString(),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 60,
                child: Text(
                  dateFormatter.format(bill.date),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 60,
                child: Text(
                  numFormatter.format(bill.total),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  bill.notes ?? '',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
