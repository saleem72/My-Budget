//

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../database/models/journal_entry.dart';
import '../../helpers/constants.dart';
import 'journal_entry_tile.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final JournalEntry item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.journalRowHeight(context),
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Slidable(
            key: ValueKey(item),
            endActionPane: ActionPane(
              extentRatio: 0.3,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.only(
                    topRight: Platform.localeName == 'ar'
                        ? Radius.zero
                        : const Radius.circular(12),
                    bottomRight: Platform.localeName == 'ar'
                        ? Radius.zero
                        : const Radius.circular(12),
                    topLeft: Platform.localeName == 'ar'
                        ? Radius.zero
                        : const Radius.circular(12),
                    bottomLeft: Platform.localeName == 'ar'
                        ? Radius.zero
                        : const Radius.circular(12),
                  ),
                  flex: 1,
                  onPressed: (context) {
                    debugPrint('Item will be deleted!');
                  },
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: JournalEntryTile(entry: item),
          ),
        ],
      ),
    );
  }
}
