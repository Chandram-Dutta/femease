import 'package:femease/authentication/presentation/pages/sign_in_page.dart';
import 'package:femease/authentication/repository/auth_repository.dart';
import 'package:femease/main.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'FemEase',
      theme: FlexThemeData.light(
        scheme: FlexScheme.sakura,
        useMaterial3: true,
        fontFamily: 'Signika Negative',
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.sakura,
        useMaterial3: true,
        fontFamily: 'Signika Negative',
      ),
      home: ref.watch(firebaseAuthRepositoryProvider).currentUser?.uid == null
          ? const SignInPage()
          : const HomePage(),
    );
  }
}
