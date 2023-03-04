import 'package:femease/forum/domain/comment_model.dart';
import 'package:femease/forum/repository/forum_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentController extends StateNotifier<AsyncValue<void>> {
  CommentController({
    required this.forumRepository,
  }) : super(const AsyncData<void>(null));
  final ForumRepository forumRepository;

  Future<void> addComment({
    required CommentModel commentModel,
    required String id,
    required String listName,
  }) async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard<void>(
      () => forumRepository.addComment(
        id,
        commentModel,
        listName,
      ),
    );
  }
}

final fitnessCommentControllerProvider =
    StateNotifierProvider.autoDispose<CommentController, AsyncValue<void>>(
  (ref) {
    return CommentController(
      forumRepository: ref.watch(firebaseForumRepositoryProvider),
    );
  },
);
