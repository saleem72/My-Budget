//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/database/buget_database_cubit/budget_database_cubit.dart';
import 'package:my_budget/helpers/localization/language.dart';
import 'package:my_budget/helpers/localization/language_constants.dart';
import 'package:my_budget/helpers/localization/locale_cubit/locale_cubit.dart';
import 'package:my_budget/styling/styling.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isArabic = false;

  @override
  void initState() {
    super.initState();
    _initArabic();
  }

  void _initArabic() {
    final state = context.read<LocaleCubit>().state;
    setState(() {
      _isArabic = state.languageCode == Language.arabic.languageCode;
    });
  }

  void _handleLanguage(BuildContext context, bool value) {
    if (value != _isArabic) {
      setState(() {
        _isArabic = value;
      });
      final localeCubit = context.read<LocaleCubit>();
      localeCubit.setLocal(
        context,
        _isArabic
            ? Language.arabic.languageCode
            : Language.english.languageCode,
      );
      context
          .read<BudgetDatabaseCubit>()
          .database
          .localizeAccounts(_isArabic ? Language.arabic : Language.english);
    }
  }

  void _handleLocaleState(Locale state) {
    setState(() {
      _isArabic = state.languageCode == Language.arabic.languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Translator.translation(context).settings,
          style: Topology.title,
        ),
        centerTitle: true,
      ),
      body: BlocListener<LocaleCubit, Locale>(
        listener: (context, state) => _handleLocaleState(state),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '${Translator.translation(context).use_arabic}:',
                    style: Topology.darkLargBody,
                  ),
                  const SizedBox(width: 16),
                  Switch(
                    value: _isArabic,
                    onChanged: (value) => _handleLanguage(context, value),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
