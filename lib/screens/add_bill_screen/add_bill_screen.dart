//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/helpers/localization/language_constants.dart';
import 'package:my_budget/helpers/utilities.dart';
import 'package:my_budget/models/bill_item_model.dart';

import '../../database/app_database.dart';
import '../../database/buget_database_cubit/budget_database_cubit.dart';
import '../../database/models/journal_entry.dart';
import '../../database/models/object_label.dart';
import '../../models/dialog_option.dart';
import '../../styling/styling.dart';
import '../../widgets/main_widgets_imports.dart';

class AddBillScreen extends StatefulWidget {
  const AddBillScreen({Key? key, this.bill}) : super(key: key);

  final Bill? bill;

  @override
  State<AddBillScreen> createState() => _AddBillScreenState();
}

class _AddBillScreenState extends State<AddBillScreen> {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _notes = TextEditingController();
  List<BillItemModel> _items = [];

  final TextEditingController dialogQuantity = TextEditingController();
  final TextEditingController dialogPrice = TextEditingController();
  final TextEditingController dialogNotes = TextEditingController();
  bool dialogIsCredit = false;
  List<ObjectTitle> subjects = [];
  ObjectTitle? dialogSelectedSubject;
  // "سيارة فورملا وان اخر موديل لون اسود" "سي"
  // "بيجاما" "بي"
  // "فاتورة من عند ابو غياث"
  // "بعض الخضراوات"
  double get _total =>
      _items.fold(0, (previousValue, element) => previousValue + element.total);

  late DialogOption _addDialog = DialogOption(
    id: 1,
    dialog: _addEntryAlert(context),
    operation: DialogOperation.none,
    isVisible: false,
    onClose: () => setState(() {
      _addDialog = _addDialog.copyWith(
        isVisible: false,
      );
    }),
  );

  _updateAddDialog(DialogOperation operation) {
    if (operation == DialogOperation.save) {
      final newItem = BillItemModel(
        subjectId: dialogSelectedSubject?.id ?? 0,
        subject: dialogSelectedSubject?.title ?? '',
        quantity: int.parse(dialogQuantity.text),
        price: double.parse(dialogPrice.text),
        notes: dialogNotes.text.isNotEmpty ? dialogNotes.text : null,
      );
      _items.add(newItem);
    }
    setState(() {
      _addDialog = _addDialog.copyWith(
        operation: operation,
      );
    });
  }

