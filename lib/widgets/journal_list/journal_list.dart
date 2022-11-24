//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../database/models/journal_entry.dart';
import '../../helpers/localization/language_constants.dart';
import '../../styling/styling.dart';
import 'expense_tile.dart';

class JournalList extends StatelessWidget {
  const JournalList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<JournalEntry> data;

  @override
  Widget build(BuildContext context) {
    final income = data.where((element) => element.isCredit).fold<double>(
        0, (previousValue, element) => previousValue + element.amount);
    final outcome = data.where((element) => !element.isCredit).fold<double>(
        0, (previousValue, element) => previousValue + element.amount);
    final double balance = income - outcome;
    final formatter = NumberFormat('#,##0.##');
    return Column(
      children: [
        Expanded(child: _buildList(context)),
        Container(
          height: 44,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(),
            ),
          ),
          child: Row(
            children: [
              Text(
                '${Translator.translation(context).balance}: ',
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                constraints: const BoxConstraints(
                  minWidth: 50,
                ),
                child: Text(
                  formatter.format(income),
                  style: Topology.darkMeduimBody.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                constraints: const BoxConstraints(
                  minWidth: 50,
                ),
                child: Text(
                  formatter.format(outcome),
                  style: Topology.darkMeduimBody.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    formatter.format(balance),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    style: Topology.darkMeduimBody.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero, // const EdgeInsets.only(left: 16, right: 16),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return ExpenseTile(item: item);
        });
  }
}
