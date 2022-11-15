// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/buget_database_cubit/budget_database_cubit.dart';

import 'package:my_budget/styling/styling.dart';
import 'package:my_budget/widgets/main_widgets_imports.dart';

import '../../database/app_database.dart';
import '../../database/models/object_label.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          // _datePicker(context),
          _buildSearchBar(context),
          const SizedBox(height: 16),
          Expanded(
            child: _movmentsStream(context),
          ),
        ],
      ),
    );
  }

  void updateSelectedDate(DateTime date) {
    final newDate = date.add(date.timeZoneOffset);
    flipTheDate(date);
    setState(() {
      _selectedDate = newDate;
      // _selectedDate = date.add(const Duration(
      //     milliseconds:
      //         (17 * 60 * 60 * 1000) + (59 * 60 * 1000) + (38 * 1000) + 250));
    });
  }

  void flipTheDate(DateTime date) {
    Duration offset = date.timeZoneOffset;
    date.add(offset);

    // ----------
    String dateTime = date.toIso8601String();
    // - or -
    // String dateTime = intl.DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(now);
    // ----------
    String utcHourOffset = (offset.isNegative ? '-' : '+') +
        offset.inHours.abs().toString().padLeft(2, '0');
    String utcMinuteOffset =
        (offset.inMinutes - offset.inHours * 60).toString().padLeft(2, '0');

    String dateTimeWithOffset = '$dateTime$utcHourOffset:$utcMinuteOffset';
    print('flipTheDate: $dateTimeWithOffset');
  }

  Widget _buildSearchBar(BuildContext context) {
    return PopupWidget(
      borderWidth: 0.5,
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              child: SizedBox(
                height: 14,
                width: 14,
                child: Image.asset(
                  Assests.calendar,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: AnotherDatePicker(
              label: 'Select date',
              onChange: (date) {
                updateSelectedDate(date);
              },
            ),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: () {},
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              child: SizedBox(
                height: 14,
                width: 14,
                child: Image.asset(Assests.filter),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _movementsListTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Translator.translation(context).list_of_movement,
            style: Topology.darkLargBody.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          _addMovementButton(),
        ],
      ),
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
        .journalsDao
        .watchJournalForDate(_selectedDate); //(_selectedDate);
    return StreamBuilder(
        stream: movmentsStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          return _buildMovementsList(data);
        });
  }

  Widget _buildMovementsList(List<JournalEntry> entries) {
    return PopupWidget(
      borderColor: Colors.black,
      borderWidth: 0.5,
      child: Column(
        children: [
          _movementsListTitle(context),
          Expanded(
            child: WidgetSize(
              onChange: (newSize) {
                setState(() {
                  listHeight = newSize.height;
                });
              },
              child: JournalList(
                data: entries,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) async {
    final database = context.read<BudgetDatabaseCubit>().database;
    final accounts = await database.accountsDao.accountsTitles();

    if (mounted) {}

    final alert = _addEntryAlert(context, accounts);
    final result = await showDialog(
        context: context,
        builder: (context) {
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

      final newEntry = JournalEntry(
        id: 0,
        date: _selectedDate,
        debentureId: 0,
        releatedAccountId: accountId,
        releatedAccount: '',
        isCredit: isCredit,
        amount: amount,
        notes: notes,
      );

      database.journalsDao.addJournalEntry(newEntry);
    }
  }

  Widget _addEntryAlert(BuildContext context, List<ObjectTitle> entries) {
    final TextEditingController amountText = TextEditingController();
    final TextEditingController notes = TextEditingController();
    bool isCredit = false;
    ObjectTitle? account;
    return AlertDialog(
      contentPadding:
          const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      content: StatefulBuilder(
        builder: (context, setState) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Translator.translation(context).add_movment,
                    style: Topology.darkMeduimBody.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              VerticalTextField(
                radius: 8,
                controller: amountText,
                keyboard: TextInputType.number,
                label: Translator.translation(context).amount,
                hint: Translator.translation(context).amount,
              ),
              const SizedBox(height: 16),
              PopupWidget(
                radius: 8,
                child: AppAutoComplete(
                  objectsList: entries,
                  hint: Translator.translation(context).select_account_hint,
                  onSelected: (p0) {
                    setState(() {
                      account = p0;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              PopupWidget(
                child: TextField(
                  controller: notes,
                  style: Topology.darkLargBody,
                  decoration: InputDecoration(
                    hintText: Translator.translation(context).notes,
                    border: InputBorder.none,
                    isCollapsed: true,
                    hintStyle: Topology.darkLargBody.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              PopupWidget(
                child: Row(
                  children: [
                    Text('${Translator.translation(context).is_credit}: '),
                    Switch(
                      value: isCredit,
                      onChanged: (newValue) {
                        setState(() {
                          isCredit = newValue;
                        });
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(Translator.translation(context).cancel),
                  ),
                  CapsuleButton(
                    onPressed: () {
                      Navigator.of(context).pop({
                        "amount": amountText.text,
                        "account": account?.id,
                        "isCredit": isCredit,
                        "notes": notes.text,
                      });
                    },
                    isDisable: false,
                    label: Translator.translation(context).save,
                    icon: Icons.person,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

extension ArabicDigits on String {
  String replaceArabicNumber() {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    String input = this;
    for (int i = 0; i < english.length; i++) {
      input = replaceAll(english[i], arabic[i]);
    }

    return input;
  }
}
