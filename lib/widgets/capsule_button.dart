//

import 'package:flutter/material.dart';

import '../styling/styling.dart';

class CapsuleButton extends StatelessWidget {
  const CapsuleButton({
    Key? key,
    required this.label,
    required this.isDisable,
    required this.onPressed,
    this.icon,
  }) : super(key: key);
  final String label;
  final bool isDisable;
  final Function onPressed;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          decoration: BoxDecoration(
            color: !isDisable ? Pallet.appBar : Pallet.appBar.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon != null
                  ? Icon(
                      icon,
                      color: Colors.white,
                      size: 14,
                    )
                  : const SizedBox.shrink(),
              icon != null
                  ? const SizedBox(width: 12)
                  : const SizedBox.shrink(),
              Text(
                label,
                style: Topology.lightMeduimBody.copyWith(
                  fontWeight: FontWeight.w600,
                  color:
                      !isDisable ? Colors.white : Colors.white.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
