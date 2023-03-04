import 'package:blur/blur.dart';
import 'package:femease/forum/presentation/pages/fitness/fitness_page.dart';
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
                    const ListTile(
                      title: Text("Mental Health"),
                      leading: Icon(Icons.spa_outlined),
                      subtitle: Text("Mental Health related discussions"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    const ListTile(
                      title: Text("Yoga and Meditation"),
                      leading: Icon(Icons.self_improvement_rounded),
                      subtitle: Text("Yoga and Meditation related discussions"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    const ListTile(
                      leading: Icon(Icons.business),
                      title: Text("Buisness"),
                      subtitle: Text("Buisness powerhouse"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    const ListTile(
                      leading: Icon(Icons.female),
                      title: Text("Menstrual Cycle"),
                      subtitle: Text("Menstrual Cycle related discussions"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    const ListTile(
                      leading: Icon(Icons.piano),
                      title: Text("Fun"),
                      subtitle: Text("Just have some fun!"),
                      trailing: Icon(Icons.arrow_forward_ios),
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
