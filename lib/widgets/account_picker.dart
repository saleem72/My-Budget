//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/app_database.dart';
import '../database/buget_database_cubit/budget_database_cubit.dart';
import '../styling/styling.dart';

class AccountPicker extends StatefulWidget {
  const AccountPicker({
    Key? key,
    required this.onSelect,
  }) : super(key: key);
  final Function(Account) onSelect;
  @override
  State<AccountPicker> createState() => _AccountPickerState();
}

class _AccountPickerState extends State<AccountPicker> {
  List<Account> accounts = [];

  Account? account;

  @override
  void initState() {
    super.initState();
    _initValues();
  }

  void _initValues() async {
    final database = context.read<BudgetDatabaseCubit>().database;
    final returnedAccounts = await database.accountsDao.getAllAccounts();
    if (returnedAccounts.isNotEmpty) {
      setState(() {
        accounts = returnedAccounts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(
        labelStyle: Topology.darkLargBody,
        isCollapsed: true,
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
        hintText: 'Please select expense',
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(5.0),
        // ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Account?>(
          value: account,
          isExpanded: true,
          isDense: true,
          style: Topology.darkLargBody,
          items: accounts
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e.title,
                      style: Topology.darkLargBody,
                    ),
                  ))
              .toList(),
          onChanged: (item) {
            if (item != null) {
              setState(() {
                account = item;
              });
              widget.onSelect(item);
            }
          },
        ),
      ),
    );
  }
}
