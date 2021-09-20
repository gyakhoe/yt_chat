part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationRequested extends AuthenticationEvent {}

class AuthenticationChanged extends AuthenticationEvent {
  final String uid;
  const AuthenticationChanged({
    required this.uid,
  });
  @override
  List<Object> get props => [uid];
}

class AuthenticationRemoved extends AuthenticationEvent {}
