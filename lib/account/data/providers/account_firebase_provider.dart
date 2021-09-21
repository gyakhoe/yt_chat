import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yt_chat/utilities/firebase_keys.dart';

class AccountFirebaseProvider {
  final FirebaseFirestore firestore;

  AccountFirebaseProvider({
    required this.firestore,
  });

  Future<bool> isRegistered({required String uid}) async {
    final userCollectionQuerySnap =
        await firestore.collection('yt_chat').doc().collection('user').get();
    final documents = userCollectionQuerySnap.docs;
    for (final element in documents) {
      return element.id == uid;
    }
    return false;
  }

  Future<void> addUser({
    required String uid,
    required Map<String, String> userDetailMap,
  }) async {
    await firestore
        .collection(FirebaseKeys.appCollections)
        .doc()
        .collection(FirebaseKeys.usersCollection)
        .doc(uid)
        .set(userDetailMap);
  }

  Future<bool> isUserNameAvailable({required String username}) async {
    final usernameQuerySnap = await firestore
        .collection(FirebaseKeys.appCollections)
        .doc()
        .collection(FirebaseKeys.usersCollection)
        .where(FirebaseKeys.usernameField, isEqualTo: username)
        .get();
    for (final element in usernameQuerySnap.docs) {
      log(element.id);
    }
    return usernameQuerySnap.docs.isEmpty;
  }
}
