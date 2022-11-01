//
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_budget/styling/topology.dart';

class Constants {
  Constants._();

  static const double subjectTileChildsYOffset = 24;

  static const double verticalGap = 8;
  static const double verticalPadding = 8;
  static const double movementIndicatorHeight = 28;

  static double journalRowHeight(BuildContext context,
      {TextStyle style = Topology.darkMeduimBody}) {
    final lineHeight = _lineHeight(context, style);
    return lineHeight +
        max(movementIndicatorHeight, lineHeight) +
        verticalGap +
        verticalPadding * 2;
  }

  static double subjectTileHeight(BuildContext context,
      {TextStyle style = Topology.darkLargBody}) {
    final lineHeight = _lineHeight(context, style);
    return lineHeight + 2 * verticalPadding;
    // return 44;
  }

  static double billRowHeight(BuildContext context, TextStyle style) {
    final lineHeight = _lineHeight(context, style);
    return lineHeight + 2 * 4;
  }

  static double _lineHeight(BuildContext context, TextStyle style) =>
      (TextPainter(
              text: TextSpan(text: 'Hello', style: style),
              maxLines: 1,
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              textDirection: TextDirection.ltr)
            ..layout())
          .size
          .height;

  /*
return LayoutBuilder(builder: (context, constraints) {
  final span = TextSpan(text: yourText, style: yourStyle);
  final tp = TextPainter(text: span);
  tp.layout(maxWidth: constraints.maxWidth);
  final numLines = textPainter.computeLineMetrics().length;

  if (numLines > 3) {
    // TODO: display the prompt message
    return ColoredBox(color: Colors.red);
  } else {
    return Text(yourText, style: yourStyle);
  }
});

  */
  static double billRowGap = 8;
  static double billQantityWidth = 50;
  static double billPriceWidth = 60;
  static double billTotalWidth = 75;

  static double billMaxRowHeight(BuildContext context,
      {required String title,
      required TextStyle style,
      required TextDirection direction}) {
    final span = TextSpan(text: title, style: style);
    final tp = TextPainter(text: span, textDirection: direction);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double maxWidth = screenWidth -
        48 -
        billRowGap -
        billRowGap -
        billQantityWidth -
        billPriceWidth -
        billTotalWidth;
    tp.layout(maxWidth: maxWidth);
    final numLines = tp.computeLineMetrics().length;
    return (numLines * _lineHeight(context, style)) + 8;
  }
}
