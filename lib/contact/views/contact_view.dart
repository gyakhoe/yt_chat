import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yt_chat/account/data/models/user.dart';
import 'package:yt_chat/contact/bloc/contact_bloc.dart';

class ContactView extends StatelessWidget {
  const ContactView({Key? key}) : super(key: key);

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
            return _ContactListBuilder(users: state.users);
          }
          return Text('Undefined state ${state.runtimeType.toString()}');
        },
      ),
    );
  }
}

class _ContactListBuilder extends StatelessWidget {
  final List<UserDetail> users;
  const _ContactListBuilder({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        final user = users.elementAt(index);
        return ListTile(
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