  _getSubjects(BuildContext context) async {
    List<ObjectTitle> allSubjects = subjects;
    if (subjects.isEmpty) {
      final database = context.read<BudgetDatabaseCubit>().database;
      allSubjects = await database.subjectsDao.subjectsTitles();
    }

    if (mounted) {}

    setState(() {
      dialogPrice.text = '';
      dialogQuantity.text = '';
      dialogNotes.text = '';
      dialogSelectedSubject = null;
      subjects = allSubjects;
      _addDialog = _addDialog.copyWith(
        isVisible: true,
        operation: DialogOperation.none,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.bill != null) {
      _setupBill(widget.bill!);
    } else {
      print('No bill at all');
    }
  }

  void _setupBill(Bill bill) async {
    final database = context.read<BudgetDatabaseCubit>().database;
    final billItem = await database.billsDao.getBillItems(bill.id);
    final newItems = billItem
        .map(
          (e) => BillItemModel(
            subjectId: e.subject.id,
            subject: e.subject.title,
            quantity: e.item.quantity,
            price: e.item.price,
          ),
        )
        .toList();
    setState(() {
      _selectedDate = bill.date;
      _notes.text = bill.notes ?? '';
      _items = newItems;
    });
  }

  void _saveBill(BuildContext context) async {
    if (widget.bill != null) {
      Utilities.showMessage(
        context,
        message: Translator.translation(context).can_not_save,
        title: Translator.translation(context).save_bill,
        titleTextStyle: Topology.darkMeduimBody.copyWith(
          color: Colors.redAccent,
        ),
      );
      return;
    }
    final database = context.read<BudgetDatabaseCubit>().database;

    database.billsDao.insertBill(
      date: _selectedDate.add(const Duration(hours: 5)),
      notes: _notes.text,
      items: _items,
      totla: _total,
    );
    final billsId = await database.accountsDao.getAccountForTitle('Bills');
    final entry = JournalEntry(
      id: 0,
      date: _selectedDate,
      relatedAccount: 'Bills',
      amount: _total,
      accountId: billsId?.id ?? 0,
      notes: _notes.text,
    );
    database.debenturesDao.addJournalEntry(entry);
    if (mounted) {}
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWithDialog(
      mainScreen: _buildMainScreen(context),
      dialogs: [_addDialog],
    );
  }

  Scaffold _buildMainScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translator.translation(context).add_new_bill),
        actions: [
          ToolBarButton(
            icon: Icons.add,
            onPressed: () => _getSubjects(context),
            backgroundColor: Colors.white,
            foregroundColor: Pallet.appBar,
          ),
          ToolBarButton(
            icon: Icons.check,
            onPressed: () => _saveBill(context),
            backgroundColor: Colors.white,
            foregroundColor: Pallet.appBar,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            _selectDate(context),
            const SizedBox(height: 16),
            _billNotes(context),
            const SizedBox(height: 16),
            Expanded(
              child: _buildItemsList(context),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  PopupWidget _billNotes(BuildContext context) {
    return PopupWidget(
      child: TextField(
        controller: _notes,
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
    );
  }

  Row _selectDate(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PopupWidget(
            child: Row(
              children: [
                Text(
                  '${Translator.translation(context).select_date}: ',
                  style: Topology.darkLargBody,
                ),
                Expanded(
                  child: AnotherDatePicker(
                    label: 'Select date',
                    onChange: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemsList(BuildContext context) {
    return PopupWidget(
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        color: Colors.white,
        child: BillTable(items: _items),
      ),
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
                  Translator.translation(context).add_subject,
                  style: Topology.darkMeduimBody.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            PopupWidget(
              radius: 8,
              child: AppAutoComplete(
                objectsList: subjects,
                hint: Translator.translation(context).select_subject_hint,
                onSelected: (p0) {
                  setState(() {
                    dialogSelectedSubject = p0;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            PopupWidget(
              child: NewAppTextField(
                controller: dialogQuantity,
                keyboard: TextInputType.number,
                hint: Translator.translation(context).quantity,
              ),
            ),
            const SizedBox(height: 16),
            PopupWidget(
              child: NewAppTextField(
                controller: dialogPrice,
                keyboard: TextInputType.number,
                hint: Translator.translation(context).price,
              ),
            ),
            const SizedBox(height: 16),
            PopupWidget(
              child: NewAppTextField(
                controller: dialogNotes,
                hint: Translator.translation(context).notes,
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
}


/*

Column _billTableContents(BuildContext context, NumberFormat formatter) {
    return Column(
      children: [
        const BillTableHeader(),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return BillItemRow(item: _items[index]);
            },
          ),
        ),
        Container(
          height: Constants.billRowHeight(context, Topology.darkMeduimBody),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.blue),
            ),
          ),
          child: Row(
            children: [
              Text(
                '${Translator.translation(context).total}: ',
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                formatter.format(billTotal),
                style: Topology.darkMeduimBody,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _tableHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PopupWidget(
            child: Center(
              child: Text(
                Translator.translation(context).subject,
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 50,
          child: PopupWidget(
            child: Center(
              child: Text(
                Translator.translation(context).quantity,
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 60,
          child: PopupWidget(
            child: Center(
              child: Text(
                Translator.translation(context).price,
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 83,
          child: PopupWidget(
            child: Center(
              child: Text(
                Translator.translation(context).total,
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

*/