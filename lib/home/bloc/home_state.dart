part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeUserDisplay extends HomeState {}

class HomeChatDisplay extends HomeState {}

class HomeSettingsDisplay extends HomeState {}
