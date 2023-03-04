import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final DateTime dateOfBirth;
  final String bloodGroup;
  final String healthConditions;
  final String allergies;
  final String foodRestrictions;
  final bool notifications;

  UserModel(
    this.id,
    this.name,
    this.dateOfBirth,
    this.bloodGroup,
    this.healthConditions,
    this.allergies,
    this.foodRestrictions,
    this.notifications,
  );

  UserModel copyWith({
    String? id,
    String? name,
    DateTime? dateOfBirth,
    String? bloodGroup,
    String? healthConditions,
    String? allergies,
    String? foodRestrictions,
    bool? notifications,
  }) {
    return UserModel(
      id ?? this.id,
      name ?? this.name,
      dateOfBirth ?? this.dateOfBirth,
      bloodGroup ?? this.bloodGroup,
      healthConditions ?? this.healthConditions,
      allergies ?? this.allergies,
      foodRestrictions ?? this.foodRestrictions,
      notifications ?? this.notifications,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dateOfBirth': dateOfBirth.millisecondsSinceEpoch,
      'bloodGroup': bloodGroup,
      'healthConditions': healthConditions,
      'allergies': allergies,
      'foodRestrictions': foodRestrictions,
      'notifications': notifications,
    };
  }

  factory UserModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot,
  ) {
    final Map<String, dynamic> data = documentSnapshot.data()!;
    return UserModel(
      documentSnapshot.id,
      data['name'] as String,
      DateTime.fromMillisecondsSinceEpoch(data['dateOfBirth'] as int),
      data['bloodGroup'] as String,
      data['healthConditions'] as String,
      data['allergies'] as String,
      data['foodRestrictions'] as String,
      data['notifications'] as bool,
    );
  }
}
