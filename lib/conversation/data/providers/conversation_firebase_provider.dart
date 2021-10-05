import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yt_chat/utilities/app_keys.dart';
import 'package:yt_chat/utilities/firebase_keys.dart';

class ConversationFirebaseProvider {
  final FirebaseFirestore firestore;

  ConversationFirebaseProvider({
    required this.firestore,
  });

  Future<String> getConversationId(
      {required String senderId, required String recieverId}) async {
    final members = <String>[senderId, recieverId];

    final conversationIdSnap = await firestore
        .collection(FirebaseKeys.ytChat)
        .doc(FirebaseKeys.chat)
        .collection(FirebaseKeys.conversations)
        .where(FirebaseKeys.members,
            whereIn: [members, members.reversed.toList()]).get();

    return conversationIdSnap.docs.isNotEmpty
        ? conversationIdSnap.docs.first.id
        : Appkeys.unavailable;
  }
}
