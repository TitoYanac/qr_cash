import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_save_scan/domain/constants/language_constants.dart';

import '../../../core/services/authentication_service.dart';

class BlocRecovery extends Bloc<RecoveryEvent, RecoveryState> {
  final AuthenticationService authenticationService;
  BlocRecovery(this.authenticationService, String initialMessage)
      : super(RecoveryInitialState(initialMessage, "")) {
    on<RecoverySendOtpEvent>((event, emit) async {
      if (state is RecoveryInitialState) {
        String loadingMessage =
            translation(authenticationService.context)!.wait;
        String successMessage =
            translation(authenticationService.context)!.redirecting;
        String errorMessage =
            translation(authenticationService.context)!.something_went_wrong;
        emit(RecoveryLoadingState(loadingMessage,event.phone));
        bool isSuccess = await authenticationService.requestOtpPassForgotService(
            event.flujo, event.phone, event.isChecked);
        if (isSuccess) {
          emit(RecoverySuccessState(successMessage,event.phone));
        } else {
          emit(RecoveryFailedState(errorMessage, event.phone));
        }
        await Future.delayed(const Duration(seconds: 2));
        emit(RecoveryInitialState(initialMessage, event.phone));
      }
    });
    on<RecoveryValidateOtpEvent>((event, emit) async {
      if (state is RecoveryInitialState) {
        String phone = state.phone;
        String loadingMessage =
            translation(authenticationService.context)!.wait;
        String successMessage =
            translation(authenticationService.context)!.redirecting;
        String errorMessage =
            translation(authenticationService.context)!.something_went_wrong;
        emit(RecoveryLoadingState(loadingMessage,phone));
        bool isSuccess = await authenticationService.validateCodeOtp(
            event.flujo,
            event.inputCodeOtp,
            event.isCheckBoxChecked);
        if (isSuccess) {
          emit(RecoverySuccessState(successMessage,phone));
        } else {
          emit(RecoveryFailedState(errorMessage, phone));
        }
        await Future.delayed(const Duration(seconds: 2));
        emit(RecoveryInitialState(initialMessage, phone));
      }
    });
    on<RecoveryFinishEvent>((event, emit) async {
      if (state is RecoveryInitialState) {
        String phone = state.phone;
        String loadingMessage =
            translation(authenticationService.context)!.wait;
        String successMessage =
            translation(authenticationService.context)!.redirecting;
        String errorMessage =
            translation(authenticationService.context)!.something_went_wrong;
        emit(RecoveryLoadingState(loadingMessage,phone));
        bool isSuccess = await authenticationService.changePassword(
            event.phoneNumber, event.password, event.confirmPassword);
        if (isSuccess) {
          emit(RecoverySuccessState(successMessage,phone));
        } else {
          emit(RecoveryFailedState(errorMessage, phone));
        }
        await Future.delayed(const Duration(seconds: 2));
        emit(RecoveryInitialState(initialMessage, phone));
      }
    });
  }

  void sendOtp(String flujo, String phone, bool isChecked) =>
      add(RecoverySendOtpEvent(flujo: flujo, phone: phone, isChecked: isChecked));
  void validateOtp(String flujo, String inputCodeOtp, bool isCheckBoxChecked, String phone) =>
      add(RecoveryValidateOtpEvent(
          flujo: flujo,
          inputCodeOtp: inputCodeOtp,
          isCheckBoxChecked: isCheckBoxChecked,
          phone: phone));
  void finish(String phoneNumber, String password, String confirmPassword) =>
      add(RecoveryFinishEvent(
          phoneNumber: phoneNumber,
          password: password,
          confirmPassword: confirmPassword));
}

class RecoveryEvent {}

class RecoverySendOtpEvent extends RecoveryEvent {
  String flujo;
  String phone;
  bool isChecked;
  RecoverySendOtpEvent(
      {required this.flujo, required this.phone, required this.isChecked});
}

class RecoveryValidateOtpEvent extends RecoveryEvent {
  String flujo;
  String inputCodeOtp;
  bool isCheckBoxChecked;
  String phone;
  RecoveryValidateOtpEvent(
      {required this.flujo,
        required this.inputCodeOtp,
        required this.isCheckBoxChecked, required this.phone});
}

class RecoveryFinishEvent extends RecoveryEvent {
  String phoneNumber;
  String password;
  String confirmPassword;
  RecoveryFinishEvent(
      {required this.phoneNumber,
        required this.password,
        required this.confirmPassword});
}

class RecoveryState {
  String textButton;
  String phone;
  RecoveryState(this.textButton,this.phone);
}

class RecoveryInitialState extends RecoveryState {
  RecoveryInitialState(super.textButton, super.phone);
}

class RecoveryLoadingState extends RecoveryState {
  RecoveryLoadingState(super.textButton, super.phone);
}

class RecoverySuccessState extends RecoveryState {
  RecoverySuccessState(super.textButton, super.phone);
}

class RecoveryFailedState extends RecoveryState {
  RecoveryFailedState(super.textButton, super.phone);
}

class RecoveryNoInternetState extends RecoveryState {
  RecoveryNoInternetState(super.textButton, super.phone);
}

class RecoveryDisabledState extends RecoveryState {
  RecoveryDisabledState(super.textButton, super.phone);
}
