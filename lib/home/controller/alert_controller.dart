import 'package:femease/authentication/repository/auth_repository.dart';
import 'package:femease/safety/repository/safety_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlertController extends StateNotifier<AsyncValue<void>> {
  AlertController({
    required this.authRepository,
    required this.safetyRepository,
  }) : super(const AsyncData<void>(null));
  final AuthRepository authRepository;
  final SafetyRepository safetyRepository;

  Future<void> alert({
    required List<String> recipents,
    required String callNumber,
  }) async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard<void>(
      
      () => safetyRepository.sendAlert(
        authRepository.currentUser!.displayName!,
        recipents,
        callNumber,
      ),
    );
  }
}

final alertControllerProvider =
    StateNotifierProvider.autoDispose<AlertController, AsyncValue<void>>(
  (ref) {
    return AlertController(
      authRepository: ref.watch(firebaseAuthRepositoryProvider),
      safetyRepository: ref.watch(firebaseSafetyRepositoryProvider),
    );
  },
);
