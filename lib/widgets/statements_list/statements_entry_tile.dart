//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_budget/helpers/constants.dart';

import '../../database/models/journal_entry.dart';
import '../../styling/styling.dart';
import '../movement_indicator.dart';

class StatementEntryTile extends StatelessWidget {
  const StatementEntryTile({
    Key? key,
    required this.entry,
    required this.isAccountCredit,
  }) : super(key: key);

  final StatementEntry? entry;
  final bool isAccountCredit;

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat("#,##0.##", "en_US");
    return Container(
      height: Constants.journalRowHeight(context),
      padding: const EdgeInsets.only(top: 8),
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        MovementIndicator(
                            isIn: isAccountCredit
                                ? entry!.credit != null
                                : entry!.debit != null),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('dd/MMM').format(entry!.date),
                          style: Topology.darkMeduimBody,
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      entry!.releatedAccount,
                      style: Topology.darkMeduimBody,
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 75,
                      child: Text(
                        '\$${numberFormat.format(entry!.amount)}', // entry!.amount.abs()
                        style: Topology.darkMeduimBody.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ], // الرا
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
