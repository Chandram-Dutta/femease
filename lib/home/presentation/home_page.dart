import 'package:femease/authentication/repository/auth_repository.dart';
import 'package:femease/forum/presentation/pages/forum_page.dart';
import 'package:femease/habit/presentation/pages/habit_page.dart';
import 'package:femease/home/controller/alert_controller.dart';
import 'package:femease/menstruation_cycle/presentation/pages/menstruation_cycle_page.dart';
import 'package:femease/menstruation_cycle/presentation/pages/question_page.dart';
import 'package:femease/safety/presentation/pages/safety_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  Future<bool?> isActive() async {
    final box = Hive.box('menstrution');
    return box.get('isActive');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<void> state = ref.watch(alertControllerProvider);
    ref.listen<AsyncValue<void>>(
      alertControllerProvider,
      (_, state) {
        if (state.hasError) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text("Error"),
              content: Text(
                state.error.toString(),
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text("OK"),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          );
        }
      },
    );
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            label: "Settings",
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () =>
                ref.watch(firebaseAuthRepositoryProvider).signOut(),
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Welcome, ${ref.watch(firebaseAuthRepositoryProvider).currentUser?.displayName ?? "User"}",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 150,
                    child: GlowButton(
                      spreadRadius: 0,
                      blurRadius: 20,
                      borderRadius: BorderRadius.circular(100),
                      onPressed: state.isLoading
                          ? null
                          : () =>
                              ref.read(alertControllerProvider.notifier).alert(
                                recipents: [],
                                callNumber: "+919833944611",
                              ),
                      child: state.isLoading
                          ? const CupertinoActivityIndicator()
                          : Text(
                              "Alert",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 2 / 3,
                  ),
                  children: [
                    HomePageButton(
                      imageUrl: "assets/images/4.png",
                      title: "Safety",
                      tag: "safety",
                      navigateFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SafetyPage(
                              imageUrl: "assets/images/4.png",
                              tag: "safety",
                            ),
                          ),
                        );
                      },
                    ),
                    HomePageButton(
                      imageUrl: "assets/images/1.png",
                      title: "Menstrual\nCycle",
                      tag: 'menstrual',
                      navigateFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FutureBuilder(
                              future: isActive(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data ?? false) {
                                    return const MenstrualQuestionPage();
                                  } else {
                                    return const MenstrualCyclePage(
                                      imageUrl: "assets/images/1.png",
                                      tag: "menstrual",
                                    );
                                  }
                                } else {
                                  const Scaffold(
                                    body: Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  );
                                }
                                return const MenstrualQuestionPage(
                                    // imageUrl: "assets/images/menstualcycle.png",
                                    // tag: "menstrual",
                                    );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    HomePageButton(
                      imageUrl: "assets/images/2.png",
                      title: "Community",
                      tag: 'forum',
                      navigateFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForumPage(
                              imageUrl: "assets/images/2.png",
                              tag: "forum",
                            ),
                          ),
                        );
                      },
                    ),
                    HomePageButton(
                      imageUrl: "assets/images/3.png",
                      title: "Habit\nTracker",
                      tag: 'habit',
                      navigateFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HabitPage(
                              imageUrl: "assets/images/3.png",
                              tag: "habit",
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomePageButton extends StatelessWidget {
  const HomePageButton({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.tag,
    required this.navigateFunction,
  });

  final String imageUrl;
  final String title;
  final String tag;
  // ignore: prefer_typing_uninitialized_variables
  final navigateFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateFunction,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Hero(
                  tag: tag,
                  child: Image.asset(
                    imageUrl,
                    height: 125,
                    width: 125,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
