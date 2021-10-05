part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class ConversationOpenned extends ConversationEvent {
  final String senderUid;
  final String receiverUid;

  const ConversationOpenned({
    required this.senderUid,
    required this.receiverUid,
  });

  @override
  List<Object> get props => [senderUid, receiverUid];
}
