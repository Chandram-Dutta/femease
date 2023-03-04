import 'package:femease/user/domain/user_model.dart';
import 'package:femease/user/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingController extends StateNotifier<AsyncValue<void>> {
  OnboardingController({
    required this.userRepository,
  }) : super(const AsyncData<void>(null));
  final UserRepository userRepository;

  Future<void> addUser({
    required UserModel userModel,
  }) async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard<void>(
      () => userRepository.addUser(userModel),
    );
  }
}

final onboardingControllerProvider =
    StateNotifierProvider.autoDispose<OnboardingController, AsyncValue<void>>(
  (ref) {
    return OnboardingController(
      userRepository: ref.watch(firebaseUserRepositoryProvider),
    );
  },
);
