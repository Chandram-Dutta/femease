import 'package:calendar_view/calendar_view.dart';
import 'package:femease/authentication/repository/auth_repository.dart';
import 'package:femease/home/presentation/home_page.dart';
import 'package:femease/onboarding/presentation/pages/main_onboarding.dart';
import 'package:femease/onboarding/presentation/pages/onboarding.dart';
import 'package:femease/theme/color_schemes.g.dart';
import 'package:femease/user/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        title: 'FemEase',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          fontFamily: 'Signika Negative',
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
        ),
        home: ref.watch(firebaseAuthRepositoryProvider).currentUser?.uid == null
            ? const MainOnboarding()
            : FutureBuilder(
                future:
                    ref.watch(firebaseUserRepositoryProvider).isUserPresent(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == true) {
                      return const HomePage();
                    } else {
                      return const OnboardingPage();
                    }
                  } else {
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
      ),
    );
  }
}
