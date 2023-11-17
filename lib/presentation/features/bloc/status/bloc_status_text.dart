import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_status_text_event.dart';
import 'bloc_status_text_state.dart';
class BlocStatusText extends Bloc<StatusTextEvent, StatusTextState> {
  BlocStatusText(StatusTextState initialState)
      : super(initialState) {
    on<ChangeStatus>((event, emit) {
      emit(StatusTextState(
        statusText: event.newStatus,
        userLogged: state.userLogged,
        statusOnline: state.statusOnline,
      ));
    });

    on<ChangeStatusOnline>((event, emit) {
      emit(StatusTextState(
        statusText: state.statusText,
        userLogged: state.userLogged,
        statusOnline: event.newStatusOnline,
      ));
    });

    on<ChangeUserLogged>((event, emit) {
      emit(StatusTextState(
        statusText: state.statusText,
        userLogged: event.newUserLogged,
        statusOnline: state.statusOnline,
      ));
    });
  }

  void changeStatus(String newStatus) =>
      add(ChangeStatus(newStatus));
  void changeStatusOnline(bool newStatusOnline) =>
      add(ChangeStatusOnline(newStatusOnline));
  void changeUserLogged(bool newUserLogged) =>
      add(ChangeUserLogged(newUserLogged));
}