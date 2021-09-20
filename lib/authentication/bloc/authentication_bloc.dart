import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yt_chat/authentication/authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({
    required this.authenticationRepository,
  }) : super(AuthenticationInitial());

  late final StreamSubscription? authenticationStream;

  @override
  Future<void> close() {
    authenticationStream?.cancel();
    return super.close();
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState(event);
    } else if (event is AuthenticationChanged) {
      yield* _mapAuthenticationChangedToState(event);
    } else if (event is AuthenticationRequested) {
      yield* _mapAuthenticationRequestedToState(event);
    } else if (event is AuthenticationRemoved) {
      yield* _mapAuthenticationRemovedToState(event);
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartedToState(
      AuthenticationStarted event) async* {
    yield AuthenticationInprogress();
    try {
      authenticationStream =
          authenticationRepository.getAuthenticationChanges().listen((uid) {
        add(AuthenticationChanged(uid: uid));
      });
    } catch (e) {
      log('Error occured while checking for authen status : ${e.toString()}');
      yield const AuthenticationFailure(message: 'Error occured during auth');
    }
  }

  Stream<AuthenticationState> _mapAuthenticationChangedToState(
      AuthenticationChanged event) async* {
    yield event.uid.isEmpty
        ? const AuthenticationFailure(message: 'No Login found')
        : AuthenticationSuccessful(uid: event.uid);
  }

  Stream<AuthenticationState> _mapAuthenticationRequestedToState(
      AuthenticationRequested event) async* {
    yield AuthenticationInprogress();
    await authenticationRepository.authenticatedUser();
  }

  Stream<AuthenticationState> _mapAuthenticationRemovedToState(
      AuthenticationRemoved event) async* {
    yield AuthenticationInprogress();
    await authenticationRepository.unauthenticateUser();
  }
}
