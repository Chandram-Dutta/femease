import 'package:blur/blur.dart';
import 'package:femease/forum/presentation/pages/buisness/for_hire/for_hire_page.dart';
import 'package:femease/forum/presentation/pages/fitness/fitness_page.dart';
import 'package:femease/forum/presentation/pages/fun/fun_page.dart';
import 'package:femease/forum/presentation/pages/mental_health/mental_page.dart';
import 'package:femease/forum/presentation/pages/yoga/yoga_page.dart';
import 'package:flutter/material.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({
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
        title: const Text("Community"),
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
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.fitness_center),
                      title: const Text("Fitness"),
                      subtitle: const Text("Fitness related discussions"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FitnessPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text("Mental Health"),
                      leading: const Icon(Icons.spa_outlined),
                      subtitle: const Text("Mental Health related discussions"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MentalPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text("Mindfulness"),
                      leading: const Icon(Icons.self_improvement_rounded),
                      subtitle:
                          const Text("Yoga and Meditation related discussions"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const YogaPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.business),
                      title: const Text("Buisness"),
                      subtitle: const Text("Buisness powerhouse"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForHirePage(),
                          ),
                        );
                      },
                    ),
                    // const ListTile(
                    //   leading: Icon(Icons.female),
                    //   title: Text("Menstrual Cycle"),
                    //   subtitle: Text("Menstrual Cycle related discussions"),
                    //   trailing: Icon(Icons.arrow_forward_ios),
                    // ),
                    ListTile(
                      leading: const Icon(Icons.piano),
                      title: const Text("Fun"),
                      subtitle: const Text("Just have some fun!"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FunPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
