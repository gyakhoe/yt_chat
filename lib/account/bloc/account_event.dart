part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class AccountVerified extends AccountEvent {
  final String uid;
  const AccountVerified({
    required this.uid,
  });
  @override
  List<Object> get props => [uid];
}

class AccountRegistered extends AccountEvent {
  final UserDetail userDetail;
  const AccountRegistered({
    required this.userDetail,
  });
  @override
  List<Object> get props => [userDetail];
}
