//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/buget_database_cubit/budget_database_cubit.dart';
import 'package:my_budget/database/models/journal_entry.dart';
import 'package:my_budget/helpers/extensions/datetime_extension.dart';
import 'package:my_budget/screens/sreens_imports.dart';
import 'package:my_budget/styling/assets.dart';
import 'package:my_budget/styling/topology.dart';

import '../../database/app_database.dart';
import '../../database/models/account_title.dart';
import '../../helpers/localization/language_constants.dart';
import '../../widgets/main_widgets_imports.dart';

class AccountStatmentScreen extends StatefulWidget {
  const AccountStatmentScreen({Key? key}) : super(key: key);

  @override
  State<AccountStatmentScreen> createState() => _AccountStatmentScreenState();
}

class _AccountStatmentScreenState extends State<AccountStatmentScreen> {
  Account? account;
  bool isTableVisible = false;
  double listHeight = 0;
  bool inDetails = false;

  List<AccountTitle> _accountList = [];
  AccountTitle? _selectedAccount;
  List<StatementEntry> statements = [];
  double previousBalance = 0;

  @override
  void initState() {
    super.initState();
    _loadAccountsList();
  }

  void _loadAccountsList() async {
    final database = context.read<BudgetDatabaseCubit>().database;

    final result = await database.accountsDao.accountsTitles();
    setState(() {
      _accountList = result;
    });
  }

  void getStatements(
      {required DateTime startDate, required bool inDetails}) async {
    if (_selectedAccount != null) {
      statements.clear();

      final result = await context
          .read<BudgetDatabaseCubit>()
          .database
          .debenturesDao
          .getStatmentForAccountById(_selectedAccount!.id, startDate);
      if (mounted) {
        setState(() {
          statements = result.statments;
          previousBalance = result.previousBalance;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(Translator.translation(context).account_statment_tag),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        // _buildAutoComplete(context),
        _buildSearchBar(context),
        const SizedBox(height: 16),
        Expanded(
          child: _buildAccountStatment(statements),
        ),
      ],
    );
  }

  void _showReportType(BuildContext context) async {
    if (_selectedAccount == null) {
      return;
    }
    final result = await showDialog(
        context: context,
        builder: (context) {
          return _reportTypeAlert(context);
        });
    final data = result as Map<String, dynamic>?;
    if (data != null) {
      print(
          'startDate: ${data['startDate'] as DateTime}, inDetails: ${data['inDetails'] as bool}');
      getStatements(
        startDate: data['startDate'] as DateTime,
        inDetails: data['inDetails'] as bool,
      );
    }
  }

  AlertDialog _reportTypeAlert(BuildContext context) {
    DateTime selectedDate = AppDates.firstOfCurrent;
    bool isInDetails = false;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(Translator.translation(context).report_type),
      content: StatefulBuilder(
        builder: (context, setState) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text('Selected date'),
                const SizedBox(width: 8),
                Expanded(
                  child: AnotherDatePicker(
                    label: 'Select date',
                    initialDate: selectedDate,
                    onChange: (date) {
                      setState(() {
                        selectedDate = date;
                      });
                      // updateSelectedDate(date);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  Translator.translation(context).in_details,
                  style: Topology.darkMeduimBody,
                ),
                Switch(
                  value: isInDetails,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) {
                    setState(() {
                      isInDetails = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        CapsuleButton(
          label: 'Ok',
          isDisable: false,
          onPressed: () {
            Navigator.of(context)
                .pop({"startDate": selectedDate, "inDetails": isInDetails});
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final isDisabled = _selectedAccount == null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PopupWidget(
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
                    Assests.search,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: AppAutoComplete(
                hint: Translator.translation(context).select_account_hint,
                objectsList: _accountList,
                onChange: (value) {
                  if (statements.isNotEmpty) {
                    setState(() {
                      print(value);
                      statements = [];
                      previousBalance = 0;
                      _selectedAccount = null;
                    });
                  }
                },
                onSelected: (item) {
                  setState(() {
                    _selectedAccount = item as AccountTitle;
                  });
                },
              ),
            ),
            const SizedBox(width: 4),
            InkWell(
              onTap: isDisabled ? null : () => _showReportType(context),
              child: Container(
                height: 24,
                width: 24,
                alignment: Alignment.center,
                child: SizedBox(
                  height: 14,
                  width: 14,
                  child: Image.asset(
                    Assests.filter,
                    color: isDisabled ? Colors.red : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountStatment(List<StatementEntry> entries) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: PopupWidget(
        borderWidth: 0.5,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(),
                ),
              ),
              child: Text(
                _selectedAccount?.title != null
                    ? '${_selectedAccount!.title} ${Translator.translation(context).statments}'
                    : Translator.translation(context).select_account_tag,
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: WidgetSize(
                onChange: (newSize) {
                  setState(() {
                    listHeight = newSize.height;
                  });
                },
                child: StatementsList(
                  data: entries,
                  previousBalance: previousBalance,
                  totalHeight: listHeight,
                  isAccountCredit: _selectedAccount?.isCredit ?? false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
