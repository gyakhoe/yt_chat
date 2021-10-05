import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:yt_chat/conversation/data/repositories/conversation_repository.dart';
import 'package:yt_chat/utilities/app_keys.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ConversationRepository conversationRepository;
  ConversationBloc({
    required this.conversationRepository,
  }) : super(ConversationInitial()) {
    on<ConversationOpenned>((event, emit) async {
      try {
        emit(ConversationOpenInprogress());
        final conversationId = await conversationRepository.getConversationId(
          loginId: event.senderUid,
          recieverId: event.receiverUid,
        );
        if (conversationId == Appkeys.unavailable) {
          emit(ConversationUnavilable());
        } else {
          emit(ConversationOpenSuccessful(conversationId: conversationId));
        }
      } catch (e) {
        log('Error occured while fetching conversation id ${e.toString()}');
        emit(const ConversationOpenFailure(
            message: 'Unalbe to open Conversation'));
      }
    });
  }
}
