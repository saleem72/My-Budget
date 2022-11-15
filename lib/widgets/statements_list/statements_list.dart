//

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:my_budget/helpers/localization/language_constants.dart';
import 'package:my_budget/styling/topology.dart';

import '../../database/models/journal_entry.dart';
import '../../helpers/constants.dart';
import 'statements_entry_tile.dart';

class StatementsList extends StatefulWidget {
  const StatementsList({
    Key? key,
    required this.data,
    required this.totalHeight,
    required this.isAccountCredit,
  }) : super(key: key);

  final List<StatementEntry> data;
  final double totalHeight;
  final bool isAccountCredit;

  @override
  State<StatementsList> createState() => _StatementsListState();
}

class _StatementsListState extends State<StatementsList> {
  @override
  void didUpdateWidget(StatementsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  String formattedString(double num) {
    NumberFormat numberFormat = NumberFormat("#,##0.##", "en_US");

    return numberFormat.format(num);
  }

  @override
  Widget build(BuildContext context) {
    final double inCome = widget.data.fold(
        0, (previousValue, element) => previousValue + (element.credit ?? 0));
    final double outCome = widget.data.fold(
        0, (previousValue, element) => previousValue + (element.debit ?? 0));
    final double balance =
        widget.isAccountCredit ? inCome - outCome : outCome - inCome;
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
              return StatementEntryTile(
                entry: widget.data[index],
                isAccountCredit: widget.isAccountCredit,
              );
            })
        : ListView.builder(
            padding:
                EdgeInsets.zero, // const EdgeInsets.only(left: 16, right: 16),
            itemCount: (widget.totalHeight - 44) ~/ 30, // widget.data.length,
            itemBuilder: (context, index) {
              return StatementEntryTile(
                entry: index < widget.data.length ? widget.data[index] : null,
                isAccountCredit: widget.isAccountCredit,
              );
            });
  }
}
