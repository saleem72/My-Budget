//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../styling/styling.dart';

class AppTextFieldWithDate extends StatefulWidget {
  AppTextFieldWithDate({
    Key? key,
    required this.onChange,
    required this.label,
    final DateTime? initialDate,
    this.hint,
  })  : defualtValue = initialDate ?? DateTime.now(),
        super(key: key);
  final String? hint;
  final String label;
  final DateTime defualtValue;
  final Function(DateTime) onChange;

  @override
  State<AppTextFieldWithDate> createState() => _AppTextFieldWithDateState();
}

class _AppTextFieldWithDateState extends State<AppTextFieldWithDate> {
  DateTime? _selectedDate;

  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
        text: DateFormat('yyyy, MMM, dd').format(widget.defualtValue));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.label,
          style: Topology.darkLargBody,
        ),
        Expanded(
          child: TextField(
            controller: controller,
            onTap: () => _showDatePicker(context),
            style: Topology.darkLargBody.copyWith(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            readOnly: true,
            decoration: InputDecoration(
                hintText: widget.hint,
                border: InputBorder.none,
                hintStyle: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: Colors.grey.shade500)),
          ),
        ),
      ],
    );
  }

  _showDatePicker(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.defualtValue,
      firstDate: DateTime(DateTime.now().year - 40),
      lastDate: DateTime(DateTime.now().year + 40),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        widget.onChange(pickedDate);
        controller.text = DateFormat('yyyy, MMM, dd').format(pickedDate);
      });
    }
  }
}
