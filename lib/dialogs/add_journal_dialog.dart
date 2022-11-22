//

import 'package:flutter/material.dart';

import '../database/models/journal_entry.dart';
import '../database/models/object_label.dart';
import '../helpers/localization/language_constants.dart';
import '../styling/styling.dart';
import '../widgets/main_widgets_imports.dart';

AlertDialog addJournalAlert(
  BuildContext context, {
  required List<ObjectTitle> accounts,
  required JournalEntry? entry,
}) {
  final TextEditingController amountText =
      TextEditingController(text: entry?.amount.toString());
  final TextEditingController notes = TextEditingController(text: entry?.notes);
  bool isCredit = entry?.isCredit ?? false;
  ObjectTitle? account = (entry == null)
      ? null
      : accounts.firstWhere((element) => element.id == entry.releatedAccountId);
  return AlertDialog(
    contentPadding:
        const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 8,
    content: StatefulBuilder(
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
                objectsList: accounts,
                initialValue: entry?.releatedAccount ?? '',
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
                    Navigator.of(context).pop();
                  },
                  child: Text(Translator.translation(context).cancel),
                ),
                CapsuleButton(
                  onPressed: () {
                    Navigator.of(context).pop({
                      "amount": amountText.text,
                      "account": account?.id,
                      "isCredit": isCredit,
                      "notes": notes.text,
                    });
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
    ),
  );
}
