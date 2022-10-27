//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/models/account_with_childs.dart';

import '../../../database/models/tree_node.dart';
import '../cubits/accounts_cubit/accounts_cubit.dart';
import 'account_node_card.dart';

class AccountsTree extends StatelessWidget {
  const AccountsTree({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountsCubit = context.read<AccountsCubit>();
    return BlocBuilder<AccountsCubit, bool>(
      builder: (context, state) {
        List<AccountWithChilds> subjects = accountsCubit.accounts;
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: accountsCubit.heightForNode(subjects[index]),
              child: AccountNodeCard(node: subjects[index]),
            );
          },
        );
      },
    );
  }
}
