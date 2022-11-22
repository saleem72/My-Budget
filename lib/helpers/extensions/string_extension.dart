//

extension AppStringUtils on String {
  String replaceArabicNumber() {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    String input = this;
    for (int i = 0; i < english.length; i++) {
      input = replaceAll(english[i], arabic[i]);
    }

    return input;
  }
}
