part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class ContactStreamRequested extends ContactEvent {}

class ContactListChanged extends ContactEvent {
  final List<UserDetail> users;
  const ContactListChanged({
    required this.users,
  });
  @override
  List<Object> get props => [users];
}
