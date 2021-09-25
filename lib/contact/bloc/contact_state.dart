part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactRequestInprogress extends ContactState {}

class ContactRequestFailure extends ContactState {
  final String message;
  const ContactRequestFailure({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class ContactRequestSuccess extends ContactState {
  final List<UserDetail> users;
  const ContactRequestSuccess({
    required this.users,
  });
  @override
  List<Object> get props => [users];
}
