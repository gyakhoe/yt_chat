import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_chat/account/views/account_view.dart';
import 'package:yt_chat/authentication/authentication.dart';
import 'package:yt_chat/login/login.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YT Chat'),
      ),
      body: Center(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationInitial) {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationStarted());
              return const CircularProgressIndicator();
            } else if (state is AuthenticationFailure) {
              return const LoginView();
            } else if (state is AuthenticationSuccessful) {
              return const AccountView();
            } else if (state is AuthenticationInprogress) {
              return const CircularProgressIndicator();
            } else {
              log(state.runtimeType.toString());
              return const Icon(Icons.error);
            }
          },
        ),
      ),
    );
  }
}
