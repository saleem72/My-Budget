//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/models/account_with_childs.dart';

import '../../../helpers/constants.dart';
import '../../../styling/styling.dart';
import '../cubits/accounts_cubit/accounts_cubit.dart';
import '../cubits/selected_account_cubit/selected_account_cubit.dart';

class AccountNodeCard extends StatefulWidget {
  const AccountNodeCard({
    Key? key,
    required this.node,
  }) : super(key: key);
  final AccountWithChilds node;

  @override
  State<AccountNodeCard> createState() => _AccountNodeCardState();
}

class _AccountNodeCardState extends State<AccountNodeCard> {
  // bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    final accountsCubit = context.read<AccountsCubit>();

    return BlocBuilder<SelectedAccountCubit, int?>(
      builder: (context, state) => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _expantionSection(accountsCubit),
            _node(accountsCubit, widget.node.id == state),
          ],
        ),
      ),
    );
  }

  Expanded _node(AccountsCubit cubit, bool isSelected) {
    return Expanded(
      child: SizedBox(
        // duration: const Duration(milliseconds: 250),
        height: cubit.heightForNode(context, widget.node),
        child: Column(
          children: [
            _nodeTitle(context, isSelected),
            _nodeChildren(),
          ],
        ),
      ),
    );
  }

  Widget _expantionSection(AccountsCubit cubit) {
    return Container(
      width: Constants.subjectTileChildsYOffset,
      margin: EdgeInsets.only(
        top: Constants.subjectTileHeight(context) * 0.5 - 14,
        bottom: Constants.subjectTileHeight(context) * 0.2,
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

  Widget _expantionIcon(AccountsCubit cubit) {
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

  Widget _nodeTitle(BuildContext context, bool isSelected) {
    return SizedBox(
      height: Constants.subjectTileHeight(context),
      child: GestureDetector(
        onTap: () {
          context.read<SelectedAccountCubit>().selectNode(widget.node);
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.node.title,
                      style: Topology.darkLargBody.copyWith(
                        color: isSelected ? Colors.green : Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: Image.asset(
                        widget.node.isCredit
                            ? Assests.journalIn
                            : Assests.journalOut,
                        color: widget.node.isCredit
                            ? Colors.green
                            : Colors.redAccent,
                      ),
                    )
                  ],
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
      children:
          widget.node.childs.map((e) => AccountNodeCard(node: e)).toList(),
    );
  }
}
