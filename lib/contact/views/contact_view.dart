import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yt_chat/account/data/models/user.dart';
import 'package:yt_chat/contact/bloc/contact_bloc.dart';
import 'package:yt_chat/conversation/bloc/conversation_bloc.dart';
import 'package:yt_chat/conversation/conversation.dart';
import 'package:yt_chat/conversation/data/providers/conversation_firebase_provider.dart';
import 'package:yt_chat/conversation/data/repositories/conversation_repository.dart';

class ContactView extends StatelessWidget {
  final UserDetail loginUser;
  const ContactView({
    Key? key,
    required this.loginUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactRequestInprogress || state is ContactInitial) {
            return const CircularProgressIndicator();
          } else if (state is ContactRequestFailure) {
            return const Text('Unable to load contacts');
          } else if (state is ContactRequestSuccess) {
            return _ContactListBuilder(
              users: state.users,
              loginUser: loginUser,
            );
          }
          return Text('Undefined state ${state.runtimeType.toString()}');
        },
      ),
    );
  }
}

class _ContactListBuilder extends StatelessWidget {
  final UserDetail loginUser;
  final List<UserDetail> users;
  const _ContactListBuilder({
    Key? key,
    required this.loginUser,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        final user = users.elementAt(index);
        return ListTile(
          onTap: () => Navigator.of(context).push<ConversationPage>(
            MaterialPageRoute(
              builder: (context) {
                return BlocProvider(
                  create: (context) => ConversationBloc(
                    conversationRepository: ConversationRepository(
                        conversationFirebaseProvider:
                            ConversationFirebaseProvider(
                                firestore: FirebaseFirestore.instance)),
                  ),
                  child: ConversationPage(
                    loginUser: loginUser,
                    reciever: user,
                  ),
                );
              },
            ),
          ),
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(
            user.username,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
