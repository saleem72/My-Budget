//

abstract class AppAccount {
  int get id;
  int? get parentId;
  bool get isCredit;
  String get english;
  String get arabic;
}

enum MainAccounts implements AppAccount {
  debit,
  credit;

  @override
  int get id {
    switch (this) {
      case MainAccounts.debit:
        return 1;
      case MainAccounts.credit:
        return 2;
    }
  }

  @override
  int? get parentId => null;

  @override
  bool get isCredit {
    switch (this) {
      case MainAccounts.debit:
        return true;
      case MainAccounts.credit:
        return false;
    }
  }

  @override
  String get english {
    switch (this) {
      case MainAccounts.debit:
        return 'Debit';
      case MainAccounts.credit:
        return 'Credit';
    }
  }

  @override
  String get arabic {
    switch (this) {
      case MainAccounts.debit:
        return 'مدين';
      case MainAccounts.credit:
        return 'دائن';
    }
  }
}

enum CreditMainAccounts implements AppAccount {
  cashier,
  purchases,
  bills;

  @override
  int get id {
    switch (this) {
      case CreditMainAccounts.cashier:
        return 3;
      case CreditMainAccounts.purchases:
        return 5;
      case CreditMainAccounts.bills:
        return 6;
    }
  }

  @override
  int? get parentId => MainAccounts.credit.id;

  @override
  bool get isCredit => false;

  @override
  String get english {
    switch (this) {
      case CreditMainAccounts.cashier:
        return 'Cashier';
      case CreditMainAccounts.purchases:
        return 'Purchases';
      case CreditMainAccounts.bills:
        return 'Bills';
    }
  }

  @override
  String get arabic {
    switch (this) {
      case CreditMainAccounts.cashier:
        return 'الصندوق';
      case CreditMainAccounts.purchases:
        return 'المشتريات';
      case CreditMainAccounts.bills:
        return 'الفواتير';
    }
  }

  static int get cashierId => CreditMainAccounts.cashier.id;
  static int get billsId => CreditMainAccounts.bills.id;
}

enum DebitMainAccounts implements AppAccount {
  salary;

  @override
  int get id {
    switch (this) {
      case DebitMainAccounts.salary:
        return 4;
    }
  }

  @override
  int? get parentId => MainAccounts.debit.id;

  @override
  bool get isCredit => true;

  @override
  String get english {
    switch (this) {
      case DebitMainAccounts.salary:
        return 'Salary';
    }
  }

  @override
  String get arabic {
    switch (this) {
      case DebitMainAccounts.salary:
        return 'الراتب';
    }
  }
}
