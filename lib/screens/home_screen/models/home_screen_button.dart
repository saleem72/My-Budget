//

import 'package:flutter/material.dart';
import 'package:my_budget/styling/pallet.dart';

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

  String get label {
    switch (this) {
      case HomeScreenButton.bill:
        return 'Invoice';
      case HomeScreenButton.diary:
        return 'Dialy Mov';
      case HomeScreenButton.accountStatment:
        return 'Account Statment';
      case HomeScreenButton.budget:
        return 'Budget';
    }
  }

  IconData get icon {
    switch (this) {
      case HomeScreenButton.bill:
        return Icons.person;
      case HomeScreenButton.diary:
        return Icons.attach_file;
      case HomeScreenButton.accountStatment:
        return Icons.document_scanner;
      case HomeScreenButton.budget:
        return Icons.scale;
    }
  }
}
