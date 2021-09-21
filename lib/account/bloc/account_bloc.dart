import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yt_chat/account/data/models/user.dart';

import 'package:yt_chat/account/data/repositories/account_repository.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;
  AccountBloc({
    required this.accountRepository,
  }) : super(AccountInitial());

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is AccountVerified) {
      yield* _mapAccountVerifiedToState(event);
    } else if (event is AccountRegistered) {
      yield* _mapAccountRegisteredToState(event);
    }
  }

  Stream<AccountState> _mapAccountVerifiedToState(
      AccountVerified event) async* {
    try {
      yield AccountVerificationInprogress();
      final isRegistered = await accountRepository.isRegistered(uid: event.uid);
      yield isRegistered
          ? AccountVerificationSuccess(uid: event.uid)
          : const AccountVerificationFailure(
              message: 'user not yet registered');
    } catch (e) {
      log('Error occured while verfiying account : ${e.toString()}');
      yield const AccountVerificationFailure(
          message: 'Unable to verfy account');
    }
  }

  Stream<AccountState> _mapAccountRegisteredToState(
      AccountRegistered event) async* {
    try {
      yield AccountRegistrationInprogress();
      if (event.userDetail.username.isEmpty) {
        yield const AccountRegistrationFailure(
          message: 'Username is empty',
        );
      } else {
        await accountRepository.addUser(userDetail: event.userDetail);
        yield AccountRegistrationSuccess(uid: event.userDetail.uid);
      }
    } catch (e) {
      log('Unable to register user');
      yield AccountRegistrationFailure(
          message: 'Unable to register user : ${e.toString()}');
    }
  }
}
