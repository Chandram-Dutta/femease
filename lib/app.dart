import 'package:femease/authentication/presentation/pages/sign_in_page.dart';
import 'package:femease/authentication/repository/auth_repository.dart';
import 'package:femease/main.dart';
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
      theme: FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xff581026),
          primaryContainer: Color(0xfffde0e2),
          secondary: Color(0xff8d0b46),
          secondaryContainer: Color(0xffffffff),
          tertiary: Color(0xffc21261),
          tertiaryContainer: Color(0xfffde0e2),
          appBarColor: Color(0xffffffff),
          error: Color(0xffb00020),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        useMaterial3ErrorColors: true,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        fontFamily: 'Signika Negative',

        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xff581026),
          primaryContainer: Color(0xfffde0e2),
          secondary: Color(0xff8d0b46),
          secondaryContainer: Color(0xffffffff),
          tertiary: Color(0xffc21261),
          tertiaryContainer: Color(0xfffde0e2),
          appBarColor: Color(0xffffffff),
          error: Color(0xffb00020),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        useMaterial3ErrorColors: true,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        fontFamily: 'Signika Negative',
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
