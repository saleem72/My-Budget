//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/helpers/localization/language_constants.dart';
import 'package:my_budget/widgets/subjects_tree/subjects_tree.dart';
import 'package:my_budget/widgets/subjects_tree/subjects_tree_selected_node_cubit/subjects_tree_selected_node_cubit.dart';

import '../../database/buget_database_cubit/budget_database_cubit.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = context.read<BudgetDatabaseCubit>().database;
    return BlocProvider(
      create: (context) => TreeSelectedNodeCubit(database: database),
      child: Scaffold(
        appBar: AppBar(
          title: Text(Translator.translation(context).subjects_tag),
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
    return Column(
      children: [
        Expanded(
          child: _subjectsTree(context),
        ),
      ],
    );
  }

  Widget _subjectsTree(BuildContext context) {
    final database = context.read<BudgetDatabaseCubit>().database;
    final stream = database.accountsDao.watchAllAccounts();
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          return SubjectsTree(data: data);
          // return Text(data.length.toString());
        });
  }
}
