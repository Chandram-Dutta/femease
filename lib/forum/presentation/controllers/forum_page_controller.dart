import 'package:femease/forum/domain/question_model.dart';
import 'package:femease/forum/repository/forum_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForumListPageController extends StateNotifier<AsyncValue<void>> {
  ForumListPageController({
    required this.forumRepository,
  }) : super(const AsyncData<void>(null));
  final ForumRepository forumRepository;

  Future<void> ask({
    required QuestionModel questionModel,
    required String listName,
  }) async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard<void>(
      () => forumRepository.addToList(
        questionModel,
        listName,
      ),
    );
  }
}

final forumControllerProvider = StateNotifierProvider.autoDispose<
    ForumListPageController, AsyncValue<void>>(
  (ref) {
    return ForumListPageController(
      forumRepository: ref.watch(firebaseForumRepositoryProvider),
    );
  },
);
