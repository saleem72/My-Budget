//

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../main.dart';

// Future<Locale> setLocal(BuildContext context, String languageCode) async {
//   final Safe safe = locator();
//   final local = await safe.setLocal(languageCode);
//   MyApp.setLocale(local);
//   return local;
// }

// Future<Locale> getLocal() async {
//   final Safe safe = locator();
//   final local = await safe.getLocal();
//   return local;
// }
class Translator {
  Translator._();
  static AppLocalizations translation(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}
