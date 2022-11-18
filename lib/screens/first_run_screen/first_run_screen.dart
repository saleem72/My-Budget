//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/buget_database_cubit/budget_database_cubit.dart';
import 'package:my_budget/dependancy_injection.dart' as di;
import 'package:my_budget/helpers/safe/safe.dart';

import '../../helpers/localization/language.dart';
import '../../helpers/localization/language_constants.dart';
import '../../helpers/localization/locale_cubit/locale_cubit.dart';
import '../../styling/styling.dart';

class FirstRunScreen extends StatefulWidget {
  const FirstRunScreen({
    Key? key,
    required this.onProceed,
  }) : super(key: key);

  final Function onProceed;

  @override
  State<FirstRunScreen> createState() => _FirstRunScreenState();
}

class _FirstRunScreenState extends State<FirstRunScreen> {
  bool _isArabic = false;

  void _createDatabase(BuildContext context) async {
    if (_isArabic) {
      final database = context.read<BudgetDatabaseCubit>().database;
      await database.localizeAccounts();
    }

    final Safe safe = di.locator();
    await safe.updateFirstRun();
    widget.onProceed();
  }

  void _handleLanguage(BuildContext context, bool value) {
    if (value != _isArabic) {
      setState(() {
        _isArabic = value;
      });
      context.read<LocaleCubit>().setLocal(
            context,
            _isArabic
                ? Language.arabic.languageCode
                : Language.english.languageCode,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translator.translation(context).first_run),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            Text(
              Translator.translation(context).first_run_inform,
              textAlign: TextAlign.center,
              style: Topology.title,
            ),
            Row(
              children: [
                Text(
                  Translator.translation(context).first_run_arabic,
                  style: Topology.darkLargBody,
                ),
                const SizedBox(width: 16),
                Switch(
                  value: _isArabic,
                  onChanged: (value) => _handleLanguage(context, value),
                ),
              ],
            ),
            TextButton(
              onPressed: () => _createDatabase(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Procced',
                    style: Topology.darkLargBody.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
