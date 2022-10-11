//

import 'package:flutter/material.dart';
import 'package:my_budget/helpers/localization/language_constants.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translator.translation(context).subjects_tag),
      ),
      body: Column(),
    );
  }
}
