import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/repository/auth_repository.dart';

class FirebaseHabitRepository {
  final _userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> addMood({
    required int moodNo,
    required String userId,
    required String date,
  }) async {
    return _userCollection.doc(userId).collection('mood').doc(date).set({
      'moodNo': moodNo,
      'date': date,
    });
  }

  Future<int> getMood({
    required String userId,
    required String date,
  }) async {
    final doc =
        await _userCollection.doc(userId).collection('mood').doc(date).get();
    return doc.data()?['moodNo'] as int;
  }

  Future<bool> isMoodPresent({
    required String userId,
    required String date,
  }) async {
    final doc =
        await _userCollection.doc(userId).collection('mood').doc(date).get();
    return doc.exists;
  }

  Future<Map<int, int>> getMoodList({
    required String userId,
    required String date,
  }) async {
    final doc = _userCollection.doc(userId).collection('mood').orderBy('date');
    final snapshot = await doc.get();
    var list = snapshot.docs.map((e) => e.data()['moodNo'] as int).toList();
    Map<int, int> map = {};
    if (list.length > 7) {
      list = list.sublist(list.length - 7);
    } else if (list.length < 7) {
      final diff = 7 - list.length;
      for (var i = 0; i < diff; i++) {
        list.insert(0, 0);
      }
    }
    map = {
      0: list[0],
      1: list[1],
      2: list[2],
      3: list[3],
      4: list[4],
      5: list[5],
      6: list[6],
    };
    return map;
  }
}

final firebaseHabitRepositoryProvider =
    Provider<FirebaseHabitRepository>((ref) {
  return FirebaseHabitRepository();
});

final isHabitPresentProvider = FutureProvider<bool>((ref) async {
  final uid = ref.watch(firebaseAuthRepositoryProvider).currentUser?.uid;
  final date = DateTime.now().toIso8601String().substring(0, 10);
  return ref
      .watch(firebaseHabitRepositoryProvider)
      .isMoodPresent(userId: uid!, date: date);
});

final getMoodPresentProvider = FutureProvider<int>((ref) async {
  final uid = ref.watch(firebaseAuthRepositoryProvider).currentUser?.uid;
  final date = DateTime.now().toIso8601String().substring(0, 10);
  return ref
      .watch(firebaseHabitRepositoryProvider)
      .getMood(userId: uid!, date: date);
});

final getMoodLisrProvider = FutureProvider<Map<int, int>>((ref) async {
  final uid = ref.watch(firebaseAuthRepositoryProvider).currentUser?.uid;
  final date = DateTime.now().toIso8601String().substring(0, 10);
  return ref
      .watch(firebaseHabitRepositoryProvider)
      .getMoodList(userId: uid!, date: date);
});
