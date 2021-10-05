import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yt_chat/account/data/models/user.dart';
import 'package:yt_chat/conversation/bloc/conversation_bloc.dart';

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
                return Text(state.conversationId);
              } else if (state is ConversationUnavilable) {
                return SizedBox(
                  height: 100,
                  width: 100,
                  child: Column(
                    children: const [
                      Icon(
                        Icons.move_to_inbox,
                        size: 50,
                      ),
                      Text('Say hi first'),
                    ],
                  ),
                );
              }
              return Text(state.runtimeType.toString());
            },
          ),
        ));
  }
}
