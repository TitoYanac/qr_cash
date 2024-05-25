import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_save_scan/domain/constants/language_constants.dart';

import '../../../core/services/authentication_service.dart';

class BlocSignUp extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationService authenticationService;
  BlocSignUp(this.authenticationService, String initialMessage)
      : super(SignUpInitialState(initialMessage,"")) {
    on<SignUpSendOtpEvent>((event, emit) async {
      if (state is SignUpInitialState) {
        String phone = event.phone;
        String loadingMessage =
            translation(authenticationService.context)!.wait;
        String successMessage =
            translation(authenticationService.context)!.redirecting;
        String errorMessage =
            translation(authenticationService.context)!.something_went_wrong;
        emit(SignUpLoadingState(loadingMessage,phone));
        bool isSuccess = await authenticationService.requestOtpService(
            event.flujo, event.phone, event.isChecked);
        if (isSuccess) {
          emit(SignUpSuccessState(successMessage,phone));
        } else {
          emit(SignUpFailedState(errorMessage,phone));
        }
        await Future.delayed(const Duration(seconds: 2));
        emit(SignUpInitialState(initialMessage,phone));
      }
    });
    on<SignUpValidateOtpEvent>((event, emit) async {
      if (state is SignUpInitialState) {
        String phone = state.phone;
        String loadingMessage =
            translation(authenticationService.context)!.wait;
        String successMessage =
            translation(authenticationService.context)!.redirecting;
        String errorMessage =
            translation(authenticationService.context)!.something_went_wrong;
        emit(SignUpLoadingState(loadingMessage,phone));
        bool isSuccess = await authenticationService.validateCodeOtp(
            event.flujo,
            event.inputCodeOtp,
            event.isCheckBoxChecked);
        if (isSuccess) {
          emit(SignUpLoadingState(loadingMessage,phone));
          bool isSuccess = await authenticationService.createUserService(
              event.phone, event.password, event.password);
          if (isSuccess) {
            emit(SignUpSuccessState(successMessage,phone));
          } else {
            emit(SignUpFailedState(errorMessage,phone));
          }
        } else {
          emit(SignUpFailedState(errorMessage,phone));
        }
        await Future.delayed(const Duration(seconds: 2));
        emit(SignUpInitialState(initialMessage,phone));
      }
    });
    on<SignUpFinishEvent>((event, emit) async {
      if (state is SignUpInitialState) {
        String phone = event.phoneNumber;
        String loadingMessage =
            translation(authenticationService.context)!.wait;
        String successMessage =
            translation(authenticationService.context)!.redirecting;
        String errorMessage =
            translation(authenticationService.context)!.something_went_wrong;
        emit(SignUpLoadingState(loadingMessage,phone));
        bool isSuccess = await authenticationService.createUserService(
            event.phoneNumber, event.password, event.confirmPassword);
        if (isSuccess) {
          emit(SignUpSuccessState(successMessage,phone));
        } else {
          emit(SignUpFailedState(errorMessage,phone));
        }
        await Future.delayed(const Duration(seconds: 2));
        emit(SignUpInitialState(initialMessage,phone));
      }
    });

    on<ValidateFieldsEvent>((event, emit) async {
      String password = event.password;
      String phone = event.phone;
      bool isChecked = event.isChecked;
      if (state is SignUpInitialState) {
        String loadingMessage =
            translation(authenticationService.context)!.wait;
        String successMessage =
            translation(authenticationService.context)!.redirecting;
        String errorMessage =
            translation(authenticationService.context)!.please_review_the_entered_fields;
        emit(SignUpLoadingState(loadingMessage,phone));
        bool isSuccess = await authenticationService.validateFields(phone, password);

        await Future.delayed(const Duration(milliseconds: 200));
        if (isSuccess) {
          emit(SignUpInitialState(loadingMessage,phone));
          bool otpSuccess = await authenticationService.requestOtpService("register", phone, isChecked);
          if (otpSuccess) {
            emit(SignUpSuccessState(successMessage,phone));
          }
        } else {
          emit(SignUpFailedState(errorMessage,phone));
        }
        await Future.delayed(const Duration(seconds: 2));
        emit(SignUpInitialState(initialMessage,phone));
      }
    });
  }

  void sendOtp(String flujo, String phone, bool isChecked) =>
      add(SignUpSendOtpEvent(flujo: flujo, phone: phone, isChecked: isChecked));
  void validateOtp(String flujo, String inputCodeOtp, bool isCheckBoxChecked, String phone, String password) =>
      add(SignUpValidateOtpEvent(
          flujo: flujo,
          inputCodeOtp: inputCodeOtp,
          isCheckBoxChecked: isCheckBoxChecked,
          phone: phone,
          password: password));
  void finish(String phoneNumber, String password, String confirmPassword) =>
      add(SignUpFinishEvent(
          phoneNumber: phoneNumber,
          password: password,
          confirmPassword: confirmPassword));

  void validateFields(String phone, String password, bool isChecked) {

    add(ValidateFieldsEvent(
        phone: phone,
        password: password,
        isChecked: isChecked
    ));
  }
}

class SignUpEvent {}

class ValidateFieldsEvent extends SignUpEvent {
  String phone;
  String password;
  bool isChecked;
  ValidateFieldsEvent(
      {required this.phone, required this.password, required this.isChecked});
}

class SignUpSendOtpEvent extends SignUpEvent {
  String flujo;
  String phone;
  bool isChecked;
  SignUpSendOtpEvent(
      {required this.flujo, required this.phone, required this.isChecked});
}

class SignUpValidateOtpEvent extends SignUpEvent {
  String flujo;
  String inputCodeOtp;
  bool isCheckBoxChecked;
  String phone;
  String password;
  SignUpValidateOtpEvent(
      {required this.flujo,
      required this.inputCodeOtp,
      required this.isCheckBoxChecked,
      required this.phone,
      required this.password});
}

class SignUpFinishEvent extends SignUpEvent {
  String phoneNumber;
  String password;
  String confirmPassword;
  SignUpFinishEvent(
      {required this.phoneNumber,
      required this.password,
      required this.confirmPassword});
}

class SignUpState {
  String textButton;
  String phone;
  SignUpState(this.textButton,this.phone);
}

class SignUpInitialState extends SignUpState {
  SignUpInitialState(super.textButton,super.phone);
}

class SignUpLoadingState extends SignUpState {
  SignUpLoadingState(super.textButton,super.phone);
}

class SignUpSuccessState extends SignUpState {
  SignUpSuccessState(super.textButton,super.phone);
}

class SignUpFailedState extends SignUpState {
  SignUpFailedState(super.textButton,super.phone);
}

class SignUpNoInternetState extends SignUpState {
  SignUpNoInternetState(super.textButton,super.phone);
}

class SignUpDisabledState extends SignUpState {
  SignUpDisabledState(super.textButton,super.phone);
}
