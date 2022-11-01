//

import 'package:flutter/material.dart';

import '../../helpers/localization/language_constants.dart';
import '../../styling/styling.dart';
import '../popup_widget.dart';

class BillTableHeader extends StatelessWidget {
  const BillTableHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PopupWidget(
            child: Center(
              child: Text(
                Translator.translation(context).subject,
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 50,
          child: PopupWidget(
            child: Center(
              child: Text(
                Translator.translation(context).quantity,
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 60,
          child: PopupWidget(
            child: Center(
              child: Text(
                Translator.translation(context).price,
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 83,
          child: PopupWidget(
            child: Center(
              child: Text(
                Translator.translation(context).total,
                style: Topology.darkMeduimBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
