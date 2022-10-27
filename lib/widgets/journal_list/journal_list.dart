//

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:my_budget/helpers/localization/language_constants.dart';
import 'package:my_budget/styling/topology.dart';

import '../../database/models/journal_entry.dart';
import '../../helpers/constants.dart';
import 'journal_entry_tile.dart';

class JournalList extends StatefulWidget {
  const JournalList({
    Key? key,
    required this.data,
    required this.totalHeight,
  }) : super(key: key);

  final List<JournalEntry> data;
  final double totalHeight;

  @override
  State<JournalList> createState() => _JournalListState();
}

class _JournalListState extends State<JournalList> {
  @override
  void didUpdateWidget(JournalList oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  String formattedString(double num) {
    NumberFormat numberFormat = NumberFormat("#,##0.##", "en_US");

    return numberFormat.format(num);
  }

  @override
  Widget build(BuildContext context) {
    final double balance = widget.data.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.isIn ? element.amount : -element.amount));
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
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '\$${formattedString(balance)}',
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
    return widget.totalHeight == 0
        ? ListView.builder(
            padding:
                EdgeInsets.zero, // const EdgeInsets.only(left: 16, right: 16),
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              return JournalEntryTile(entry: widget.data[index]);
            })
        : ListView.builder(
            padding:
                EdgeInsets.zero, // const EdgeInsets.only(left: 16, right: 16),
            itemCount: (widget.totalHeight - 44) ~/ 30, // widget.data.length,
            itemBuilder: (context, index) {
              return JournalEntryTile(
                  entry:
                      index < widget.data.length ? widget.data[index] : null);
            });
  }
}

class NewJournalList extends StatelessWidget {
  const NewJournalList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<JournalEntry> data;

  @override
  Widget build(BuildContext context) {
    final double balance = data.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.isIn ? element.amount : -element.amount));
    return Column(
      children: [
        Expanded(child: _buildList(context)),
        Container(
          height: 44,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(),
            ),
          ),
          child: Row(
            children: [
              Text(
                '${Translator.translation(context).balance}: ',
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '\$$balance',
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w900,
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

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final JournalEntry item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.journalRowHeight,
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
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
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
            child: NewJournalEntryTile(entry: item),
          ),
        ],
      ),
    );
  }
}
