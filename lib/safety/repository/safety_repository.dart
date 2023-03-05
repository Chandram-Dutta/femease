import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:femease/safety/domain/safety_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';

abstract class SafetyRepository {
  Future<SafetyModel> getSafetyList();

  Future<void> addSafetyList(SafetyModel safetyModel);

  Future<void> sendAlert(
    String username,
    List<String> recipents,
    String callNumber,
  );
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

  @override
  Future<void> sendAlert(
      String username, List<String> recipents, String callNumber) async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition();
    await sendSMS(
      message:
          "$username has pressed an alert button. ${position.latitude} Latitude ${position.longitude} Longitude} is the location of the user.",
      recipients: recipents,
      sendDirect: true,
    );
    await FlutterPhoneDirectCaller.callNumber(callNumber);
  }
}

final firebaseSafetyRepositoryProvider = Provider<SafetyRepository>((ref) {
  return FirebaseSafetyRepository();
});

final safetyListProvider = FutureProvider<SafetyModel>((ref) async {
  return ref.watch(firebaseSafetyRepositoryProvider).getSafetyList();
});
