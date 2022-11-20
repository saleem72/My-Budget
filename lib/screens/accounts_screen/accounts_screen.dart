//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/models/account_title.dart';
import 'package:my_budget/database/models/account_with_childs.dart';
import 'package:my_budget/database/models/tree_node.dart';
import 'package:my_budget/helpers/utilities.dart';
import 'package:my_budget/screens/accounts_screen/cubits/accounts_cubit/accounts_cubit.dart';
import 'package:my_budget/screens/accounts_screen/cubits/selected_account_cubit/selected_account_cubit.dart';
import 'package:my_budget/styling/assets.dart';
import 'package:my_budget/styling/pallet.dart';
import 'package:my_budget/styling/topology.dart';

import '../../database/app_database.dart';
import '../../database/buget_database_cubit/budget_database_cubit.dart';
import '../../helpers/localization/language_constants.dart';
import '../../widgets/main_widgets_imports.dart';
import 'widgets/accounts_tree.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = context.read<BudgetDatabaseCubit>().database;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AccountsCubit(database: database)),
        BlocProvider(create: (_) => SelectedAccountCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(Translator.translation(context).accounts_tag),
        ),
        body: const _AccountsScreenContent(),
      ),
    );
  }
}

class _AccountsScreenContent extends StatefulWidget {
  const _AccountsScreenContent({Key? key}) : super(key: key);

  @override
  State<_AccountsScreenContent> createState() => _AccountsScreenContentState();
}

class _AccountsScreenContentState extends State<_AccountsScreenContent> {
  @override
  Widget build(BuildContext context) {
    final accountsCubit = context.read<AccountsCubit>();
    final database = context.read<BudgetDatabaseCubit>().database;
    final stream = database.accountsDao.watchAllAccounts();
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        accountsCubit.setAccounts(data);

        return Column(
          children: [
            _toolbar(context),
            const Expanded(
              child: AccountsTree(),
            ),
          ],
        );
      },
    );
  }

  Widget _toolbar(BuildContext context) {
    return Row(
      children: [
        ToolBarButton(
          onPressed: () => _deleteAccount(context),
          icon: Icons.delete,
          backgroundColor: Colors.pink,
        ),
        ToolBarButton(
          onPressed: () {
            _showAddAccount(context);
          },
          icon: Icons.add,
          backgroundColor: Colors.green,
        ),
        ToolBarButton(
          onPressed: () {
            _showEditAccount(context);
          },
          icon: Icons.edit,
          backgroundColor: Colors.purple,
        ),
        ToolBarButton(
          onPressed: () {},
          icon: Icons.more_vert,
          backgroundColor: Colors.blue,
        ),
      ],
    );
  }

  _deleteAccount(BuildContext context) async {
    final database = context.read<BudgetDatabaseCubit>().database;
    final selectedAccountCubit = context.read<SelectedAccountCubit>();
    final selectedId = selectedAccountCubit.state;

    if (selectedId != null) {
      Utilities.showConfirmMessage(
        context,
        message: Translator.translation(context).delete_account_message,
        title: Translator.translation(context).delete_account,
        titleTextStyle: Topology.darkLargBody.copyWith(
          color: Colors.redAccent,
        ),
        onOk: () {
          print('Will be deleted');
          database.accountsDao.deleteAccount(selectedId);
          selectedAccountCubit.selectNodeById(null);
        },
      );
    }
  }

  _showAddAccount(BuildContext context) async {
    final database = context.read<BudgetDatabaseCubit>().database;
    final accountsCubit = context.read<AccountsCubit>();
    final selectedAccount = context.read<SelectedAccountCubit>().state;

    final returned = await showDialog(
        context: context,
        builder: (context) {
          return _addAccountAlert(context, null);
        });

    final result = returned as Map<String, dynamic>?;
    if (result != null) {
      final title = result['title'] as String;
      final isCredit = result['isCredit'] as bool;
      // ابو غياث
      accountsCubit.expandSelected(selectedAccount);
      database.accountsDao.addAccount(
          parentId: selectedAccount, title: title, isCredit: isCredit);
    }
  }

  _showEditAccount(BuildContext context) async {
    final database = context.read<BudgetDatabaseCubit>().database;
    final accountsCubit = context.read<AccountsCubit>();
    final selectedAccount = context.read<SelectedAccountCubit>().state;
    Account? account = null;
    if (selectedAccount != null) {
      account = await database.accountsDao.getAccountForId(selectedAccount);
    } else {
      return;
    }

    final returned = await showDialog(
        context: context,
        builder: (context) {
          return _addAccountAlert(context, account);
        });
    // وائل
    final result = returned as Map<String, dynamic>?;
    if (result != null) {
      final title = result['title'] as String;
      final isCredit = result['isCredit'] as bool;
      final editedAccount = account!.copyWith(title: title, isCredit: isCredit);
      database.accountsDao.updateAccount(editedAccount);
    }
  }

  AlertDialog _addAccountAlert(BuildContext context, Account? account) {
    final TextEditingController title =
        TextEditingController(text: account?.title);
    bool isCredit = account?.isCredit ?? false;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            account == null
                ? Translator.translation(context).add_account
                : Translator.translation(context).edit_account,
            style: Topology.darkLargBody.copyWith(
              // fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: StatefulBuilder(
        builder: (context, setState) => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              VerticalTextField(
                controller: title,
                label: Translator.translation(context).title,
                hint: Translator.translation(context).title,
                keyboard: TextInputType.text,
              ),
              const SizedBox(height: 16),
              Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                elevation: 4,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  decoration: BoxDecoration(
                    // color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(),
                  ),
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
              ),
            ],
          ),
        ),
      ),
      actions: [
        _cancelButtonButton(context),
        CapsuleButton(
          onPressed: () {
            Navigator.of(context)
                .pop({"title": title.text, "isCredit": isCredit});
          },
          isDisable: false,
          label: Translator.translation(context).save,
          icon: Icons.person,
        ),
      ],
    );
  }

  Widget _cancelButtonButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(Translator.translation(context).cancel),
    );
  }
}
