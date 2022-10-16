//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/buget_database_cubit/budget_database_cubit.dart';
import 'package:my_budget/database/models/journal_entry.dart';
import 'package:my_budget/styling/pallet.dart';

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildAccountPicker(context),
        ),
        Expanded(
          child: (isTableVisible && account != null)
              ? _buildAccountStatmentFutur(context, account!)
              : Container(),
        ),
      ],
    );
  }

  Widget _buildAccountPicker(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${Translator.translation(context).account_tag}:'),
        const SizedBox(width: 8),
        Expanded(
          child: AccountPicker(
            onSelect: (item) {
              setState(() {
                account = item;
              });
            },
          ),
        ),
        const SizedBox(width: 8),
        TextButton(
            onPressed: account != null
                ? () => setState(() {
                      isTableVisible = true;
                    })
                : null,
            style: TextButton.styleFrom(
              backgroundColor: Pallet.appBar,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Pallet.appBar.withOpacity(0.3),
              disabledForegroundColor: Colors.white.withOpacity(0.4),
            ),
            child: const Center(child: Text('Display'))),
      ],
    );
  }

  Widget _buildAccountStatmentFutur(
      BuildContext context, Account selectedAccount) {
    final accountsDao =
        context.read<BudgetDatabaseCubit>().database.debenturesDao;
    return FutureBuilder(
      future: accountsDao.getStatmentForAccount(selectedAccount),
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        switch (snapshot.connectionState) {
          default:
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              if (data.isNotEmpty) {
                return _buildAccountStatment(data);
              } else {
                return const Text('No Accounts');
              }
            }
        }
      },
    );
  }

  Widget _buildAccountStatment(List<JournalEntry> entries) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            children: [
              const Text('Hello there'),
              const SizedBox(height: 8),
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
