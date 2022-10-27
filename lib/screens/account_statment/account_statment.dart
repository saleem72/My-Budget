//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/buget_database_cubit/budget_database_cubit.dart';
import 'package:my_budget/database/models/journal_entry.dart';
import 'package:my_budget/database/models/object_label.dart';
import 'package:my_budget/styling/assets.dart';
import 'package:my_budget/styling/topology.dart';

import '../../database/app_database.dart';
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

  List<ObjectTitle> _accountList = [];
  ObjectTitle? _selectedAccount;
  List<JournalEntry> journals = [];

  @override
  void initState() {
    super.initState();
    _loadAccountsList();
  }

  void _loadAccountsList() async {
    final database = context.read<BudgetDatabaseCubit>().database;

    final result = await database.accountsDao.accountsTitles();
    print('Autocomplete has ${result.length} accounts');
    setState(() {
      _accountList = result;
    });
  }

  void getJournalsFor() async {
    if (_selectedAccount != null) {
      journals.clear();
      final list = await context
          .read<BudgetDatabaseCubit>()
          .database
          .debenturesDao
          .getOtherStatmentForAccountById(_selectedAccount!.id);
      if (mounted) {
        setState(() {
          journals = list;
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
        const SizedBox(height: 16),
        Expanded(
          child: _buildAccountStatment(journals),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(),
          ),
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
                  objectsList: _accountList,
                  onSelected: (item) {
                    setState(() {
                      _selectedAccount = item;
                    });
                  },
                ),
              ),
              const SizedBox(width: 4),
              InkWell(
                onTap: () => getJournalsFor(),
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
      ),
    );
  }

  Widget _buildAccountStatment(List<JournalEntry> entries) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
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
                      ? '${_selectedAccount!.title} statments'
                      : 'Please select an account',
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
                  child: JournalList(
                    data: entries,
                    totalHeight: listHeight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
