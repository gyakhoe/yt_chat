part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccessful extends AuthenticationState {
  final String uid;
  const AuthenticationSuccessful({
    required this.uid,
  });
  @override
  List<Object> get props => [uid];
}

class AuthenticationFailure extends AuthenticationState {
  final String message;
  const AuthenticationFailure({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class AuthenticationInprogress extends AuthenticationState {}
