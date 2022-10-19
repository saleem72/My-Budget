//

import 'package:flutter/material.dart';

class ToolBarButton extends StatelessWidget {
  const ToolBarButton({
    Key? key,
    required this.icon,
    this.backgroundColor = Colors.green,
    this.foregroundColor = Colors.white,
    this.elevation = 4,
    this.iconSize = 18,
    required this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final double elevation;
  final Function onPressed;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(),
      icon: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: elevation,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: foregroundColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
