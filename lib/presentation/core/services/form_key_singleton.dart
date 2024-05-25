import 'package:flutter/material.dart';

class GlobalKeyLoginForm {
  static final GlobalKeyLoginForm _instance = GlobalKeyLoginForm._internal();

  factory GlobalKeyLoginForm() {
    return _instance;
  }

  GlobalKeyLoginForm._internal();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

}
class GlobalKeyHumanValidationForm {
  static final GlobalKeyHumanValidationForm _instance = GlobalKeyHumanValidationForm._internal();

  factory GlobalKeyHumanValidationForm() {
    return _instance;
  }

  GlobalKeyHumanValidationForm._internal();

  GlobalKey<FormState> humanValidationFormKey = GlobalKey<FormState>();

}
class GlobalKeyOtpSenderForm {
  static final GlobalKeyOtpSenderForm _instance = GlobalKeyOtpSenderForm._internal();

  factory GlobalKeyOtpSenderForm() {
    return _instance;
  }

  GlobalKeyOtpSenderForm._internal();

  GlobalKey<FormState> otpSenderFormKey = GlobalKey<FormState>();

}