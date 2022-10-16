//

import 'package:flutter/material.dart';
import 'package:my_budget/helpers/localization/language_constants.dart';
import 'package:my_budget/styling/topology.dart';

import '../../database/models/journal_entry.dart';
import 'journal_entry_tile.dart';

class JournalList extends StatelessWidget {
  const JournalList({
    Key? key,
    required this.data,
    required this.totalHeight,
  }) : super(key: key);

  final List<JournalEntry> data;
  final double totalHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildList(context)),
        Container(
          height: 44,
          alignment: Alignment.center,
          child: Row(
            children: [
              Text(
                '${Translator.translation(context).balance}: ',
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return totalHeight == 0
        ? ListView.builder(
            padding:
                EdgeInsets.zero, // const EdgeInsets.only(left: 16, right: 16),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return JournalEntryTile(entry: data[index]);
            })
        : ListView.builder(
            padding:
                EdgeInsets.zero, // const EdgeInsets.only(left: 16, right: 16),
            itemCount: (totalHeight - 44) ~/ 30, // widget.data.length,
            itemBuilder: (context, index) {
              return JournalEntryTile(
                  entry: index < data.length ? data[index] : null);
            });
  }
}
