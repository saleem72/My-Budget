//

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_budget/database/buget_database_cubit/budget_database_cubit.dart';
import 'package:my_budget/dialogs/add_journal_dialog.dart';
import 'package:my_budget/helpers/extensions/string_extension.dart';
import 'package:my_budget/helpers/localization/locale_cubit/locale_cubit.dart';
import 'package:my_budget/widgets/toolbar_button.dart';

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
    final locale = context.read<LocaleCubit>().state;
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
                  flex: 1,
                  onPressed: (context) {
                    _deleteEntry(context);
                  },
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  borderRadius: BorderRadius.only(
                    topRight: locale.languageCode == 'ar'
                        ? Radius.zero
                        : const Radius.circular(12),
                    bottomRight: locale.languageCode == 'ar'
                        ? Radius.zero
                        : const Radius.circular(12),
                    topLeft: locale.languageCode == 'ar'
                        ? const Radius.circular(12)
                        : Radius.zero,
                    bottomLeft: locale.languageCode == 'ar'
                        ? const Radius.circular(12)
                        : Radius.zero,
                  ),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  onPressed: (context) => _editEntry(context),
                  icon: Icons.edit,
                  label: 'Edit',
                ),
              ],
            ),
            child: JournalEntryTile(entry: item),
          ),
        ],
      ),
    );
  }

  _deleteEntry(BuildContext context) {
    debugPrint('Item will be deleted! ${item.amount}');
    final database = context.read<BudgetDatabaseCubit>().database;

    database.journalsDao.deleteJournalEntry(item);
  }

  _editEntry(BuildContext context) async {
    debugPrint('Item will be Edit! ${item.amount}');
    final database = context.read<BudgetDatabaseCubit>().database;
    final accounts = await database.accountsDao.accountsTitles();

    final result = await showDialog(
        context: context,
        builder: (context) {
          final alert =
              addJournalAlert(context, accounts: accounts, entry: item);
          return alert;
        });
    final json = result as Map<String, dynamic>?;

    if (json != null) {
      final amountString = json['amount'] as String;
      final accountId = json['account'] as int;
      final isCredit = json['isCredit'] as bool? ?? false;
      final notes = json['notes'] as String;
      final amount = double.parse(amountString.replaceArabicNumber());

      debugPrint(
          'Amount: $amount, Account: $accountId, notes: $notes isCredit: $isCredit');

      final newEntry = item.copyWith(
        releatedAccountId: accountId,
        isCredit: isCredit,
        amount: amount,
        notes: notes,
      );

      database.journalsDao.editJournalEntry(newEntry);
    }
  }
}
