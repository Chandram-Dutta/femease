import 'package:femease/authentication/presentation/pages/sign_in_page.dart';
import 'package:femease/authentication/repository/auth_repository.dart';
import 'package:femease/home/presentation/home_page.dart';
import 'package:femease/onboarding/presentation/pages/onboarding.dart';
import 'package:femease/user/repository/user_repository.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'FemEase',
      theme: FlexThemeData.dark(
        scheme: FlexScheme.redWine,
        fontFamily: 'Signika Negative',
        useMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.redWine,
        fontFamily: 'Signika Negative',
        useMaterial3: true,
      ),
      home: ref.watch(firebaseAuthRepositoryProvider).currentUser?.uid == null
          ? const SignInPage()
          : FutureBuilder(
              future: ref.watch(firebaseUserRepositoryProvider).isUserPresent(),
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
    );
  }
}
