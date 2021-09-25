import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_chat/account/bloc/account_bloc.dart';
import 'package:yt_chat/account/data/models/user.dart';
import 'package:yt_chat/authentication/authentication.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verificationState = context.read<AccountBloc>().state;
    var userDetail = const UserDetail(uid: '', username: '');
    if (verificationState is AccountRegistrationSuccess) {
      userDetail = verificationState.userDetail;
    } else if (verificationState is AccountVerificationSuccess) {
      userDetail = verificationState.userDetail;
    }

    return Center(
        child: Column(
      children: [
        Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Welcome ${userDetail.username}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))),
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: MaterialButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(AuthenticationRemoved());
                },
                color: Theme.of(context).primaryColor,
                child: const Text(
                  'Click to logout',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
