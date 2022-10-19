//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/models/tree_node.dart';
import 'package:my_budget/screens/subjects_screen/subjects_tree_cubit/subjects_tree_cubit.dart';
import 'package:my_budget/widgets/subjects_tree/subjects_tree_selected_node_cubit/subjects_tree_selected_node_cubit.dart';

import '../../database/models/subject_with_childs.dart';
import 'node_card.dart';
import 'subject_tree_node_tile.dart';

class SubjectsTree extends StatelessWidget {
  const SubjectsTree({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<SubjectWithChilds> data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubjectsTreeCubit(subjects: data),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return NodeCard(node: data[index]);
        },
      ),
    );
  }
}

class AccountsTree extends StatelessWidget {
  const AccountsTree({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<SubjectWithChilds> data;

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //     itemCount: data.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return SubjectTreeNode(subject: data[index]);
    //     });

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SubjectsTreeCubit(subjects: data),
        ),
      ],
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: NodeCard(node: data[index]),
          );
        },
      ),
    );
  }
}
