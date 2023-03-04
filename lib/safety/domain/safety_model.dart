import 'package:cloud_firestore/cloud_firestore.dart';

class SafetyModel {
  String familyPhoneNumber;
  String spousePhoneNumber;
  String doctorPhoneNumber;
  String policePhoneNumber;

  SafetyModel({
    required this.familyPhoneNumber,
    required this.spousePhoneNumber,
    required this.doctorPhoneNumber,
    required this.policePhoneNumber,
  });

  SafetyModel copyWith({
    String? familyPhoneNumber,
    String? spousePhoneNumber,
    String? doctorPhoneNumber,
    String? policePhoneNumber,
  }) {
    return SafetyModel(
      familyPhoneNumber: familyPhoneNumber ?? this.familyPhoneNumber,
      spousePhoneNumber: spousePhoneNumber ?? this.spousePhoneNumber,
      doctorPhoneNumber: doctorPhoneNumber ?? this.doctorPhoneNumber,
      policePhoneNumber: policePhoneNumber ?? this.policePhoneNumber,
    );
  }

  factory SafetyModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot,
  ) {
    return SafetyModel(
      familyPhoneNumber: documentSnapshot.data()!['familyPhoneNumber'],
      spousePhoneNumber: documentSnapshot.data()!['spousePhoneNumber'],
      doctorPhoneNumber: documentSnapshot.data()!['doctorPhoneNumber'],
      policePhoneNumber: documentSnapshot.data()!['policePhoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'familyPhoneNumber': familyPhoneNumber,
      'spousePhoneNumber': spousePhoneNumber,
      'doctorPhoneNumber': doctorPhoneNumber,
      'policePhoneNumber': policePhoneNumber,
    };
  }
}
