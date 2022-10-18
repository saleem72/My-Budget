//

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/models/tree_node.dart';
import 'package:my_budget/helpers/constants.dart';
import 'package:my_budget/screens/subjects_screen/subjects_tree_cubit/subjects_tree_cubit.dart';
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

class NodeCard extends StatefulWidget {
  const NodeCard({
    Key? key,
    required this.node,
  }) : super(key: key);
  final SubjectWithChilds node;

  @override
  State<NodeCard> createState() => _NodeCardState();
}

class _NodeCardState extends State<NodeCard> {
  // bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SubjectsTreeCubit>();
    return BlocBuilder<SubjectsTreeCubit, bool>(
      builder: (context, state) => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: Constants.subjectTileChildsYOffset,
              margin: const EdgeInsets.symmetric(
                  vertical: Constants.subjectTileHeight * 0.5),
              decoration: BoxDecoration(
                border: Border(
                  left: widget.node.isExpanded
                      ? const BorderSide(
                          color: Colors.blue,
                        )
                      : BorderSide.none,
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            Expanded(
              child: Container(
                height: cubit.heightForNode(widget.node),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        cubit.toggleExpandedForNode(widget.node);
                        setState(() {});
                      },
                      child: Container(
                        height: Constants.subjectTileHeight,
                        // color: Colors.amber,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.node.title),
                            Transform.rotate(
                              angle: widget.node.isExpanded
                                  ? math.pi / 2
                                  : -math.pi / 2,
                              child: const Icon(Icons.chevron_right),
                            ),
                          ],
                        ),
                      ),
                    ),
                    widget.node.childs.isNotEmpty && widget.node.isExpanded
                        ? Container(
                            // color: Colors.blue,
                            child: _buildChildsList(),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildsList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.node.childs.map((e) => NodeCard(node: e)).toList(),
    );
  }
}
