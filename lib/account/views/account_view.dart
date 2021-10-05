import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_chat/account/bloc/account_bloc.dart';
import 'package:yt_chat/account/data/models/user.dart';
import 'package:yt_chat/account/views/account_registration_view.dart';
import 'package:yt_chat/home/bloc/home_bloc.dart';
import 'package:yt_chat/home/home.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountRegistrationFailure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message.toString(),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AccountInitial) {
          BlocProvider.of<AccountBloc>(context).add(AccountVerified(
              uid: FirebaseAuth.instance.currentUser?.uid.toString() ?? ''));
          return const CircularProgressIndicator();
        } else if (state is AccountRegistrationInprogress) {
          return const CircularProgressIndicator();
        } else if (state is AccountVerificationFailure ||
            state is AccountRegistrationFailure) {
          return AccountRegistrationView();
        } else if (state is AccountVerificationSuccess ||
            state is AccountRegistrationSuccess) {
          var loginUser = const UserDetail(uid: '', username: '');
          if (state is AccountVerificationSuccess) {
            loginUser = state.userDetail;
          } else if (state is AccountRegistrationSuccess) {
            loginUser = state.userDetail;
          }
          return BlocProvider(
            create: (context) => HomeBloc(),
            child: HomeView(
              loginUser: loginUser,
            ),
          );
        } else if (state is AccountVerificationInprogress) {
          return const CircularProgressIndicator();
        }
        return Text(state.runtimeType.toString());
      },
    ));
  }
}
