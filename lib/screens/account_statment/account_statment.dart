//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/buget_database_cubit/budget_database_cubit.dart';
import 'package:my_budget/database/models/journal_entry.dart';
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

  void getStatements() async {
    if (_selectedAccount != null) {
      statements.clear();
      final list = await context
          .read<BudgetDatabaseCubit>()
          .database
          .debenturesDao
          .getStatmentForAccountById(_selectedAccount!.id);
      if (mounted) {
        setState(() {
          statements = list;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                Translator.translation(context).in_details,
                style: Topology.darkMeduimBody,
              ),
              Switch(
                value: inDetails,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: _buildAccountStatment(statements),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
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
                onChange: (_) {
                  if (statements.isNotEmpty) {
                    setState(() {
                      statements = [];
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
              onTap: () => getStatements(),
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
