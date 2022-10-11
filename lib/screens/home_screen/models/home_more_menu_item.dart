//

import 'package:flutter/material.dart';
import 'package:my_budget/helpers/localization/language_constants.dart';
import 'package:my_budget/styling/assets.dart';

enum HomeMoreMenuItem { subjects, accounts, settings, about }

extension HomeMoreMenuItemDetails on HomeMoreMenuItem {
  String title(BuildContext context) {
    switch (this) {
      case HomeMoreMenuItem.settings:
        return Translator.translation(context).settings_tag;
      case HomeMoreMenuItem.about:
        return Translator.translation(context).aboutus_tag;
      case HomeMoreMenuItem.subjects:
        return Translator.translation(context).subjects_tag;
      case HomeMoreMenuItem.accounts:
        return Translator.translation(context).accounts_tag;
    }
  }

  String get icon {
    switch (this) {
      case HomeMoreMenuItem.settings:
        return Assests.settings;
      case HomeMoreMenuItem.about:
        return Assests.info;
      case HomeMoreMenuItem.subjects:
        return Assests.product;
      case HomeMoreMenuItem.accounts:
        return Assests.account;
    }
  }
}
