//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/screens/subjects_screen/cubits/other_subjects_cubit/other_subjects_cubit.dart';

import '../database/models/tree_node.dart';
import 'node_card.dart';

class NodesTree extends StatelessWidget {
  const NodesTree({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subjectsCubit = context.read<OtherSubjectsCubit>();
    return BlocBuilder<OtherSubjectsCubit, bool>(
      builder: (context, state) {
        List<TreeNode> subjects = subjectsCubit.subjects;
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: subjectsCubit.heightForNode(subjects[index]),
              child: NodeCard(node: subjects[index]),
            );
          },
        );
      },
    );
  }
}
