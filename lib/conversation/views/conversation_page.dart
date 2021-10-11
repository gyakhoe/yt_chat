import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yt_chat/account/data/models/user.dart';
import 'package:yt_chat/conversation/bloc/conversation_bloc.dart';
import 'package:yt_chat/conversation/views/conversation_view.dart';

class ConversationPage extends StatelessWidget {
  final UserDetail reciever;
  final UserDetail loginUser;

  const ConversationPage({
    Key? key,
    required this.reciever,
    required this.loginUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(reciever.username),
        ),
        body: Center(
          child: BlocBuilder<ConversationBloc, ConversationState>(
            builder: (context, state) {
              if (state is ConversationInitial) {
                BlocProvider.of<ConversationBloc>(context).add(
                    ConversationOpenned(
                        senderUid: loginUser.uid, receiverUid: reciever.uid));
                return const CircularProgressIndicator();
              } else if (state is ConversationOpenSuccessful) {
                return ConversationView(
                  covnersationId: state.conversationId,
                );
              } else if (state is ConversationUnavilable) {
                return const ConversationView();
              } else if (state is ConversationOpenInprogress) {
                return const CircularProgressIndicator();
              }
              return Text(state.runtimeType.toString());
            },
          ),
        ));
  }
}
