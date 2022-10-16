//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../database/models/journal_entry.dart';
import '../../styling/styling.dart';

class JournalEntryTile extends StatelessWidget {
  const JournalEntryTile({Key? key, this.entry}) : super(key: key);

  final JournalEntry? entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: entry == null
          ? const SizedBox.shrink()
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      entry!.isIn ? Assests.journalIn : Assests.journalOut,
                      width: 18,
                      height: 13,
                      color: entry!.isIn ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('dd/MM/yyyy').format(entry!.date),
                      style: Topology.darkMeduimBody,
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Text(
                  entry!.relatedAccount,
                  style: Topology.darkMeduimBody,
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 75,
                  child: Text(
                    '\$${entry!.amount.abs()}',
                    style: Topology.darkMeduimBody,
                  ),
                ),
              ],
            ),
    );
  }
}
