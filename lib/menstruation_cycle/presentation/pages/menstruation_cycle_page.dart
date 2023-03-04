import 'package:blur/blur.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class MenstrualCyclePage extends StatelessWidget {
  const MenstrualCyclePage({
    super.key,
    required this.imageUrl,
    required this.tag,
  });

  final String imageUrl;
  final String tag;

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
        title: const Text("Menstrual Cycle"),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 10,
            right: -110,
            child: Hero(
              tag: tag,
              child: Image.asset(
                imageUrl,
                height: 500,
                width: 500,
              ).blurred(
                blur: 10,
              ),
            ),
          ),
          SizedBox(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: MonthView(
                      width: 200,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}