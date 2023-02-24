import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardAdminController extends GetxController {
  //TODO: Implement DashboardHRController

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // var isPasswordHidden = true.obs;

  Stream<DocumentSnapshot<Object?>> getUserDoc() async* {
    String uid = auth.currentUser!.uid;
    DocumentReference user = firestore.collection("Users").doc(uid);
    yield* user.snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>
      streamTodayPresenceUser() async* {
    String uid = auth.currentUser!.uid;
    String todayID =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");

    yield* firestore
        .collection("Users")
        .doc(uid)
        .collection("Presence")
        .doc(todayID)
        .snapshots();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
