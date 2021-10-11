part of 'conversation_bloc.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();

  @override
  List<Object> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationOpenSuccessful extends ConversationState {
  final String conversationId;
  const ConversationOpenSuccessful({
    required this.conversationId,
  });
  @override
  List<Object> get props => [conversationId];
}

class ConversationOpenFailure extends ConversationState {
  final String message;
  const ConversationOpenFailure({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class ConversationUnavilable extends ConversationState {}

class ConversationOpenInprogress extends ConversationState {}
