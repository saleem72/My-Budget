//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/widgets/subjects_tree/subjects_tree_selected_node_cubit/subjects_tree_selected_node_cubit.dart';

import '../../database/models/subject_with_childs.dart';

class SubjectTreeNode extends StatelessWidget {
  const SubjectTreeNode({
    Key? key,
    required this.subject,
  }) : super(key: key);

  final SubjectWithChilds subject;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectsTreeSelectedNodeCubit, SubjectWithChilds?>(
      builder: (context, state) {
        final bool isSelected = state == subject;
        return Container(
          color: Colors.grey.shade300,
          padding: const EdgeInsets.all(8),
          margin: subject.parentId == null
              ? const EdgeInsets.only(bottom: 16)
              : EdgeInsets.zero,
          child: Column(
            children: [
              _subjectTitle(context, isSelected: isSelected),
              subject.childs.isEmpty
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        children: subject.childs
                            .map((e) => SubjectTreeNode(subject: e))
                            .toList(),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _subjectTitle(BuildContext context, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        context.read<SubjectsTreeSelectedNodeCubit>().selectNode(subject);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subject.title,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.green : Colors.black,
              ),
            ),
            isSelected
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 18,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
