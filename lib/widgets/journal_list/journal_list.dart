//

import 'package:flutter/material.dart';

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
    final double balance = data.fold(
        0,
        (previousValue, element) =>
            previousValue +
            (element.isCredit ? element.amount : -element.amount));
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
              Text(
                '\$$balance',
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              )
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
