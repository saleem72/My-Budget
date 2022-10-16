//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/models/tree_node.dart';
import 'package:my_budget/widgets/subjects_tree/subjects_tree_selected_node_cubit/subjects_tree_selected_node_cubit.dart';

import '../../database/models/subject_with_childs.dart';
import 'subject_tree_node.dart';
import 'subject_tree_node_tile.dart';

class SubjectsTree extends StatelessWidget {
  const SubjectsTree({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<TreeNode> data;

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //     itemCount: data.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return SubjectTreeNode(subject: data[index]);
    //     });

    return BlocProvider(
      create: (context) => SubjectsTreeSelectedNodeCubit(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return SubjectTreeNodeTile(subject: data[index]);
        },
      ),
    );
  }
}
