import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:yt_chat/account/data/models/user.dart';
import 'package:yt_chat/contact/data/repositories/contact_repository.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;

  ContactBloc(
    this.contactRepository,
  ) : super(ContactInitial()) {
    on<ContactStreamRequested>((event, emit) {
      try {
        emit(ContactRequestInprogress());
        contactsStream = contactRepository.getUserStream().listen((users) {
          add(ContactListChanged(users: users));
        });
      } catch (e) {
        log('Error occured while loading contact stream');
        emit(const ContactRequestFailure(message: 'Unable to load contacts'));
      }
    });

    on<ContactListChanged>((event, emit) {
      emit(ContactRequestSuccess(users: event.users));
    });
  }

  StreamSubscription? contactsStream;

  @override
  Future<void> close() {
    contactsStream?.cancel();
    return super.close();
  }
}
