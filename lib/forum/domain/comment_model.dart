import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String comment;
  final String userId;
  final DateTime commentedAt;

  CommentModel({
    required this.comment,
    required this.userId,
    required this.commentedAt,
  });

  CommentModel copyWith({
    String? comment,
    String? userId,
    DateTime? commentedAt,
  }) {
    return CommentModel(
      comment: comment ?? this.comment,
      userId: userId ?? this.userId,
      commentedAt: commentedAt ?? this.commentedAt,
    );
  }

  factory CommentModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot,
  ) {
    return CommentModel(
      comment: documentSnapshot.data()!['comment'],
      userId: documentSnapshot.data()!['userId'],
      commentedAt: documentSnapshot.data()!['commentedAt'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'userId': userId,
      'commentedAt': commentedAt,
    };
  }
}
