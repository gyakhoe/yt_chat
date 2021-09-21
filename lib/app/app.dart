// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yt_chat/account/bloc/account_bloc.dart';
import 'package:yt_chat/account/data/providers/account_firebase_provider.dart';
import 'package:yt_chat/account/data/repositories/account_repository.dart';
import 'package:yt_chat/authentication/authentication.dart';

import 'package:yt_chat/home/home.dart';
import 'package:yt_chat/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF13B9FF),
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthenticationBloc(
                authenticationRepository: AuthenticationRepository(
                    authenticationFirebaseProvider:
                        AuthenticationFirebaseProvider(
                  firebaseAuth: FirebaseAuth.instance,
                )),
              ),
            ),
            BlocProvider(
              create: (context) => AccountBloc(
                  accountRepository: AccountRepository(
                      accountFirebaseProvider: AccountFirebaseProvider(
                firestore: FirebaseFirestore.instance,
              ))),
            ),
          ],
          child: const HomePage(),
        ));
  }
}
