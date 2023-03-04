import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:femease/authentication/repository/auth_repository.dart';
import 'package:femease/forum/domain/question_model.dart';
import 'package:femease/forum/presentation/controllers/comment_controller.dart';
import 'package:femease/forum/repository/forum_repository.dart';
import 'package:femease/user/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/comment_model.dart';

class FitnessQuestionPage extends ConsumerStatefulWidget {
  const FitnessQuestionPage({
    super.key,
    required this.fitnessQuestion,
  });

  final DocumentSnapshot<Map<String, dynamic>> fitnessQuestion;

  @override
  ConsumerState<FitnessQuestionPage> createState() =>
      _FitnessQuestionPageState();
}

class _FitnessQuestionPageState extends ConsumerState<FitnessQuestionPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final QuestionModel fitnessModel = QuestionModel.fromDocumentSnapshot(
      widget.fitnessQuestion,
    );
    final AsyncValue<void> state = ref.watch(fitnessCommentControllerProvider);
    ref.listen<AsyncValue<void>>(
      fitnessCommentControllerProvider,
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
        title: ref.watch(getUserProvider(fitnessModel.askedBy)).when(
              data: (data) => Text(
                "Asked by ${data.name}",
              ),
              error: (error, stack) => const Text("Error"),
              loading: () => const CupertinoActivityIndicator(),
            ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showCupertinoDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Comment"),
            content: TextField(
              controller: _commentController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: state.isLoading
                    ? null
                    : () => ref
                        .read(fitnessCommentControllerProvider.notifier)
                        .addComment(
                          listName: "fitness",
                          commentModel: CommentModel(
                            comment: _commentController.text,
                            userId: ref
                                .read(firebaseAuthRepositoryProvider)
                                .currentUser!
                                .uid,
                            commentedAt: DateTime.now(),
                          ),
                          id: widget.fitnessQuestion.id,
                        ),
                child: state.isLoading
                    ? const CupertinoActivityIndicator()
                    : const Text("Comment"),
              ),
            ],
          ),
        ),
        label: const Text("Comment"),
        icon: const Icon(
          Icons.comment,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fitnessModel.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Asked on ${DateFormat.yMMMMd().format(fitnessModel.askedWhen)}",
              ),
              const SizedBox(height: 18.0),
              Text(
                fitnessModel.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Divider(),
              // ignore: provider_parameters
              ref
                  .watch(
                    commentListProvider(
                      // ignore: provider_parameters
                      [
                        widget.fitnessQuestion.id,
                        "fitness",
                      ],
                    ),
                  )
                  .when(
                    data: (data) => ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) {
                        CommentModel commentModel =
                            CommentModel.fromDocumentSnapshot(
                          data.docs[index],
                        );
                        return Card(
                          child: ListTile(
                            title: Text(commentModel.comment),
                            subtitle: ref
                                .watch(getUserProvider(commentModel.userId))
                                .when(
                                  data: (data) => Text(
                                    "Commented by ${data.name} on ${DateFormat.yMMMMd().format(commentModel.commentedAt)}",
                                  ),
                                  error: (error, stack) => const Text("Error"),
                                  loading: () =>
                                      const CupertinoActivityIndicator(),
                                ),
                          ),
                        );
                      },
                    ),
                    error: (error, stack) => const Text("Error"),
                    loading: () => const CupertinoActivityIndicator(),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
