//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_budget/helpers/constants.dart';

import '../../database/models/journal_entry.dart';
import '../../styling/styling.dart';
import '../movement_indicator.dart';

class JournalEntryTile extends StatelessWidget {
  const JournalEntryTile({Key? key, this.entry}) : super(key: key);

  final JournalEntry? entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.journalRowHeight(context),
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
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        MovementIndicator(isIn: entry!.isIn),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('dd/MMM').format(entry!.date),
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
                Text(
                  entry!.notes ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Topology.darkMeduimBody,
                )
              ],
            ),
    );
  }
}

class NewJournalEntryTile extends StatelessWidget {
  const NewJournalEntryTile({
    Key? key,
    required this.entry,
  }) : super(key: key);
  final JournalEntry entry;
  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd-MMM');
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
                  MovementIndicator(isIn: entry.isIn),
                  const SizedBox(width: Constants.verticalGap),
                  Text(
                    '\$${entry.amount.abs()}',
                    style: Topology.darkMeduimBody.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              Text(formatter.format(entry.date)),
              Text(
                entry.relatedAccount,
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
