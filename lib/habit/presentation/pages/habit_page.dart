// ignore_for_file: unused_result

import 'package:blur/blur.dart';
import 'package:femease/habit/repository/habit_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/repository/auth_repository.dart';

class HabitPage extends ConsumerStatefulWidget {
  const HabitPage({
    super.key,
    required this.imageUrl,
    required this.tag,
  });

  final String imageUrl;
  final String tag;

  @override
  ConsumerState<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends ConsumerState<HabitPage> {
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  int calories = 0;

  void squatsCalculations() {
    calories = 0;
    if (_setsController.text.isNotEmpty && _repsController.text.isNotEmpty) {
      calories = (int.parse(_setsController.text) *
              int.parse(_repsController.text) *
              0.32)
          .toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.secondary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: const Text("Habit Tracker"),
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              bottom: 10,
              right: -110,
              child: Hero(
                tag: widget.tag,
                child: Image.asset(
                  widget.imageUrl,
                  height: 500,
                  width: 500,
                ).blurred(
                  blur: 10,
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: GestureDetector(
                          onTap: () async {
                            int mood = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("How are you feeling?"),
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(1);
                                        },
                                        icon: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Text("😁"),
                                            Text("Happy")
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(2);
                                        },
                                        icon: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Text("🙂"),
                                            Text("Calm")
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(3);
                                        },
                                        icon: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Text("😞"),
                                            Text("Bored")
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(4);
                                        },
                                        icon: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Text("😢"),
                                            Text("Sad")
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(5);
                                        },
                                        icon: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Text("😡"),
                                            Text("Angry")
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(0);
                                      },
                                      child: const Text("Close"),
                                    ),
                                  ],
                                );
                              },
                            );
                            if (mood != 0) {
                              await ref
                                  .watch(firebaseHabitRepositoryProvider)
                                  .addMood(
                                    moodNo: mood,
                                    date: DateTime.now()
                                        .toIso8601String()
                                        .substring(0, 10),
                                    userId: ref
                                        .watch(firebaseAuthRepositoryProvider)
                                        .currentUser!
                                        .uid,
                                  );

                              ref.refresh(isHabitPresentProvider);
                              ref.refresh(getMoodLisrProvider);
                              ref.refresh(getMoodPresentProvider);
                            }
                          },
                          child: Card(
                            elevation: 10,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ref.watch(isHabitPresentProvider).when(
                                        data: (data) => Text(
                                          !data
                                              ? "How do you feel about your day?"
                                              : "You are feeling ${ref.watch(getMoodPresentProvider).when(
                                                    data: (data) =>
                                                        "${moodMap[data]}",
                                                    error: (error, stack) => "",
                                                    loading: () => "",
                                                  )}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                        error: (error, stack) => Text(
                                          error.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                        loading: () =>
                                            const CupertinoActivityIndicator(),
                                      ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ref.watch(getMoodLisrProvider).when(
                              data: (data) => Column(
                                children: [
                                  const Text("Mood Tracker"),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 300,
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: LineChart(
                                        LineChartData(
                                          minX: 1,
                                          maxX: 7,
                                          minY: 0,
                                          maxY: 5,
                                          titlesData: FlTitlesData(
                                            topTitles: AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                            rightTitles: AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                            leftTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                getTitlesWidget: (value, meta) {
                                                  if (value == 0) {
                                                    return const SizedBox();
                                                  }
                                                  return Text(
                                                    moodMap[value].toString(),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          lineBarsData: [
                                            LineChartBarData(
                                              spots: data
                                                  .map(
                                                    (key, value) => MapEntry(
                                                      key,
                                                      FlSpot(
                                                        key.toDouble() + 1,
                                                        value.toDouble(),
                                                      ),
                                                    ),
                                                  )
                                                  .values
                                                  .toList(),
                                              isCurved: true,
                                              isStrokeCapRound: true,
                                              dotData: FlDotData(
                                                show: true,
                                              ),
                                              belowBarData: BarAreaData(
                                                show: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              error: (error, stack) => Text(
                                error.toString(),
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              loading: () => const CupertinoActivityIndicator(),
                            ),
                      ),
                      const Text("Exercise Tracker"),
                      const SizedBox(
                        height: 18,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 200,
                                child: FilledButton(
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                        builder: (context, setState) {
                                      return AlertDialog(
                                        title: const Text("Squats"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextField(
                                              controller: _targetController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                labelText: "Tageted Calories",
                                              ),
                                            ),
                                            TextField(
                                              controller: _repsController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                labelText:
                                                    "Enter number of reps",
                                              ),
                                              onChanged: (val) {
                                                setState(() {
                                                  squatsCalculations();
                                                });
                                              },
                                            ),
                                            TextField(
                                              controller: _setsController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                labelText:
                                                    "Enter number of sets",
                                              ),
                                              onChanged: (val) {
                                                setState(() {
                                                  squatsCalculations();
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text("Calories Burnt: $calories"),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                  child: const Text("Squats"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 200,
                                child: FilledButton(
                                  onPressed: () {},
                                  child: const Text("Lunges"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 200,
                                child: FilledButton(
                                  onPressed: () {},
                                  child: const Text("Treadmill"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 200,
                                child: FilledButton(
                                  onPressed: () {},
                                  child: const Text("Plank"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 200,
                                child: FilledButton(
                                  onPressed: () {},
                                  child: const Text("Pushups"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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

Map<int, String> moodMap = {
  1: "😁",
  2: "🙂",
  3: "😞",
  4: "😢",
  5: "😡",
};
