import 'package:femease/forum/domain/question_model.dart';
import 'package:femease/forum/presentation/pages/fitness/fitness_ask_page.dart';
import 'package:femease/forum/presentation/pages/fitness/fitness_question_page.dart';
import 'package:femease/forum/repository/forum_repository.dart';
import 'package:femease/user/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FitnessPage extends ConsumerWidget {
  const FitnessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitness"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FitnessAskPage(),
          ),
        ),
        label: const Text("Ask"),
        icon: const Icon(Icons.add),
      ),
      body: ref.watch(forumListProvider("fitness")).when(
            data: (data) => ListView.builder(
              itemCount: data.docs.length,
              itemBuilder: (context, index) {
                QuestionModel questionModel =
                    QuestionModel.fromDocumentSnapshot(
                  data.docs[index],
                );
                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FitnessQuestionPage(
                        fitnessQuestion: data.docs[index],
                      ),
                    ),
                  ),
                  title: Text(
                    questionModel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle:
                      ref.watch(getUserProvider(questionModel.askedBy)).when(
                            data: (data) => Text(
                              "Asked by ${data.name} on ${DateFormat.yMMMMd().format(questionModel.askedWhen)}",
                            ),
                            error: (error, stack) => const Text("Error"),
                            loading: () => const CupertinoActivityIndicator(),
                          ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.comment),
                      ref
                          .watch(
                            commentCountProvider(
                              // ignore: provider_parameters
                              [
                                data.docs[index].id,
                                "fitness",
                              ],
                            ),
                          )
                          .when(
                            data: (data) => Text(
                              data.toString(),
                            ),
                            error: (error, stack) => const Text("Error"),
                            loading: () => const CupertinoActivityIndicator(),
                          ),
                    ],
                  ),
                );
              },
            ),
            error: (error, stack) => const Center(
              child: Text("Error"),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
