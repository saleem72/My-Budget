//

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
    final double balance = data.fold(
        0, (previousValue, element) => previousValue + element.amount);
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

class NewJournalList extends StatelessWidget {
  const NewJournalList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<JournalEntry> data;

  @override
  Widget build(BuildContext context) {
    final double balance = data.fold(
        0, (previousValue, element) => previousValue + element.amount);
    return Column(
      children: [
        Expanded(child: _buildList(context)),
        Container(
          height: 44,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
          return Container(
            height: 64,
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
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
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
        });
  }
}
