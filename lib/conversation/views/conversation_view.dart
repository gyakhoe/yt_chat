import 'package:flutter/material.dart';
import 'package:yt_chat/conversation/views/conversation_messages_view.dart';

import 'package:yt_chat/conversation/views/conversation_textfield_view.dart';

class ConversationView extends StatelessWidget {
  final String? covnersationId;
  const ConversationView({
    Key? key,
    this.covnersationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.amber,
        child: ListView(
          children: [
            Expanded(
                child: Container(
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) *
                  0.8,
              color: Colors.pink,
              child: const ConversationMessageView(),
            )),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1 -
                    MediaQuery.of(context).padding.top,
                color: Colors.yellow,
                child: const ConversationTextfieldView(),
              ),
            ),
          ],
        ));
  }
}
