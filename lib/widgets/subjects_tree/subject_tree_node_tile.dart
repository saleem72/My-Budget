//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/models/tree_node.dart';
import 'package:my_budget/helpers/localization/language.dart';
import 'package:my_budget/helpers/localization/locale_cubit/locale_cubit.dart';

import '../../database/models/subject_with_childs.dart';
import 'subjects_tree_selected_node_cubit/subjects_tree_selected_node_cubit.dart';

class SubjectTreeNodeTile extends StatelessWidget {
  const SubjectTreeNodeTile({
    Key? key,
    required this.subject,
  }) : super(key: key);
  final SubjectWithChilds subject;
  @override
  Widget build(BuildContext context) {
    final locale = context.read<LocaleCubit>().state;
    return BlocBuilder<TreeSelectedNodeCubit, TreeNode?>(
      builder: (context, state) {
        final bool isSelected = state == subject;
        return Container(
          margin: subject.parentId == null
              ? EdgeInsets.zero
              : locale.languageCode == Language.arabic.languageCode
                  ? const EdgeInsets.only(right: 16)
                  : const EdgeInsets.only(left: 16),
          child: subject.childs.isEmpty
              ? _subjectTitle(context, isSelected: isSelected)
              : ExpansionTile(
                  title: _subjectTitle(context, isSelected: isSelected),
                  children: subject.childs
                      .map((e) => Container(
                            margin: locale.languageCode ==
                                    Language.arabic.languageCode
                                ? const EdgeInsets.only(right: 16)
                                : const EdgeInsets.only(left: 16),
                            child: SubjectTreeNodeTile(subject: e),
                          ))
                      .toList(),
                ),
        );
      },
    );
  }

  Widget _subjectTitle(BuildContext context, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        context.read<TreeSelectedNodeCubit>().selectNode(subject);
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
