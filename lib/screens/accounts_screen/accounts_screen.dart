//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/models/account_with_childs.dart';
import 'package:my_budget/database/models/tree_node.dart';
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
    final accountsCubit = context.read<AccountsCubit>();
    final selectedAccountCubit = context.read<SelectedAccountCubit>();
    return Row(
      children: [
        ToolBarButton(
          onPressed: () {
            accountsCubit.deleteAccount(selectedAccountCubit.state);
            selectedAccountCubit.selectNodeById(null);
          },
          icon: Icons.delete,
          backgroundColor: Colors.pink,
        ),
        ToolBarButton(
          onPressed: () {
            _showAddSubjectDialog(context);
          },
          icon: Icons.add,
          backgroundColor: Colors.green,
        ),
        ToolBarButton(
          onPressed: () {
            _showAddEntryDialog(context);
          },
          icon: Icons.search,
          backgroundColor: Colors.purple,
        ),
        ToolBarButton(
          onPressed: () {
            _showEditSubjectDialog(context);
          },
          icon: Icons.more_vert,
          backgroundColor: Colors.blue,
        ),
      ],
    );
  }

  _showAddEntryDialog(BuildContext context) async {
    final selected = context.read<SelectedAccountCubit>().state;
    if (selected == null) {
      return;
    }
    final accountCubit = context.read<AccountsCubit>();
    final accounts = accountCubit.accounts;
    // TreeNode
    final selectedAccount = accounts.nodeForId(selected) as AccountWithChilds?;
    if (selectedAccount == null) {
      return;
    }

    final result = await showDialog(
        context: context,
        builder: (context) {
          return _addEntryAlert(context, selectedAccount);
        });
    print(result);
    final json = result as Map<String, dynamic>?;

    if (json != null) {
      // "title": title.text, "isCredit"
      final newTitle = json['title'] as String;
      final newIsCredit = json['isCredit'] as bool? ?? false;
      final newAccount = selectedAccount.account?.copyWith(
        title: newTitle,
        isCredit: newIsCredit,
      );

      if (newAccount == null) {
        return;
      }
      if (mounted) {
        final database = context.read<BudgetDatabaseCubit>().database;

        database.accountsDao.updateAccount(newAccount);
      }
    } else {
      print('No result');
    }
  }

  AlertDialog _addEntryAlert(BuildContext context, AccountWithChilds account) {
    final TextEditingController title =
        TextEditingController(text: account.title);
    bool isCredit = account.isCredit;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Pallet.appBar,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                Assests.journalOut,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Edit ${account.title}',
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
                label: 'Title',
                hint: 'Title',
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
                      Text('Is credit: '),
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
          label: 'Save',
          icon: Icons.person,
        ),
      ],
    );
  }

  _showAddSubjectDialog(BuildContext context) async {
    final accountsCubit = context.read<AccountsCubit>();
    final selectedAccountCubit = context.read<SelectedAccountCubit>();
    final TextEditingController newSubject = TextEditingController();
    final alert = _addSubjectAlert(context, newSubject);

    final returned = await showDialog(
      context: context,
      builder: (_) => alert,
    );

    final result = returned as String?;
    if (result != null && result == 'Save') {
      final addedNodeId = await accountsCubit.addAccount(
          selectedAccountCubit.state, newSubject.text);
      selectedAccountCubit.selectNodeById(addedNodeId);
    }
  }

  Widget _saveButton(BuildContext context, Object result) {
    return CapsuleButton(
      onPressed: () {
        Navigator.of(context).pop(result);
      },
      isDisable: false,
      label: 'Save',
      icon: Icons.person,
    );
  }

  Widget _cancelButtonButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('Cancel'),
    );
  }

  AlertDialog _addSubjectAlert(
      BuildContext context, TextEditingController controller) {
    final saveButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop('Save');
      },
      child: const Text('Save'),
    );

    final cancelButtonButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('Cancel'),
    );
    return AlertDialog(
      title: const Text('Add Subject'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: controller,
            hint: 'Subject name',
          ),
        ],
      ),
      actions: [
        saveButton,
        cancelButtonButton,
      ],
    );
  }

  _showEditSubjectDialog(BuildContext context) async {
    final subjectsCubit = context.read<AccountsCubit>();
    final subjectSelectedCubit = context.read<SelectedAccountCubit>();
    final TextEditingController newSubject = TextEditingController();
    final alert = _addSubjectAlert(context, newSubject);

    final returned = await showDialog(context: context, builder: (_) => alert);

    final result = returned as String?;
    if (result != null && result == 'Save') {
      final addedNodeId = await subjectsCubit.addAccount(
          subjectSelectedCubit.state, newSubject.text);
      subjectSelectedCubit.selectNodeById(addedNodeId);
    }
  }

  AlertDialog _editSubjectAlert(
      BuildContext context, TextEditingController controller) {
    final saveButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop('Save');
      },
      child: const Text('Save'),
    );
    final cancelButtonButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('Cancel'),
    );
    return AlertDialog(
      title: const Text('Add Subject'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: controller,
            hint: 'Subject name',
          ),
        ],
      ),
      actions: [
        saveButton,
        cancelButtonButton,
      ],
    );
  }
}

class VerticalTextField extends StatelessWidget {
  const VerticalTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.hint = '',
  }) : super(key: key);

  final String label;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Topology.darkLargBody,
        ),
        const SizedBox(height: 4),
        Material(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: BoxDecoration(
              // color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(),
            ),
            child: TextField(
              controller: controller,
              style: Topology.darkLargBody,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
