import 'package:femease/authentication/repository/auth_repository.dart';
import 'package:femease/forum/domain/question_model.dart';
import 'package:femease/forum/presentation/controllers/forum_page_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MentalAskPage extends ConsumerStatefulWidget {
  const MentalAskPage({super.key});

  @override
  ConsumerState<MentalAskPage> createState() => _MentalAskPageState();
}

class _MentalAskPageState extends ConsumerState<MentalAskPage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _questionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<void> state = ref.watch(forumControllerProvider);
    ref.listen<AsyncValue<void>>(
      forumControllerProvider,
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
        title: const Text("Ask a Mental Health Question"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: state.isLoading
            ? null
            : () => ref.read(forumControllerProvider.notifier).ask(
                  listName: "mental",
                  questionModel: QuestionModel(
                    title: _questionController.text,
                    description: _descriptionController.text,
                    askedBy: ref
                        .watch(firebaseAuthRepositoryProvider)
                        .currentUser!
                        .uid,
                    askedWhen: DateTime.now(),
                  ),
                ),
        child: state.isLoading
            ? const CupertinoActivityIndicator()
            : const Icon(
                Icons.send_rounded,
              ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _questionController,
                decoration: const InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
