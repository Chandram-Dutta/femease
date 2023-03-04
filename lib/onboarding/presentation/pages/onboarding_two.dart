import 'package:femease/main.dart';
import 'package:femease/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:femease/user/domain/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingTwoPage extends ConsumerStatefulWidget {
  const OnboardingTwoPage({
    super.key,
    required this.name,
    required this.dob,
    required this.bloodGroup,
  });

  final String name;
  final DateTime dob;
  final String bloodGroup;

  @override
  ConsumerState<OnboardingTwoPage> createState() => _OnboardingTwoPageState();
}

class _OnboardingTwoPageState extends ConsumerState<OnboardingTwoPage> {
  late final TextEditingController _healthController;
  late final TextEditingController _allergyController;
  late final TextEditingController _foodRestrictionController;
  bool notifications = true;

  @override
  void initState() {
    _healthController = TextEditingController();
    _allergyController = TextEditingController();
    _foodRestrictionController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);
    ref.listen<AsyncValue<void>>(
      onboardingControllerProvider,
      (_, state) {
        if (state.hasError) {
          if (state.error is FirebaseException) {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text("Error"),
                content: Text(
                  (state.error as FirebaseException).message ??
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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false,
          );
        }
      },
    );
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _healthController,
                  decoration: const InputDecoration(
                    labelText: "Describe Pre-existing Health Conditions",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                const SizedBox(
                  height: 18.0,
                ),
                TextField(
                  controller: _allergyController,
                  decoration: const InputDecoration(
                    labelText: "Describe Allegies",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                const SizedBox(
                  height: 18.0,
                ),
                TextField(
                  controller: _foodRestrictionController,
                  decoration: const InputDecoration(
                    labelText: "Describe Food Restrictions",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                const SizedBox(
                  height: 18.0,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Allow Reminders for your menstrual cycle & health-related activities?",
                      ),
                    ),
                    Switch(
                      value: notifications,
                      onChanged: (value) {
                        setState(
                          () {
                            notifications = value;
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: FilledButton(
                    onPressed: state.isLoading
                        ? null
                        : () => ref
                            .read(onboardingControllerProvider.notifier)
                            .addUser(
                              userModel: UserModel(
                                FirebaseAuth.instance.currentUser!.uid,
                                widget.name,
                                widget.dob,
                                widget.bloodGroup,
                                _healthController.text,
                                _allergyController.text,
                                _foodRestrictionController.text,
                                notifications,
                              ),
                            ),
                    child: state.isLoading
                        ? const CupertinoActivityIndicator()
                        : const Text("Continue"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
