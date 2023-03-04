import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:femease/user/domain/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class UserRepository {
  Future<void> addUser(UserModel user);

  Future<void> updateUser(UserModel user);

  Future<void> deleteUser(UserModel user);

  Future<UserModel> getUser(String id);

  Future<UserModel> getCurrentUser();

  Future<bool> isUserPresent();
}

class FirebaseUserRepository extends UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toJson());
  }

  @override
  Future<void> deleteUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).delete();
  }

  @override
  Future<UserModel> getUser(String id) async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _firestore.collection('users').doc(id).get();
    return UserModel.fromDocumentSnapshot(documentSnapshot);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User is not signed in');
    }
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _firestore.collection('users').doc(user.uid).get();
    return UserModel.fromDocumentSnapshot(documentSnapshot);
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).update(user.toJson());
  }

  @override
  Future<bool> isUserPresent() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Future.value(false);
    }
    return _firestore.collection('users').doc(user.uid).get().then(
          (value) => value.exists,
        );
  }
}

final firebaseUserRepositoryProvider = Provider<UserRepository>((ref) {
  return FirebaseUserRepository();
});
