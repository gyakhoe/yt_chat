import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_chat/authentication/authentication.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context)
            .add(AuthenticationRequested());
      },
      child: const Text('Click to login'),
    );
  }
}
