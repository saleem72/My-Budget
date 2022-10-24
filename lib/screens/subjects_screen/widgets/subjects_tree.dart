//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/screens/subjects_screen/cubits/subjects_cubit/subjects_cubit.dart';

import '../../../database/models/tree_node.dart';
import 'subject_node_card.dart';

class SubjectsTree extends StatelessWidget {
  const SubjectsTree({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subjectsCubit = context.read<SubjectsCubit>();
    return BlocBuilder<SubjectsCubit, bool>(
      builder: (context, state) {
        List<TreeNode> subjects = subjectsCubit.subjects;
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: subjectsCubit.heightForNode(subjects[index]),
              child: SubjectNodeCard(node: subjects[index]),
            );
          },
        );
      },
    );
  }
}
