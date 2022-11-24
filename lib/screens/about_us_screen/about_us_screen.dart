//

import 'package:flutter/material.dart';
import 'package:my_budget/database/models/journal_entry.dart';
import 'package:my_budget/widgets/main_widgets_imports.dart';

import '../../styling/styling.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  // DateTime _selectedDate = DateTime.now();
  List<JournalEntry> bills = [];

  void updateSelectedDate(DateTime date) {
    // setState(() {
    //   _selectedDate = date; // date.add(const Duration(hours: 5));
    // });
  }

  void _doit(BuildContext context) async {
    // final database = context.read<BudgetDatabaseCubit>().database;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildSearchBar(context),
        ),
        _doitButton(context),
        Expanded(
          child: Container(
            color: Colors.grey.shade200,
            child: ListView.builder(
              itemCount: bills.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(bills[index].amount.toString()),
                    const SizedBox(width: 16),
                    Text(bills[index].releatedAccount)
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  TextButton _doitButton(BuildContext context) {
    return TextButton(
      onPressed: () => _doit(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(4, 4),
            )
          ],
        ),
        child: Text(
          'Do it',
          style: Topology.darkMeduimBody.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return PopupWidget(
      borderWidth: 0.5,
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              child: SizedBox(
                height: 14,
                width: 14,
                child: Image.asset(
                  Assests.calendar,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: AnotherDatePicker(
              label: 'Select date',
              onChange: (date) => updateSelectedDate(date),
            ),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: () {},
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              child: SizedBox(
                height: 14,
                width: 14,
                child: Image.asset(Assests.filter),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
