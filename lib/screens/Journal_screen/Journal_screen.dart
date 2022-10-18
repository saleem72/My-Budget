// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/buget_database_cubit/budget_database_cubit.dart';

import 'package:my_budget/styling/styling.dart';
import 'package:my_budget/widgets/main_widgets_imports.dart';

import '../../database/app_database.dart';
import '../../helpers/localization/language_constants.dart';
import '../../database/models/journal_entry.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  DateTime _selectedDate = DateTime.now();
  // List<JournalEntry> entries = JournalEntry.dummyData;
  double listHeight = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translator.translation(context).journal),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _datePicker(context),
          Expanded(
            child: _movementsCardContent(context),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _datePicker(BuildContext context) {
    return AppTextFieldWithDate(
      label: '${Translator.translation(context).selected_date}: ',
      onChange: (date) {
        setState(() {
          _selectedDate = date;
        });
      },
    );
  }

  Widget _movementsCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: _movementsCardContent(context),
    );
  }

  Widget _movementsCardContent(BuildContext context) {
    return Column(
      children: [
        _movementsListTitle(context),
        _movmentsStream(context),
      ],
    );
  }

  Widget _movementsListTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 50),
        Text(
          Translator.translation(context).list_of_movement,
          style: Topology.title,
        ),
        _addMovementButton(),
      ],
    );
  }

  Widget _addMovementButton() {
    return IconButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () => _showAddDialog(context),
      icon: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(2, 2),
            )
          ],
        ),
        child: const Icon(
          Icons.add,
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _movmentsStream(BuildContext context) {
    final movmentsStream = context
        .read<BudgetDatabaseCubit>()
        .database
        .debenturesDao
        .watchJournalForDate(_selectedDate);
    return StreamBuilder(
        stream: movmentsStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          return _movmentsList(data);
        });
  }

  Widget _movmentsList(List<JournalEntry> entries) {
    return Expanded(
      child: entries.isEmpty
          ? _noMovments()
          : NewJournalList(
              data: entries,
            ),
    );
  }

  Widget _noMovments() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        Translator.translation(context).no_items,
        style: Topology.darkMeduimBody.copyWith(),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _oldMovmentsList(List<JournalEntry> entries) {
    return Expanded(
      child: WidgetSize(
        onChange: (newSize) {
          setState(() {
            listHeight = newSize.height;
          });
        },
        child: JournalList(
          data: entries,
          totalHeight: listHeight,
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) async {
    // final inputcontr accountId;
    bool isIn = false;
    final TextEditingController amountText = TextEditingController();
    double amount = 0;
    final database = context.read<BudgetDatabaseCubit>().database;
    final accounts = await database.accountsDao.getAllAccounts();

    Account? account = accounts.first;

    if (mounted) {}

    final saveButton = TextButton(
      onPressed: () {
        Navigator.pop(context, 'Save');
      },
      child: Text(
        Translator.translation(context).save,
        style: Topology.darkLargBody,
      ),
    );
    final cancelButton = TextButton(
      onPressed: () {
        Navigator.pop(context, 'Cancel');
      },
      child: Text(
        Translator.translation(context).cancel,
        style: Topology.darkLargBody,
      ),
    );

    final alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Text(
        Translator.translation(context).add_movment,
        style: Topology.title,
      ),
      content: StatefulBuilder(
        builder: (context, setState) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  Translator.translation(context).is_it_income,
                  style: Topology.darkLargBody,
                ),
                Switch(
                    value: isIn,
                    onChanged: ((value) {
                      setState(() {
                        isIn = value;
                      });
                    }))
              ],
            ),
            TextField(
              controller: amountText,
              keyboardType: TextInputType.number,
              style: Topology.darkLargBody,
              onChanged: (value) {
                final temp = double.tryParse(value);
                if (temp != null) {
                  amount = temp;
                } else {
                  amountText.text = amount.toString();
                }
              },
              decoration: InputDecoration(
                hintText: Translator.translation(context).amount,
                hintStyle: Topology.darkLargBody.copyWith(
                  color: Colors.grey,
                ),
                isCollapsed: true,
              ),
            ),
            const SizedBox(height: 16),
            InputDecorator(
              decoration: const InputDecoration(
                labelStyle: Topology.darkLargBody,
                isCollapsed: true,
                errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                hintText: 'Please select expense',
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(5.0),
                // ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Account>(
                  value: account,
                  isExpanded: true,
                  isDense: true,
                  style: Topology.darkLargBody,
                  items: accounts
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.title,
                              style: Topology.darkLargBody,
                            ),
                          ))
                      .toList(),
                  onChanged: (item) {
                    setState(() {
                      account = item; // InputDecoration
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        saveButton,
        cancelButton,
      ],
    );
    final result = await showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
    final action = result as String?;
    if (action == 'Save') {
      print('Amount: $amount, Account: ${account?.title ?? 'No Account set'}');
      final newEntry = JournalEntry(
        id: 99,
        isIn: isIn,
        date: _selectedDate,
        relatedAccount: account?.title ?? '',
        accountId: account?.id ?? 0,
        amount: amount,
      );
      database.debenturesDao.addJournalEntry(newEntry);
    }
  }
}

// const accounts = [
//   'المبيعات',
//   'المشتريات',
//   'ابو حسين',
//   'الراتب',
// ];
