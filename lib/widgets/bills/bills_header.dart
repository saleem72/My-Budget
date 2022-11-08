//

import 'package:flutter/material.dart';

import '../../helpers/localization/language_constants.dart';

class BillsHeader extends StatelessWidget {
  const BillsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 24,
          child: Text(
            '#',
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 60,
          child: Text(
            Translator.translation(context).date,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 60,
          child: Text(
            Translator.translation(context).total,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            children: [
              Text(
                Translator.translation(context).notes,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
