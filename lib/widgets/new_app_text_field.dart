//

import 'package:flutter/material.dart';

import '../styling/styling.dart';

class NewAppTextField extends StatelessWidget {
  const NewAppTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.keyboard = TextInputType.text,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final TextInputType keyboard;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Topology.darkLargBody,
      keyboardType: keyboard,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
        isCollapsed: true,
        hintStyle: Topology.darkLargBody.copyWith(
          color: Colors.grey,
        ),
      ),
    );
  }
}
