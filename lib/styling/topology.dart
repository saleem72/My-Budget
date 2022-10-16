//

import 'package:flutter/material.dart';
import 'package:my_budget/styling/pallet.dart';

class Topology {
  Topology._();

  static const String _fontFamily = 'Poppins';

  static const TextStyle title = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w900,
    fontSize: 16,
  );

  static const TextStyle lightSmallBody = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: Colors.white,
  );

  static const TextStyle darkSmallBody = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: Pallet.appBar,
  );

  static const TextStyle lightLargBody = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: Colors.white,
  );

  static const TextStyle darkMeduimBody = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Pallet.appBar,
  );

  static const TextStyle lightMeduimBody = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Colors.white,
  );

  static const TextStyle darkLargBody = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: Pallet.appBar,
  );
}
