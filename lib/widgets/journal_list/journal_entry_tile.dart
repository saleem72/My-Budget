//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../database/models/journal_entry.dart';
import '../../helpers/constants.dart';
import '../../styling/topology.dart';
import '../movement_indicator.dart';

class JournalEntryTile extends StatelessWidget {
  const JournalEntryTile({
    Key? key,
    required this.entry,
  }) : super(key: key);
  final JournalEntry entry;
  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd-MMM');
    NumberFormat numberFormat = NumberFormat("#,##0.##", "en_US");
    return Container(
      height: Constants.journalRowHeight(context),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MovementIndicator(isIn: entry.isCredit),
                  const SizedBox(width: Constants.verticalGap),
                  Text(
                    '\$${numberFormat.format(entry.amount.abs())}',
                    style: Topology.darkMeduimBody.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              Text(formatter.format(entry.date)),
              Text(
                entry.releatedAccount,
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          entry.notes != null
              ? const SizedBox(height: 8)
              : const SizedBox.shrink(),
          entry.notes != null
              ? Row(
                  children: [
                    Text(
                      entry.notes ?? '',
                      style: Topology.darkMeduimBody,
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
