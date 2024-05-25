import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../core/services/authentication_service.dart';

class BlocSplashScreen extends Bloc<SplashScreenEvent, SplashScreenState> {
  final AuthenticationService authenticationService;

  BlocSplashScreen(this.authenticationService)
      : super(SplashScreenInitialState(" ")) {
    on<CheckSplashScreenValidations>(_checkSplashScreenValidations);
  }

  void triggerValidations()=> add(CheckSplashScreenValidations());



  Future<void> _checkSplashScreenValidations(CheckSplashScreenValidations event,
      Emitter<SplashScreenState> emit) async {
    String unknownError = "Error inesperado";
    try {

      await _validateUserLogged(emit);
      await _validateInternet(emit);
      await _validateServer(emit);
    } catch (e) {
      emit(SplashScreenErrorState("$unknownError: $e"));
    }
  }

  Future<void> _validateUserLogged(Emitter<SplashScreenState> emit) async {
    final traductor = translation(authenticationService.context)!;
    String searchingUser = traductor.searching_verification;
    String userLogged = traductor.welcome;
    String userNotLogged = traductor.redirecting;
    emit(SplashScreenLoadingState(searchingUser));
    await Future.delayed(const Duration(milliseconds: 200));
    bool isLogged = await authenticationService.checkUserLogged();
    if(isLogged){
      emit(SplashScreenUserLoggedState(userLogged));
    }else{
      emit(SplashScreenUserNotLoggedState(userNotLogged));
    }
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> _validateInternet(Emitter<SplashScreenState> emit) async {
    final traductor = translation(authenticationService.context)!;
    String searchingInternet = traductor.searching_network;
    String internetAvailable = traductor.network_connection_successful;
    String internetNotAvailable = traductor.network_error;

    emit(SplashScreenLoadingState(searchingInternet));
    await Future.delayed(const Duration(milliseconds: 200));
    await authenticationService.checkInternet()
        ? emit(SplashScreenLoadingState(internetAvailable))
        : emit(SplashScreenErrorState(internetNotAvailable));
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> _validateServer(Emitter<SplashScreenState> emit) async {
    final traductor = translation(authenticationService.context)!;
    String searchingServer = traductor.searching_server;
    String serverAvailable = traductor.server_connection_successful;
    String serverNotAvailable = traductor.server_error;
    emit(SplashScreenLoadingState(searchingServer));
    await Future.delayed(const Duration(milliseconds: 200));
    await authenticationService.checkServer()
        ? emit(SplashScreenLoadingState(serverAvailable))
        : emit(SplashScreenErrorState(serverNotAvailable));
    await Future.delayed(const Duration(milliseconds: 200));
  }

}

class SplashScreenEvent {
}

class CheckSplashScreenValidations extends SplashScreenEvent {}

class SplashScreenState {
  String message;
  SplashScreenState(this.message);
}

class SplashScreenInitialState extends SplashScreenState {
  SplashScreenInitialState(super.message);
}

class SplashScreenLoadingState extends SplashScreenState {
  SplashScreenLoadingState(super.message);
}

class SplashScreenErrorState extends SplashScreenState {
  SplashScreenErrorState(super.message);
}

class SplashScreenUserLoggedState extends SplashScreenState {
  SplashScreenUserLoggedState(super.message);
}

class SplashScreenUserNotLoggedState extends SplashScreenState {
  SplashScreenUserNotLoggedState(super.message);
}
