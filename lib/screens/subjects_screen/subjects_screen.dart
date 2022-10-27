//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/buget_database_cubit/budget_database_cubit.dart';
import 'package:my_budget/screens/subjects_screen/cubits/subjects_cubit/subjects_cubit.dart';
import 'package:my_budget/screens/subjects_screen/cubits/selected_subject_cubit/selected_subject.dart';

import '../../helpers/localization/language_constants.dart';
import '../../widgets/main_widgets_imports.dart';
import 'widgets/subjects_tree.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = context.read<BudgetDatabaseCubit>().database;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SubjectsCubit(database: database)),
        BlocProvider(create: (_) => SelectedSubjectCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(Translator.translation(context).subjects_tag),
        ),
        body: const _SubjectsScreenContent(),
      ),
    );
  }
}

class _SubjectsScreenContent extends StatelessWidget {
  const _SubjectsScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subjectsCubit = context.read<SubjectsCubit>();
    final database = context.read<BudgetDatabaseCubit>().database;
    final stream = database.subjectsDao.watchAllSubjects();
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        subjectsCubit.setSubjects(data);

        return Column(
          children: [
            _toolbar(context),
            const Expanded(
              child: SubjectsTree(),
            ),
          ],
        );
      },
    );
  }

  Widget _toolbar(BuildContext context) {
    final subjectsCubit = context.read<SubjectsCubit>();
    final selectedSubjectCubit = context.read<SelectedSubjectCubit>();
    return Row(
      children: [
        ToolBarButton(
          onPressed: () {
            subjectsCubit.deleteSubject(selectedSubjectCubit.state);
            selectedSubjectCubit.selectNodeById(null);
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
          onPressed: () {},
          icon: Icons.more_vert,
          backgroundColor: Colors.blue,
        ),
      ],
    );
  }

  _showAddSubjectDialog(BuildContext context) async {
    final subjectsCubit = context.read<SubjectsCubit>();
    final subjectSelectedCubit = context.read<SelectedSubjectCubit>();
    final TextEditingController newSubject = TextEditingController();
    final alert = _addSubjectAlert(context, newSubject);

    final returned = await showDialog(context: context, builder: (_) => alert);

    final result = returned as String?;
    if (result != null && result == 'Save') {
      final addedNodeId = await subjectsCubit.addSubject(
          subjectSelectedCubit.state, newSubject.text);
      subjectSelectedCubit.selectNodeById(addedNodeId);
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
