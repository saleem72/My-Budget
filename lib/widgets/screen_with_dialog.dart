//

import 'package:flutter/material.dart';

import '../models/dialog_option.dart';
import 'dialog_screen.dart';

class ScreenWithDialog extends StatefulWidget {
  const ScreenWithDialog({
    Key? key,
    required this.mainScreen,
    required this.dialogs,
  }) : super(key: key);
  final Widget mainScreen;
  final List<DialogOption> dialogs;
  @override
  State<ScreenWithDialog> createState() => _ScreenWithDialogState();
}

class _ScreenWithDialogState extends State<ScreenWithDialog> {
  @override
  void didUpdateWidget(covariant ScreenWithDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        widget.mainScreen,
        for (final dialog in widget.dialogs)
          dialog.isVisible
              ? DialogScreen(
                  onClose: dialog.onClose,
                  operation: dialog.operation,
                  child: dialog.dialog,
                )
              : const SizedBox.shrink(),
      ],
    );
  }
}
