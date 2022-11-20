//

import 'package:flutter/material.dart';
import 'package:my_budget/helpers/localization/language_constants.dart';
import 'package:my_budget/styling/topology.dart';
import 'package:my_budget/widgets/main_widgets_imports.dart';

class Utilities {
  Utilities._();

  static closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static showMessage(
    BuildContext context, {
    required String message,
    String title = 'Warnning',
    TextStyle titleTextStyle = Topology.darkLargBody,
    TextStyle messageTextStyle = Topology.darkMeduimBody,
  }) {
    final alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(title, style: titleTextStyle),
      content: Text(message, style: messageTextStyle),
      actions: [
        CapsuleButton(
          label: Translator.translation(context).yes,
          isDisable: false,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alert);
  }

  static showConfirmMessage(
    BuildContext context, {
    required String message,
    required Function onOk,
    String title = 'Warnning',
    TextStyle titleTextStyle = Topology.darkLargBody,
    TextStyle messageTextStyle = Topology.darkMeduimBody,
  }) {
    final alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(title, style: titleTextStyle),
      content: Text(message, style: messageTextStyle),
      actions: [
        CapsuleButton(
          label: Translator.translation(context).yes,
          isDisable: false,
          onPressed: () {
            onOk();
            Navigator.of(context).pop();
          },
        ),
        CapsuleButton(
          label: Translator.translation(context).no,
          isDisable: false,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alert);
  }
}
