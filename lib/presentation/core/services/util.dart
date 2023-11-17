import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/constants/language_constants.dart';
import '../../atoms/error_snackbar.dart';
import '../../atoms/succesful_snackbar.dart';
import '../../features/bloc/btn/bloc_btn.dart';

abstract class Util {
  final BuildContext context;

  Util(this.context);
  Future<bool> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
  String isValidPerfilForm(String name, String pan) {
    final bool panRegex =
    RegExp(r'^[A-Za-z]{5}\d{4}[A-Za-z]{1}$').hasMatch(pan);
    return (name.isEmpty)
        ? translation(context)!.enter_your_name
        : panRegex
        ? "true"
        : translation(context)!.invalid_pan_number;
  }

  void SuccesfulResponseService(String message) {
    BlocProvider.of<MyBlocBtn>(context).cancelFetch();
    MySuccesfulSnackBar(context: context, message: message).showSnackBar();
  }

  void ErrorResponseService(String message) {
    MyErrorSnackBar(context: context, message: message).showSnackBar();
    BlocProvider.of<MyBlocBtn>(context).cancelFetch();
  }


  String isInputOtpValid(String inputOtp, String originalOtp,
      bool isCheckBoxChecked) {
    if (inputOtp.length != 6) {
      return translation(context)!.enter_the_6_digits;
    }

    for (int i = 0; i < inputOtp.length; i++) {
      if (int.tryParse(inputOtp[i]) == null) {
        return translation(context)!.enter_only_numbers;
      }
    }
    if (!isCheckBoxChecked) {
      return translation(context)!.accept_the_privacy_policy_and_terms_of_use;
    }

    if (inputOtp.compareTo(originalOtp) != 0) {
      return translation(context)!.incorrect_code;
    }
    return 'true';
  }

  String isValidQrManual(String numero) {
    if (numero.isEmpty) {
      return translation(context)!.enter_code;
    } else if (numero.length != 12) {
      return translation(context)!.code_should_be_have_12_digits;
    }

    return 'true'; // Si no hay errores, retorna null
  }

  String formatDate() {
    String year = DateTime
        .now()
        .year
        .toString();
    String month = DateTime
        .now()
        .month
        .toString()
        .padLeft(2, '0');
    String day = DateTime
        .now()
        .day
        .toString()
        .padLeft(2, '0');

    return '$year$month$day';
  }

  String validatorFieldsLogin(String phoneNumber, String password,
      String confirmPassword) {
    String validatorNumber = isValidPhoneNumber(phoneNumber);
    String validatorPassword = isValidStringPassword(password);
    String validatorConfirmPassword = translation(context)!.passwords_do_not_match;
    if (password == confirmPassword) {
      validatorConfirmPassword = 'true';
    }
    return (validatorNumber == 'true') ? (validatorPassword == 'true'
        ? validatorConfirmPassword
        : validatorPassword) : validatorNumber;
  }

  String isValidPhoneNumber(String numero) {
    if (numero.isEmpty) {
      return translation(context)!.empty_number_field;
    } else if (numero.length != 10) {
      return translation(context)!.the_number_field_should_be_have_10_digits;
    } else if (!numero.split('').every(
            (char) => char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57)) {
      return translation(context)!.enter_only_numbers;
    }

    return 'true'; // Si no hay errores, retorna null
  }

  String isValidStringPassword(String password) {

    final specialCharRegex = RegExp(r'''[!@#\$%^&*(),.?":{}|<>[\]_\-+=*~`'\\\/;:|!¡¿?€£¥§©®±_<>]''');


        final hindiLettersRegex = RegExp(r'[\u0900-\u097F]');

    if (password.isEmpty) {
      return translation(context)!.the_password_field_is_empty;
    } else if (password.length < 6) {
      return translation(context)!.the_password_field_has_less_than_6_characters;
    } else if (!password.contains(RegExp(r'\d'))) {
      return translation(context)!.the_password_field_does_not_contain_numbers;
    } else if (!specialCharRegex.hasMatch(password)) {
      return translation(context)!.the_password_field_does_not_contain_special_characters;
    } else if (!hindiLettersRegex.hasMatch(password) &&
        !RegExp(r'[a-zA-Z]').hasMatch(password)) {
      return translation(context)!.the_password_field_does_not_contain_letters_in_Hindi_or_English_alphabet;
    } else {
      return 'true';
    }
  }


}