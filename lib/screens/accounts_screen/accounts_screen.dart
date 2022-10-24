//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/screens/accounts_screen/cubits/accounts_cubit/accounts_cubit.dart';
import 'package:my_budget/screens/accounts_screen/cubits/selected_account_cubit/selected_account_cubit.dart';

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

class _AccountsScreenContent extends StatelessWidget {
  const _AccountsScreenContent({Key? key}) : super(key: key);

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
          onPressed: () {},
          icon: Icons.search,
          backgroundColor: Colors.purple,
        ),
        ToolBarButton(
          onPressed: () {
            print(accountsCubit.getExpandedNodes());
            print(
                'selectedSubjectCubit selected: ${selectedAccountCubit.state}');
          },
          icon: Icons.more_vert,
          backgroundColor: Colors.blue,
        ),
      ],
    );
  }

  _showAddSubjectDialog(BuildContext context) async {
    final accountsCubit = context.read<AccountsCubit>();
    final selectedAccountCubit = context.read<SelectedAccountCubit>();
    final TextEditingController newSubject = TextEditingController();
    final alert = _addSubjectAlert(context, newSubject);

    final returned = await showDialog(context: context, builder: (_) => alert);

    final result = returned as String?;
    if (result != null && result == 'Save') {
      final addedNodeId = await accountsCubit.addAccount(
          selectedAccountCubit.state, newSubject.text);
      selectedAccountCubit.selectNodeById(addedNodeId);
    }
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
}
