import 'package:femease/authentication/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpController extends StateNotifier<AsyncValue<void>> {
  SignUpController({
    required this.authRepository,
  }) : super(const AsyncData<void>(null));
  final AuthRepository authRepository;

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard<void>(
      () => authRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }
}

final signUpControllerProvider =
    StateNotifierProvider.autoDispose<SignUpController, AsyncValue<void>>(
  (ref) {
    return SignUpController(
      authRepository: ref.watch(firebaseAuthRepositoryProvider),
    );
  },
);
