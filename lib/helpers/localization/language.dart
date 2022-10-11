//
enum Language { english, arabic }

extension LanguageDetails on Language {
  String get title {
    switch (this) {
      case Language.english:
        return 'English';
      case Language.arabic:
        return 'العربية';
    }
  }

  String get languageCode {
    switch (this) {
      case Language.english:
        return 'en';
      case Language.arabic:
        return 'ar';
    }
  }
}
/*

class Language {
  final int id;
  final String name;
  final String languageCode;

  Language(this.id, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(2, "English", "en"),
      Language(3, "العربية", "ar"),
    ];
  }
}

*/
