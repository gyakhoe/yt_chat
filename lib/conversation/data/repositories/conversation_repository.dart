import 'package:yt_chat/conversation/data/providers/conversation_firebase_provider.dart';

class ConversationRepository {
  final ConversationFirebaseProvider conversationFirebaseProvider;

  ConversationRepository({
    required this.conversationFirebaseProvider,
  });

  Future<String> getConversationId({
    required String loginId,
    required String recieverId,
  }) async {
    return conversationFirebaseProvider.getConversationId(
      senderId: loginId,
      recieverId: recieverId,
    );
  }
}
