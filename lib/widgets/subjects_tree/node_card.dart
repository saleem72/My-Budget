//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/models/tree_node.dart';
import 'package:my_budget/helpers/constants.dart';
import 'package:my_budget/screens/subjects_screen/subjects_tree_cubit/subjects_tree_cubit.dart';
import 'package:my_budget/styling/topology.dart';
import 'package:my_budget/widgets/subjects_tree/subjects_tree_selected_node_cubit/subjects_tree_selected_node_cubit.dart';

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
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SubjectsTreeCubit>();
    return BlocBuilder<SubjectsTreeCubit, bool>(
      builder: (context, state) => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _expantionSection(cubit),
            _node(cubit),
          ],
        ),
      ),
    );
  }

  Expanded _node(SubjectsTreeCubit cubit) {
    return Expanded(
      child: SizedBox(
        // duration: const Duration(milliseconds: 250),
        height: cubit.heightForNode(widget.node),
        child: Column(
          children: [
            _nodeTitle(),
            _nodeChildren(),
          ],
        ),
      ),
    );
  }

  Widget _expantionSection(SubjectsTreeCubit cubit) {
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

  Widget _expantionIcon(SubjectsTreeCubit cubit) {
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

  Widget _nodeTitle() {
    return BlocListener<TreeSelectedNodeCubit, TreeNode?>(
      listener: (context, state) {
        setState(() {
          _isSelected = widget.node == state;
        });
      },
      child: SizedBox(
        height: Constants.subjectTileHeight,
        child: GestureDetector(
          onTap: () =>
              context.read<TreeSelectedNodeCubit>().selectNode(widget.node),
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  decoration: BoxDecoration(
                    color: _isSelected
                        ? Colors.grey.shade400
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.node.title,
                    style: Topology.darkLargBody.copyWith(
                      color: _isSelected ? Colors.green : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _expantionButton(SubjectsTreeCubit cubit) {
  //   return widget.node.childs.isNotEmpty
  //       ? IconButton(
  //           onPressed: () {
  //             cubit.toggleExpandedForNode(widget.node);
  //             // setState(() {});
  //           },
  //           icon: Transform.rotate(
  //             angle: widget.node.isExpanded ? math.pi / 2 : -math.pi / 2,
  //             child: const Icon(Icons.chevron_right),
  //           ),
  //         )
  //       : const SizedBox.shrink();
  // }

  Widget _buildChildsList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.node.childs.map((e) => NodeCard(node: e)).toList(),
    );
  }
}
