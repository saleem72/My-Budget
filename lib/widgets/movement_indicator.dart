//

import 'package:flutter/material.dart';
import 'package:my_budget/helpers/constants.dart';

import '../styling/styling.dart';

class MovementIndicator extends StatelessWidget {
  const MovementIndicator({
    Key? key,
    required this.isIn,
  }) : super(key: key);

  final bool isIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.movementIndicatorHeight,
      height: Constants.movementIndicatorHeight,
      decoration: BoxDecoration(
        color: isIn ? Colors.green : Colors.red,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: 18,
        height: 13,
        child: Image.asset(
          isIn ? Assests.journalIn : Assests.journalOut,
          color: Colors.white,
        ),
      ),
    );
  }
}
