import 'package:flutter/material.dart';

class ConversationTextfieldView extends StatefulWidget {
  const ConversationTextfieldView({Key? key}) : super(key: key);

  @override
  _ConversationTextfieldViewState createState() =>
      _ConversationTextfieldViewState();
}

class _ConversationTextfieldViewState extends State<ConversationTextfieldView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: TextField(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {},
            ),
          ))
        ],
      ),
    );
  }
}
