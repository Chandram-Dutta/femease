import 'package:femease/safety/domain/safety_model.dart';
import 'package:femease/safety/repository/safety_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SafetyController extends StateNotifier<AsyncValue<void>> {
  SafetyController({
    required this.safetyRepository,
  }) : super(const AsyncData<void>(null));
  final SafetyRepository safetyRepository;

  Future<void> save({
    required SafetyModel safetyModel,
  }) async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard<void>(
      () => safetyRepository.addSafetyList(
        safetyModel,
      ),
    );
  }
}

final safetyControllerProvider =
    StateNotifierProvider.autoDispose<SafetyController, AsyncValue<void>>(
  (ref) {
    return SafetyController(
      safetyRepository: ref.watch(firebaseSafetyRepositoryProvider),
    );
  },
);
