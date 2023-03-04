import 'package:femease/menstruation_cycle/presentation/pages/last_date_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenstrualQuestionPage extends ConsumerStatefulWidget {
  const MenstrualQuestionPage({super.key});

  @override
  ConsumerState<MenstrualQuestionPage> createState() =>
      _MenstrualQuestionPageState();
}

class _MenstrualQuestionPageState extends ConsumerState<MenstrualQuestionPage> {
  int questionNo = 0;
  String answer1 = "";
  String answer2 = "";
  String answer3 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menstrual Cycle"),
      ),
      body: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question[questionNo],
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: options[questionNo]?.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (questionNo == 0) {
                            answer1 = options[questionNo]![index];
                          } else if (questionNo == 1) {
                            answer2 = options[questionNo]![index];
                          } else if (questionNo == 2) {
                            answer3 = options[questionNo]![index];
                          }
                          if (questionNo < 3) {
                            setState(() {
                              questionNo++;
                            });
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MenstrualDatePage(
                                  answer1: answer1,
                                  answer2: answer2,
                                  answer3: answer3,
                                ),
                              ),
                            );
                          }
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              options[questionNo]![index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

final List<String> question = [
  "Is your menstual cycle regular(varies by no more than 7 days)?",
  "Do you experience discomfort due to any of the following?",
  "What is the average duration of your menstrual cycle?",
  "What is your flow intensity?",
  "What is the date of your last period?"
];

final Map<int, List<String>> options = {
  0: [
    "Regular",
    "Irregular",
    "Not Sure",
  ],
  1: [
    "Painfull Menstrual Cramps",
    "PMS Symptoms",
    "Unusual Discharge",
    "Mood Swings"
  ],
  2: [
    "3 Days",
    "5 Days",
    "7 Days",
    "10 Days",
    "More than 10 days",
  ],
  3: [
    "High",
    "Medium",
    "Low",
  ]
};
