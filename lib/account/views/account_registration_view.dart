import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_chat/account/bloc/account_bloc.dart';
import 'package:yt_chat/account/data/models/user.dart';

class AccountRegistrationView extends StatelessWidget {
  AccountRegistrationView({Key? key}) : super(key: key);
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
            flex: 3,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.verified_user_outlined),
                ))),
        Expanded(
            flex: 2,
            child: Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Create username here',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ),
              ),
            )),
        Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.topCenter,
              child: MaterialButton(
                onPressed: () {
                  log('Button is pressed');
                  final username = usernameController.text;
                  final uid = FirebaseAuth.instance.currentUser?.uid;
                  final userdetail = UserDetail(
                    uid: uid.toString(),
                    username: username,
                  );
                  BlocProvider.of<AccountBloc>(context)
                      .add(AccountRegistered(userDetail: userdetail));
                },
                color: Theme.of(context).primaryColor,
                child: const Text(
                  'Register',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            )),
      ],
    );
  }
}
