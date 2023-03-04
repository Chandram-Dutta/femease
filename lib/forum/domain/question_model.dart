import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  String title;
  String description;
  String askedBy;
  DateTime askedWhen;
  

  QuestionModel({
    required this.title,
    required this.description,
    required this.askedBy,
    required this.askedWhen,
  });

  QuestionModel copyWith({
    String? title,
    String? description,
    String? askedBy,
    DateTime? askedWhen,
  }) {
    return QuestionModel(
      title: title ?? this.title,
      description: description ?? this.description,
      askedBy: askedBy ?? this.askedBy,
      askedWhen: askedWhen ?? this.askedWhen,
    );
  }

  factory QuestionModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot,
  ) {
    return QuestionModel(
      title: documentSnapshot.data()!['title'],
      description: documentSnapshot.data()!['description'],
      askedBy: documentSnapshot.data()!['askedBy'],
      askedWhen: documentSnapshot.data()!['askedWhen'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'askedBy': askedBy,
      'askedWhen': askedWhen,
    };
  }
}
