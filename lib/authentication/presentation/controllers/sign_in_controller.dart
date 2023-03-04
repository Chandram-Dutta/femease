import 'package:femease/authentication/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInController extends StateNotifier<AsyncValue<void>> {
  SignInController({
    required this.authRepository,
  }) : super(const AsyncData<void>(null));
  final AuthRepository authRepository;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard<void>(
      () => authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard<void>(
      () => authRepository.signInWithGoogle(),
    );
  }
}

final signInControllerProvider =
    StateNotifierProvider.autoDispose<SignInController, AsyncValue<void>>(
  (ref) {
    return SignInController(
      authRepository: ref.watch(firebaseAuthRepositoryProvider),
    );
  },
);
