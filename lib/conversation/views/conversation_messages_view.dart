import 'package:flutter/material.dart';

class ConversationMessageView extends StatelessWidget {
  final String? converstionId;
  const ConversationMessageView({
    Key? key,
    this.converstionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: converstionId == null
          ? const Center(child: Text('No messages yet. Say hi.'))
          : const Center(
              child: Text('here we will show messages'),
            ),
    );
  }
}
