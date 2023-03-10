import 'package:femease/authentication/presentation/controllers/sign_in_controller.dart';
import 'package:femease/authentication/presentation/pages/sign_up_page.dart';
import 'package:femease/home/presentation/home_page.dart';
import 'package:femease/onboarding/presentation/pages/onboarding.dart';
import 'package:femease/user/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:validators/validators.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<void> state = ref.watch(signInControllerProvider);
    ref.listen<AsyncValue<void>>(
      signInControllerProvider,
      (_, state) {
        if (state.hasError) {
          if (state.error is FirebaseAuthException) {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text("Error"),
                content: Text(
                  (state.error as FirebaseAuthException).message ??
                      "An error occurred.",
                ),
                actions: [
                  CupertinoDialogAction(
                    child: const Text("OK"),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            );
          } else {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text("Error"),
                content: const Text("An error occurred."),
                actions: [
                  CupertinoDialogAction(
                    child: const Text("OK"),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            );
          }
        } else if (!state.isLoading && state.hasValue) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FutureBuilder(
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
      },
    );
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Hero(
                tag: "topbar",
                child: Image.asset(
                  "assets/images/signin.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 50,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logotext.png",
                    height: 30,
                  ),
                  Text(
                    "Making Womanhood Easy...",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 7,
              top: MediaQuery.of(context).size.height * 0.2,
              child: Hero(
                tag: "logo",
                child: Image.asset("assets/images/logoonwhite.png"),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              } else if (!isEmail(value)) {
                                return "Please enter a valid email";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              } else if (value.length < 6) {
                                return "Password must be at least 6 characters long";
                              } else {
                                return null;
                              }
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Hero(
                            tag: "signButton",
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 60,
                                    child: FilledButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                          Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ),
                                      ),
                                      onPressed: state.isLoading
                                          ? null
                                          : () => ref
                                              .read(signInControllerProvider
                                                  .notifier)
                                              .signInWithGoogle(),
                                      label: state.isLoading
                                          ? const CupertinoActivityIndicator()
                                          : const Text("Google"),
                                      icon: const FaIcon(
                                        FontAwesomeIcons.google,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 60,
                                    child: FilledButton(
                                      onPressed: state.isLoading
                                          ? null
                                          : () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                ref
                                                    .read(
                                                        signInControllerProvider
                                                            .notifier)
                                                    .signIn(
                                                      email:
                                                          _emailController.text,
                                                      password:
                                                          _passwordController
                                                              .text,
                                                    );
                                              }
                                            },
                                      child: state.isLoading
                                          ? const CupertinoActivityIndicator()
                                          : const Text("Sign In"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: state.isLoading
                                    ? null
                                    : () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpPage(),
                                          ),
                                        );
                                      },
                                child: const Text("Create one"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
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
