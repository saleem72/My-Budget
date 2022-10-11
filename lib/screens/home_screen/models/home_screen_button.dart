//

import 'package:flutter/material.dart';
import 'package:my_budget/styling/assets.dart';
import 'package:my_budget/styling/pallet.dart';

import '../../../helpers/localization/language_constants.dart';

enum HomeScreenButton { bill, diary, accountStatment, budget }

extension HomeScreenButtonDetails on HomeScreenButton {
  Color get color {
    switch (this) {
      case HomeScreenButton.bill:
        return Pallet.green;
      case HomeScreenButton.diary:
        return Pallet.yellow;
      case HomeScreenButton.accountStatment:
        return Pallet.blue;
      case HomeScreenButton.budget:
        return Pallet.red;
    }
  }

  String label(BuildContext context) {
    switch (this) {
      case HomeScreenButton.bill:
        return Translator.translation(context).invoice_tag;
      case HomeScreenButton.diary:
        return Translator.translation(context).daily_tag;
      case HomeScreenButton.accountStatment:
        return Translator.translation(context).account_statment_tag;
      case HomeScreenButton.budget:
        return Translator.translation(context).budget_tag;
    }
  }

  String get icon {
    switch (this) {
      case HomeScreenButton.bill:
        return Assests.invoice;
      case HomeScreenButton.diary:
        return Assests.daily;
      case HomeScreenButton.accountStatment:
        return Assests.statment;
      case HomeScreenButton.budget:
        return Assests.budget;
    }
  }
}
