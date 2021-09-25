import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yt_chat/utilities/firebase_keys.dart';

class ContactFirebaseProvider {
  final FirebaseFirestore firestore;

  ContactFirebaseProvider({
    required this.firestore,
  });

  Stream<List<Map<String, String>>> getContactStream() {
    return firestore
        .collection(FirebaseKeys.ytChat)
        .doc(FirebaseKeys.users)
        .collection(FirebaseKeys.registeredUser)
        .snapshots()
        .map(
          (contactQuerySnap) => contactQuerySnap.docs.map((e) {
            final data = e.data();
            return <String, String>{
              FirebaseKeys.uid: data[FirebaseKeys.uid]?.toString() ?? '',
              FirebaseKeys.username:
                  data[FirebaseKeys.username]?.toString() ?? '',
            };
          }).toList(),
        );
  }
}
