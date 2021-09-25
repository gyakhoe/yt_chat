part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountVerificationInprogress extends AccountState {}

class AccountVerificationFailure extends AccountState {
  final String message;
  const AccountVerificationFailure({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class AccountVerificationSuccess extends AccountState {
  final UserDetail userDetail;
  const AccountVerificationSuccess({
    required this.userDetail,
  });
  @override
  List<Object> get props => [userDetail];
}

class AccountRegistrationInprogress extends AccountState {}

class AccountRegistrationFailure extends AccountState {
  final String message;
  const AccountRegistrationFailure({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class AccountRegistrationSuccess extends AccountState {
  final UserDetail userDetail;
  const AccountRegistrationSuccess({
    required this.userDetail,
  });
  @override
  List<Object> get props => [userDetail];
}
