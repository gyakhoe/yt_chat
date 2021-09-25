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

      final user = await accountRepository.getUserDetail(uid: event.uid);
      yield user.username.isNotEmpty
          ? AccountVerificationSuccess(userDetail: user)
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
      final username = event.userDetail.username.trim();
      if (username.isEmpty) {
        yield const AccountRegistrationFailure(
          message: 'Username is empty',
        );
      } else {
        final isUsernameAvilable =
            await accountRepository.isUsernameAvailable(username: username);
        if (!isUsernameAvilable) {
          yield const AccountRegistrationFailure(
              message: 'Username is taken. Try another');
        } else {
          await accountRepository.addUser(userDetail: event.userDetail);
          yield AccountRegistrationSuccess(userDetail: event.userDetail);
        }
      }
    } catch (e) {
      log('Unable to register user');
      yield AccountRegistrationFailure(
          message: 'Unable to register user : ${e.toString()}');
    }
  }
}
