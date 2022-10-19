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
      create: (context) => SubjectsTreeSelectedNodeCubit(database: database),
      child: Scaffold(
        appBar: AppBar(
          title: Text(Translator.translation(context).subjects_tag),
        ),
        body: const _SubjectsScreenContent(),
      ),
    );
  }

  // Widget _content(BuildContext context) {
  //   final cubit = context.read<SubjectsTreeSelectedNodeCubit>();
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           ToolBarButton(
  //             onPressed: () {},
  //             icon: Icons.delete,
  //             backgroundColor: Colors.pink,
  //           ),
  //           ToolBarButton(
  //             onPressed: () {},
  //             icon: Icons.add,
  //             backgroundColor: Colors.green,
  //           ),
  //           ToolBarButton(
  //             onPressed: () {},
  //             icon: Icons.search,
  //             backgroundColor: Colors.purple,
  //           ),
  //           ToolBarButton(
  //             onPressed: () {},
  //             icon: Icons.more_vert,
  //             backgroundColor: Colors.blue,
  //           ),
  //         ],
  //       ),
  //       Expanded(
  //         child: _subjectsTree(context),
  //       ),
  //     ],
  //   );
  // }

  // Widget _subjectsTree(BuildContext context) {
  //   final database = context.read<BudgetDatabaseCubit>().database;
  //   final stream = database.subjectsDao.watchAllSubjects();
  //   return StreamBuilder(
  //       stream: stream,
  //       builder: (context, snapshot) {
  //         final data = snapshot.data ?? [];
  //         return SubjectsTree(data: data);
  //       });
  // }
}

class _SubjectsScreenContent extends StatelessWidget {
  const _SubjectsScreenContent({Key? key}) : super(key: key);

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
    final cubit = context.read<SubjectsTreeSelectedNodeCubit>();
    return Row(
      children: [
        ToolBarButton(
          onPressed: () => cubit.deleteSubject(),
          icon: Icons.delete,
          backgroundColor: Colors.pink,
        ),
        ToolBarButton(
          onPressed: () => cubit.addSubject(),
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
          final data = snapshot.data ?? [];
          return SubjectsTree(data: data);
        });
  }
}
