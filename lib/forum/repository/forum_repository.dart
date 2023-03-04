import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:femease/forum/domain/comment_model.dart';
import 'package:femease/forum/domain/question_model.dart';
import 'package:femease/forum/presentation/pages/fitness/fitness_question_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ForumRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getQuestionList(String listName);

  Stream<QuerySnapshot<Map<String, dynamic>>> getCommentList(
      String commentId, String listname);

  Future<void> addToList(QuestionModel questionModel, String listName);

  Future<void> addComment(
      String commentId, CommentModel comment, String listName);

  Future<int> getCommentCount(String commentId, String listName);
}

class FirebaseForumRepository implements ForumRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<void> addComment(
      String commentId, CommentModel comment, String listName) async {
    await _firebaseFirestore
        .collection(listName)
        .doc(commentId)
        .collection('comments')
        .doc()
        .set(comment.toMap());
  }

  @override
  Future<void> addToList(QuestionModel questionModel, String listName) async {
    await _firebaseFirestore.collection(listName).doc().set(
          questionModel.toMap(),
        );
  }

  @override
  Future<int> getCommentCount(String commentId, String listName) {
    final commentList = _firebaseFirestore
        .collection(listName)
        .doc(commentId)
        .collection('comments');
    return commentList.get().then((value) => value.docs.length);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getCommentList(
      String commentId, String listName) {
    final commentList = _firebaseFirestore
        .collection(listName)
        .doc(commentId)
        .collection('comments');
    return commentList.snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getQuestionList(String listName) {
    final questionList = _firebaseFirestore.collection(listName);
    return questionList.snapshots();
  }
}

final firebaseForumRepositoryProvider =
    Provider<ForumRepository>((ref) => FirebaseForumRepository());

//   @override
//   Stream<QuerySnapshot<Map<String, dynamic>>> getFitnessList() {
//     final fitnessList = _firebaseFirestore.collection('fitness');
//     return fitnessList.snapshots();
//   }

//   @override
//   Future<void> addFitnessList(FitnessModel fitnessModel) async {
//     await _firebaseFirestore.collection('fitness').doc().set(
//           fitnessModel.toMap(),
//         );
//   }

//   @override
//   Future<void> addComment(String commentId, CommentModel comment) async {
//     await _firebaseFirestore
//         .collection('fitness')
//         .doc(commentId)
//         .collection('comments')
//         .doc()
//         .set(comment.toMap());
//   }

//   @override
//   Stream<QuerySnapshot<Map<String, dynamic>>> getCommentList(String commentId) {
//     final commentList = _firebaseFirestore
//         .collection('fitness')
//         .doc(commentId)
//         .collection('comments');
//     return commentList.snapshots();
//   }

//   @override
//   Future<int> getCommentCount(String commentId) {
//     final commentList = _firebaseFirestore
//         .collection('fitness')
//         .doc(commentId)
//         .collection('comments');
//     return commentList.get().then((value) => value.docs.length);
//   }
// }

// final firebaseFitnessRepositoryProvider = Provider<FitnessRepository>((ref) {
//   return FirebaseFitnessRepository();
// });

final forumListProvider =
    StreamProvider.family<QuerySnapshot<Map<String, dynamic>>, String>(
  (ref, listName) {
    return ref.watch(firebaseForumRepositoryProvider).getQuestionList(listName);
  },
);

final commentListProvider =
    StreamProvider.family<QuerySnapshot<Map<String, dynamic>>, String>(
  (ref, listName) {
    return ref.watch(firebaseForumRepositoryProvider).getCommentList(
          ref.watch(testProvider),
          listName,
        );
  },
);

final commentCountProvider = FutureProvider.family<int, String>(
  (ref, listName) {
    return ref.watch(firebaseForumRepositoryProvider).getCommentCount(
          ref.watch(testProvider),
          listName,
        );
  },
);
