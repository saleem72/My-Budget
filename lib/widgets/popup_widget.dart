//

import 'package:flutter/material.dart';

class PopupWidget extends StatelessWidget {
  const PopupWidget({
    Key? key,
    required this.child,
    this.borderColor = Colors.black,
    this.borderWidth = 1,
    this.radius = 10,
  }) : super(key: key);
  final Color borderColor;
  final double borderWidth;
  final double radius;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Material(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        child: child,
      ),
    );
  }
}
