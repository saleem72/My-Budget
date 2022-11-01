//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../helpers/constants.dart';
import '../../helpers/localization/language_constants.dart';
import '../../models/bill_item_model.dart';
import '../../styling/styling.dart';
import 'bill_item_row.dart';
import 'bill_table_header.dart';

class BillTable extends StatelessWidget {
  const BillTable({
    Key? key,
    required this.items,
  }) : super(key: key);
  final List<BillItemModel> items;

  double get billTotal =>
      items.fold(0, (previousValue, element) => previousValue + element.total);
  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat("#,##0.##");
    return Column(
      children: [
        const BillTableHeader(),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return BillItemRow(item: items[index]);
            },
          ),
        ),
        Container(
          height: Constants.billRowHeight(context, Topology.darkMeduimBody),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.blue),
            ),
          ),
          child: Row(
            children: [
              Text(
                '${Translator.translation(context).total}: ',
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                formatter.format(billTotal),
                style: Topology.darkMeduimBody,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
