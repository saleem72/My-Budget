//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/helpers/localization/language_constants.dart';
import 'package:my_budget/widgets/subjects_tree/subjects_tree_selected_node_cubit/subjects_tree_selected_node_cubit.dart';

import '../../database/buget_database_cubit/budget_database_cubit.dart';
import '../../widgets/main_widgets_imports.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = context.read<BudgetDatabaseCubit>().database;
    return BlocProvider(
      create: (context) => TreeSelectedNodeCubit(database: database),
      child: Scaffold(
        appBar: AppBar(
          title: Text(Translator.translation(context).subjects_tag),
        ),
        body: const _SubjectsScreenContent(),
      ),
    );
  }
}

class _SubjectsScreenContent extends StatefulWidget {
  const _SubjectsScreenContent({Key? key}) : super(key: key);

  @override
  State<_SubjectsScreenContent> createState() => _SubjectsScreenContentState();
}

class _SubjectsScreenContentState extends State<_SubjectsScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _toolbar(context),
        // const SizedBox(height: 16),
        Expanded(
          child: _subjectsTree(context),
        ),
      ],
    );
  }

  Row _toolbar(BuildContext context) {
    final cubit = context.read<TreeSelectedNodeCubit>();
    return Row(
      children: [
        ToolBarButton(
          onPressed: () => cubit.deleteSubject(),
          icon: Icons.delete,
          backgroundColor: Colors.pink,
        ),
        ToolBarButton(
          onPressed: () => _showAddSubjectDialog(context),
          icon: Icons.add,
          backgroundColor: Colors.green,
        ),
        ToolBarButton(
          onPressed: () {},
          icon: Icons.search,
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

  Widget _subjectsTree(BuildContext context) {
    final database = context.read<BudgetDatabaseCubit>().database;
    final stream = database.subjectsDao.watchAllSubjects();
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          //todo: compare with the old arrays to expanded
          final data = snapshot.data ?? [];
          return SubjectsTree(data: data);
        });
  }

  _showAddSubjectDialog(BuildContext context) async {
    if (mounted) {}
    final cubit = context.read<TreeSelectedNodeCubit>();
    final TextEditingController newSubject = TextEditingController();
    final alert = _addSubjectAlert(context, newSubject);

    final returned = await showDialog(context: context, builder: (_) => alert);

    final result = returned as String?;

    if (result != null && result == 'Save') {
      cubit.addSubject(newSubject.text);
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
