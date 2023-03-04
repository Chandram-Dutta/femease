import 'package:femease/onboarding/presentation/pages/onboarding_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  late final TextEditingController _nameController;
  late DateTime _dateOfBirth;
  String bloodGroup = "A+";
  final bloodGroups = [
    const DropdownMenuItem(
      value: "A+",
      child: Text("A+"),
    ),
    const DropdownMenuItem(
      value: "A-",
      child: Text("A-"),
    ),
    const DropdownMenuItem(
      value: "B+",
      child: Text("B+"),
    ),
    const DropdownMenuItem(
      value: "B-",
      child: Text("B-"),
    ),
    const DropdownMenuItem(
      value: "AB+",
      child: Text("AB+"),
    ),
    const DropdownMenuItem(
      value: "AB-",
      child: Text("AB-"),
    ),
    const DropdownMenuItem(
      value: "O+",
      child: Text("O+"),
    ),
    const DropdownMenuItem(
      value: "O-",
      child: Text("O-"),
    ),
  ];

  @override
  void initState() {
    _nameController = TextEditingController();

    _dateOfBirth = DateTime.now().subtract(
      const Duration(days: 365 * 18),
    );
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text("Blood Group:"),
                        const Spacer(),
                        DropdownButton(
                          hint: const Text("Blood Group"),
                          value: bloodGroup,
                          items: bloodGroups,
                          onChanged: (value) {
                            setState(() {
                              bloodGroup = value as String;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _dateOfBirth,
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 365 * 100),
                        ),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          _dateOfBirth = date;
                        });
                      }
                    },
                    // TODO: AGE DEBATE
                    child: Text(
                      "Date of Birth: ${DateFormat('yyyy-MM-dd').format(_dateOfBirth)}",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OnboardingTwoPage(
                            name: _nameController.text,
                            bloodGroup: bloodGroup,
                            dob: _dateOfBirth,
                          ),
                        ),
                      );
                    },
                    child: const Text("Continue"),
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
