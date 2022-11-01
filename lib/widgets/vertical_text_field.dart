//

import 'package:flutter/material.dart';
import 'package:my_budget/widgets/main_widgets_imports.dart';

import '../styling/styling.dart';

class VerticalTextField extends StatelessWidget {
  const VerticalTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.hint = '',
    this.radius = 6,
    this.keyboard = TextInputType.text,
  }) : super(key: key);

  final String label;
  final String hint;
  final TextEditingController controller;
  final double radius;
  final TextInputType keyboard;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Topology.darkLargBody,
        ),
        const SizedBox(height: 4),
        PopupWidget(
          radius: radius,
          child: TextField(
            controller: controller,
            style: Topology.darkLargBody,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              isCollapsed: true,
              hintStyle: Topology.darkLargBody.copyWith(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
