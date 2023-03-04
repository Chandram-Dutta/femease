import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepository {
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserCredential> signInWithGoogle();
  Future<void> signOut();
  User? get currentUser;
}

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

final firebaseAuthRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository();
});
