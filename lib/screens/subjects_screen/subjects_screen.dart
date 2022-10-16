//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/helpers/localization/language_constants.dart';
import 'package:my_budget/widgets/subjects_tree/subjects_tree.dart';

import '../../database/buget_database_cubit/budget_database_cubit.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translator.translation(context).subjects_tag),
      ),
      body: Column(
        children: [
          Expanded(
            child: _subjectsTree(context),
          ),
        ],
      ),
    );
  }

  Widget _subjectsTree(BuildContext context) {
    final database = context.read<BudgetDatabaseCubit>().database;
    final stream = database.subjectsDao.watchAllSubjects();
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          return SubjectsTree(data: data);
        });
  }
}