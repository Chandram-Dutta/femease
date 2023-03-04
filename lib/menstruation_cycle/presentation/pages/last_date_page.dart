// ignore_for_file: use_build_context_synchronously

import 'package:calendar_view/calendar_view.dart';
import 'package:femease/menstruation_cycle/presentation/pages/menstruation_cycle_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenstrualDatePage extends ConsumerStatefulWidget {
  const MenstrualDatePage({
    super.key,
    required this.answer1,
    required this.answer2,
    required this.answer3,
  });

  final String answer1;
  final String answer2;
  final String answer3;

  @override
  ConsumerState<MenstrualDatePage> createState() => _MenstrualDatePageState();
}

class _MenstrualDatePageState extends ConsumerState<MenstrualDatePage> {
  DateTime _selectedDate = DateTime.now().subtract(const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menstrual Cycle"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Last Date of Period",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "Please select the date of your last period",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                maximumDate: DateTime.now().add(const Duration(days: 1)),
                onDateTimeChanged: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
            ),
            FilledButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isDataPresent', true);
                final DateTime date = _selectedDate;
                CalendarControllerProvider.of(context).controller.add(
                      CalendarEventData(
                        title: "Next Menstrual Cycle",
                        date: (date).add(const Duration(days: 28)),
                        endDate: (date).add(const Duration(days: 34)),
                        event: "Next Menstrual Cycle",
                      ),
                    );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MenstrualCyclePage(
                      imageUrl: "assets/images/menstualcycle.png",
                      tag: "menstrual",
                    ),
                  ),
                );
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
