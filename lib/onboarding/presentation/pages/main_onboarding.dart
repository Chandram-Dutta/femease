import 'package:femease/authentication/presentation/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

class MainOnboarding extends StatelessWidget {
  const MainOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Hero(
                tag: "topbar",
                child: Image.asset(
                  "assets/images/signintop.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  Image.asset("assets/images/logotext.png"),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Making Womanhood Easy...",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 7,
              top: MediaQuery.of(context).size.height * 0.6,
              child: Hero(
                tag: "logo",
                child: Image.asset("assets/images/logoonwhite.png"),
              ),
            ),
            Positioned(
              bottom: 50,
              child: Row(
                children: [
                  Text(
                    "Let's get started!",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignInPage();
                          },
                        ),
                      );
                    },
                    child: const Icon(Icons.play_arrow),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
