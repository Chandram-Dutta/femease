import 'package:femease/safety/domain/safety_model.dart';
import 'package:femease/safety/presentation/controllers/safety_controller.dart';
import 'package:femease/safety/repository/safety_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmergencyContactsPage extends ConsumerStatefulWidget {
  const EmergencyContactsPage({super.key});

  @override
  ConsumerState<EmergencyContactsPage> createState() =>
      _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends ConsumerState<EmergencyContactsPage> {
  final TextEditingController _familyController = TextEditingController();
  final TextEditingController _spouseController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _policeController = TextEditingController();

  @override
  void dispose() {
    _familyController.dispose();
    _spouseController.dispose();
    _doctorController.dispose();
    _policeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<void> state = ref.watch(safetyControllerProvider);
    ref.listen<AsyncValue<void>>(
      safetyControllerProvider,
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
          Navigator.pop(context);
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Emergency Contacts"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: state.isLoading
            ? null
            : () => ref.read(safetyControllerProvider.notifier).save(
                  safetyModel: SafetyModel(
                    familyPhoneNumber: _familyController.text,
                    spousePhoneNumber: _spouseController.text,
                    doctorPhoneNumber: _doctorController.text,
                    policePhoneNumber: _policeController.text,
                  ),
                ),
        child: state.isLoading
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.save),
      ),
      body: ref.watch(safetyListProvider).when(
            data: (safetyData) {
              print("hey");
              _familyController.text = safetyData.familyPhoneNumber;
              _spouseController.text = safetyData.spousePhoneNumber;
              _doctorController.text = safetyData.doctorPhoneNumber;
              _policeController.text = safetyData.policePhoneNumber;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _familyController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: "Family Contact Number",
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _spouseController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: "Spouse Contact Number",
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _doctorController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: "Doctor Contact Number",
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _policeController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: "Police Contact Number",
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (error, stack) {
              print(error);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _familyController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: "Family Contact Number",
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _spouseController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: "Spouse Contact Number",
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _doctorController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: "Doctor Contact Number",
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _policeController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: "Police Contact Number",
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
