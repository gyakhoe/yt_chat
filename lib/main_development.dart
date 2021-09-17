// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'package:yt_chat/app/app.dart';
import 'package:yt_chat/app/app_bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        log('No login user found. Login via anonymously.');
        await FirebaseAuth.instance.signInAnonymously();
      }
      runApp(const App());
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
