import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeUserDisplay()) {
    on<HomeUserPressed>((event, emit) => emit(HomeUserDisplay()));

    on<HomeChatPressed>((event, emit) => emit(HomeChatDisplay()));

    on<HomeSettingsPressed>((event, emit) => emit(HomeSettingsDisplay()));
  }
}
