import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/constants/language_constants.dart';
import '../../../domain/models/user/user.dart';
import '../../../main.dart';
import '../../atoms/error_snackbar.dart';
import '../../features/auth/pages/user_gps_validator_page.dart';
import '../../features/auth/pages/user_login_page.dart';
import 'form_key_singleton.dart';
import 'navigation_service.dart';

class HumanValidationService {
  late final BuildContext context;
  late final String randomNumber;
  late final TextEditingController _controller;

  HumanValidationService(
    this.context,
    this.randomNumber,
    this._controller,
  );

  Future<void> requestValidation() async {
    if (GlobalKeyHumanValidationForm()
        .humanValidationFormKey
        .currentState!
        .validate()) {
      String inputText = _controller.text;
      if (inputText.isNotEmpty && inputText == randomNumber) {
        await SharedPreferences.getInstance().then((value){
          (value.getString('phone') == null)
              ? NavigationService().navigateToAndRemoveUntil(context, const UserLoginPage())
              : NavigationService().navigateToAndRemoveUntil(context,const UserGpsValidator());
        });


      } else {
        MyErrorSnackBar(
                context: context,
                message: translation(context)!.wrong_number_try_again)
            .showSnackBar();
      }
    }
  }

  Future<void> loadLanguage() async {
    await setLocale(User.getInstance().personData!.language).then((value){
      MyApp.setLocale(context, value);
    });
  }

}
