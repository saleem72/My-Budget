// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/helpers/routing/nav_links.dart';
import 'package:my_budget/styling/topology.dart';

import '../../database/buget_database_cubit/budget_database_cubit.dart';
import '../../database/models/object_label.dart';
import '../../helpers/localization/language_constants.dart';
import '../../models/dialog_option.dart';
import '../../widgets/main_widgets_imports.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({Key? key}) : super(key: key);

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  final TextEditingController amountText = TextEditingController();
  final TextEditingController notes = TextEditingController();
  bool isCredit = false;
  ObjectTitle? account;
  ObjectTitle? _selectedBill;
  List<ObjectTitle> _accounts = [];

  late DialogOption _addDialog = DialogOption(
    id: 1,
    dialog: _buildAddDialog(context),
    operation: DialogOperation.none,
    isVisible: false,
    onClose: () => setState(() {
      _addDialog = _addDialog.copyWith(
        isVisible: false,
      );
    }),
  );

  _updateAddDialog(DialogOperation operation) {
    setState(() {
      _addDialog = _addDialog.copyWith(
        operation: operation,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    // setState(() {
    //   _dialogs = [_addDialog];
    // });
  }

  _getAccouns(BuildContext context) async {
    final database = context.read<BudgetDatabaseCubit>().database;
    final accounts = await database.accountsDao.accountsTitles();
    if (mounted) {}

    setState(() {
      amountText.text = '';
      notes.text = '';
      isCredit = false;
      account = null;
      _accounts = accounts;
      _addDialog = _addDialog.copyWith(
        isVisible: true,
        operation: DialogOperation.none,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWithDialog(
      mainScreen: _buildMainScreen(context),
      // dialogs: _dialogs,
      dialogs: [
        _addDialog,
      ],
    );
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

  Widget _buildBillsContent(BuildContext context, List<ObjectTitle> bills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: PopupWidget(
                  radius: 8,
                  child: AppAutoComplete(
                    objectsList: bills,
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
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Container(
            color: Colors.green,
            child: Center(
              child: Text(bills.length.toString()),
            ),
          ),
        ),
        TextButton(
          onPressed: () => _getAccouns(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Show add',
              style: Topology.lightMeduimBody,
            ),
          ),
        ),
      ],
    );
  }

  Widget _addEntryAlert(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Translator.translation(context).add_movment,
                  style: Topology.darkMeduimBody.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            VerticalTextField(
              radius: 8,
              controller: amountText,
              keyboard: TextInputType.number,
              label: Translator.translation(context).amount,
              hint: Translator.translation(context).amount,
            ),
            const SizedBox(height: 16),
            PopupWidget(
              radius: 8,
              child: AppAutoComplete(
                objectsList: _accounts,
                hint: Translator.translation(context).select_account_hint,
                onSelected: (p0) {
                  setState(() {
                    account = p0;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            PopupWidget(
              child: TextField(
                controller: notes,
                style: Topology.darkLargBody,
                decoration: InputDecoration(
                  hintText: Translator.translation(context).notes,
                  border: InputBorder.none,
                  isCollapsed: true,
                  hintStyle: Topology.darkLargBody.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            PopupWidget(
              child: Row(
                children: [
                  Text('${Translator.translation(context).is_credit}: '),
                  Switch(
                    value: isCredit,
                    onChanged: (newValue) {
                      setState(() {
                        isCredit = newValue;
                      });
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _updateAddDialog(DialogOperation.cancel);
                  },
                  child: Text(Translator.translation(context).cancel),
                ),
                CapsuleButton(
                  onPressed: () {
                    // print(
                    //     'Amount: ${amountText.text}, Account: ${account?.id}, notes: ${notes.text} isCredit: $isCredit');
                    _updateAddDialog(DialogOperation.save);
                  },
                  isDisable: false,
                  label: Translator.translation(context).save,
                  icon: Icons.person,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAddDialog(BuildContext context) {
    // return TextField();
    return _addEntryAlert(context);
  }
}
