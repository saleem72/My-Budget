// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_budget/database/models/subject_title.dart';
import 'package:my_budget/helpers/routing/nav_links.dart';

import '../../database/app_database.dart';
import '../../database/buget_database_cubit/budget_database_cubit.dart';
import '../../database/models/object_label.dart';
import '../../helpers/localization/language_constants.dart';
import '../../widgets/main_widgets_imports.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({Key? key}) : super(key: key);

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  bool isCredit = false;
  ObjectTitle? _selectedBill;

  @override
  void initState() {
    super.initState();

    // setState(() {
    //   _dialogs = [_addDialog];
    // });
  }

  @override
  Widget build(BuildContext context) {
    // return ScreenWithDialog(
    //   mainScreen: _buildMainScreen(context),
    //   // dialogs: _dialogs,
    //   dialogs: [
    //     _addDialog,
    //   ],
    // );

    return _buildMainScreen(context);
  }

  Widget _buildMainScreen(BuildContext context) {
    final database = context.read<BudgetDatabaseCubit>().database;
    final stream = database.billsDao.watchAllBills();
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        final bills = snapshot.data ?? [];
        return Scaffold(
          appBar: AppBar(
            title: Text(Translator.translation(context).bills),
          ),
          body: _buildBillsContent(context, bills),
        );
      },
    );
  }

  Widget _buildBillsContent(BuildContext context, List<Bill> bills) {
    final DateFormat dateFormatter = DateFormat('d - MMM');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        _selectBillToolBar(bills, dateFormatter, context),
        const SizedBox(height: 8),
        _billsList(context, bills),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _billsList(BuildContext context, List<Bill> bills) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: PopupWidget(
          child: _buildBillsList(context, bills),
        ),
      ),
    );
  }

  Widget _selectBillToolBar(
      List<Bill> bills, DateFormat dateFormatter, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: PopupWidget(
              radius: 8,
              child: AppAutoComplete(
                objectsList: bills
                    .map((e) => SubjectTitle(
                        id: e.id, title: dateFormatter.format(e.date)))
                    .toList(),
                hint: Translator.translation(context).select_bill_hint,
                onSelected: (p0) {
                  setState(() {
                    _selectedBill = p0;
                  });
                },
              ),
            ),
          ),
          ToolBarButton(
            icon: Icons.add,
            onPressed: () {
              Navigator.of(context).pushNamed(NavLinks.addBill);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBillsList(BuildContext context, List<Bill> bills) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: BillsHeader(),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: bills.length,
            itemBuilder: (context, index) {
              final bill = bills[index];
              return BillRow(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(NavLinks.addBill, arguments: bill);
                },
                bill: bill,
                index: index + 1,
              );
            },
          ),
        ),
      ],
    );
  }
}
