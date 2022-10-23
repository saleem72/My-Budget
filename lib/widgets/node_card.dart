//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/models/tree_node.dart';
import '../helpers/constants.dart';
import '../screens/subjects_screen/cubits/other_subjects_cubit/other_subjects_cubit.dart';
import '../screens/subjects_screen/cubits/other_subjects_selected/other_subjects_selected_cubit.dart';
import '../styling/styling.dart';

class NodeCard extends StatefulWidget {
  const NodeCard({
    Key? key,
    required this.node,
  }) : super(key: key);
  final TreeNode node;

  @override
  State<NodeCard> createState() => _NodeCardState();
}

class _NodeCardState extends State<NodeCard> {
  // bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    final subjectsCubit = context.read<OtherSubjectsCubit>();

    return BlocBuilder<OtherSubjectsSelectedCubit, int?>(
      builder: (context, state) => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _expantionSection(subjectsCubit),
            _node(subjectsCubit, widget.node.id == state),
          ],
        ),
      ),
    );
  }

  Expanded _node(OtherSubjectsCubit cubit, bool isSelected) {
    return Expanded(
      child: SizedBox(
        // duration: const Duration(milliseconds: 250),
        height: cubit.heightForNode(widget.node),
        child: Column(
          children: [
            _nodeTitle(isSelected),
            _nodeChildren(),
          ],
        ),
      ),
    );
  }

  Widget _expantionSection(OtherSubjectsCubit cubit) {
    return Container(
      width: Constants.subjectTileChildsYOffset,
      margin: const EdgeInsets.only(
        top: Constants.subjectTileHeight * 0.5 - 14,
        bottom: Constants.subjectTileHeight * 0.2,
      ),
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _divider(),
          _expantionIcon(cubit),
        ],
      ),
    );
  }

  Widget _divider() {
    return widget.node.isExpanded && widget.node.childs.isNotEmpty
        ? Align(
            alignment: Alignment.center,
            child: VerticalDivider(
              color: Colors.grey.shade900,
              indent: 20,
              endIndent: 9,
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _expantionIcon(OtherSubjectsCubit cubit) {
    return widget.node.childs.isNotEmpty
        ? Align(
            // SubjectsTreeCubit cubit
            alignment: Alignment.topCenter,
            // top: 0,
            child: GestureDetector(
              onTap: () {
                cubit.toggleExpandedForNode(widget.node);
              },
              child: Container(
                height: 24,
                width: 44,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Icon(
                  // remove_outlined add_box_outlined
                  widget.node.isExpanded
                      ? Icons.indeterminate_check_box_outlined
                      : Icons.add_box_outlined,
                  color: Colors.grey.shade500,
                  size: 18,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _nodeChildren() {
    return widget.node.childs.isNotEmpty && widget.node.isExpanded
        ? Container(
            // color: Colors.blue,
            child: _buildChildsList(),
          )
        : const SizedBox.shrink();
  }

  Widget _nodeTitle(bool isSelected) {
    return SizedBox(
      height: Constants.subjectTileHeight,
      child: GestureDetector(
        onTap: () {
          context.read<OtherSubjectsSelectedCubit>().selectNode(widget.node);
        },
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                decoration: BoxDecoration(
                  color:
                      isSelected ? Colors.grey.shade400 : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.node.title,
                  style: Topology.darkLargBody.copyWith(
                    color: isSelected ? Colors.green : Colors.black,
                  ),
                ),
              ),
            ],
          ),
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
