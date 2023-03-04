import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:femease/safety/domain/safety_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class SafetyRepository {
  Future<SafetyModel> getSafetyList();

  Future<void> addSafetyList(SafetyModel safetyModel);
}

class FirebaseSafetyRepository implements SafetyRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<SafetyModel> getSafetyList() async {
    final uid = _firebaseAuth.currentUser?.uid;
    final safetyList = _firebaseFirestore.collection('safety').doc(uid);
    return SafetyModel.fromDocumentSnapshot(
      await safetyList.get(),
    );
  }

  @override
  Future<void> addSafetyList(SafetyModel safetyModel) async {
    final uid = _firebaseAuth.currentUser?.uid;
    await _firebaseFirestore
        .collection('safety')
        .doc(uid)
        .set(safetyModel.toMap());
  }
}

final firebaseSafetyRepositoryProvider = Provider<SafetyRepository>((ref) {
  return FirebaseSafetyRepository();
});

final safetyListProvider = FutureProvider<SafetyModel>((ref) async {
  return ref.watch(firebaseSafetyRepositoryProvider).getSafetyList();
});
