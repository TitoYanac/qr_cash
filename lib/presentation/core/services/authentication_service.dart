import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import '../../../data/dao/local/preferences/preferences_auth_dao.dart';
import '../../../data/dao/remote/api/api_auth_dao.dart';
import '../../../data/entities/user_entity.dart';
import '../../../domain/constants/language_constants.dart';
import '../../../domain/models/business/business.dart';
import '../../../domain/models/user/user.dart';
import '../../../domain/usecases/use_case_auth.dart';
import '../../../main.dart';
import 'business_service.dart';
import 'user_service.dart';
import 'util.dart';

class AuthenticationService extends Util {
  final String successMessage = 'success';
  AuthenticationService(super.context);

  Future<bool> loginService(String phoneNumber, String password) async {
    final String isAllOk =
        validatorFieldsLogin(phoneNumber, password, password);
    final String successfulLogin = translation(context)!.successful_login;
    final String wrongUserData = translation(context)!.wrong_user_data;
    if (isAllOk != 'true') {
      errorResponseService(isAllOk);
      return false;
    }
    bool isOnline = await checkConnectivity();
    final String responseLogin =
        await UseCaseAuth(isOnline: isOnline).login(phoneNumber, password);
    if (responseLogin != successMessage) {
      errorResponseService(wrongUserData);
      return false;
    }
    succesfulResponseService(successfulLogin);
    return true;
  }

  Future<bool> createUserService(final String phoneNumber,
      final String password, final String confirmPassword) async {
    final String isAllOk =
        validatorFieldsLogin(phoneNumber, password, confirmPassword);
    final String somethingWentWrong =
        translation(context)!.something_went_wrong;
    final String welcome = translation(context)!.welcome;

    if (isAllOk != 'true') {
      errorResponseService(isAllOk);
      return false;
    }
    bool isOnline = await checkConnectivity();
    final String responseAuth =
        await UseCaseAuth(isOnline: isOnline).createUser(phoneNumber, password);
    if (responseAuth != 'Created') {
      errorResponseService(somethingWentWrong);
      return false;
    }
    succesfulResponseService(welcome);
    return true;
  }

  //valida si usuario no existe y devuelve otp
  Future<bool> requestOtpService(final String flujo, final String phoneNumber,
      bool isCheckBoxChecked) async {
    final String acceptTerms =
        translation(context)!.accept_the_terms_and_conditions;
    final String otpSentBySms = translation(context)!.otp_sent_by_sms;
    final String phoneRegistered = translation(context)!.mobile_number_already_registered;

    if (!isCheckBoxChecked) {
      errorResponseService(acceptTerms);
      return false;
    }

    final String isAllOk = isValidPhoneNumber(phoneNumber);
    if (isAllOk != 'true') {
      errorResponseService(isAllOk);
      return false;
    }
    bool isOnline = await checkConnectivity();
    final String resposeOtp =
        await UseCaseAuth(isOnline: isOnline).sendOtp(phoneNumber);
    debugPrint("resposeOtp: $resposeOtp");
    if (resposeOtp.length != 6) {
      errorResponseService(phoneRegistered);
      return false;
    }

    succesfulResponseService(otpSentBySms);
    return true;
  }

  Future<bool> validateCodeOtp(
      final String flujo,
      final String inputCodeOtp,
      bool isCheckBoxChecked) async {
    final String errorCheckBox = translation(context)!.accept_the_terms;
    final String correctCode = translation(context)!.correct_code;
    final String codeOtpExpired = translation(context)!.code_otp_expired;
    if (!isCheckBoxChecked) {
      errorResponseService(errorCheckBox);
      return false;
    }
    bool isOnline = await checkConnectivity();
    final String responseOtpValid = await UseCaseAuth(isOnline: isOnline).validateOtp(inputCodeOtp);
    if (responseOtpValid != '1') {
      errorResponseService(codeOtpExpired);
      return false;
    }
    succesfulResponseService(correctCode);
    return true;
  }

  //valida si usuario existe y devuelve otp
  Future<bool> requestOtpPassForgotService(final String flujo,
      final String phoneNumber, bool isCheckBoxChecked) async {
    final String acceptTerms =
        translation(context)!.accept_the_terms_and_conditions;
    final String otpSentBySms = translation(context)!.otp_sent_by_sms;
    final String networkError = translation(context)!.network_error;
    final String wrongNumber = translation(context)!.wrong_number_try_again;
    if (!isCheckBoxChecked) {
      errorResponseService(acceptTerms);
      return false;
    }

    final String isAllOk = isValidPhoneNumber(phoneNumber);
    if (isAllOk != 'true') {
      errorResponseService(isAllOk);
      return false;
    }
    bool isOnline = await checkConnectivity();
    final String responseOtpSent =
        await UseCaseAuth(isOnline: isOnline).sendForgotPassOtp(phoneNumber);
    debugPrint("responseOtpSent: $responseOtpSent");
    if (responseOtpSent == 'network error') {
      errorResponseService(networkError);
      return false;
    }
    if (responseOtpSent == 'User does not exist') {
      errorResponseService(wrongNumber);
      return false;
    }
    if (responseOtpSent.length != 6) {
      errorResponseService(responseOtpSent);
      return false;
    }

    succesfulResponseService(otpSentBySms);

    return true;
  }

  Future<bool> changePassword(final String phoneNumber, final String password,
      final String confirmPassword) async {
    final String isAllOk =
        validatorFieldsLogin(phoneNumber, password, confirmPassword);
    final String somethingWentWrong =
        translation(context)!.something_went_wrong;
    final String welcome = translation(context)!.welcome;
    if (isAllOk != 'true') {
      errorResponseService(isAllOk);
      return false;
    }
    bool isOnline = await checkConnectivity();

    final String responseChangePass = await UseCaseAuth(isOnline: isOnline)
        .changePassWord(phoneNumber, password);
    if (responseChangePass != successMessage) {
      errorResponseService(somethingWentWrong);
      return false;
    }

    succesfulResponseService(welcome);
    return true;
  }

  Future<bool> checkUserLogged() async {
    String phone = await PreferencesAuthDao().loadString('phone');
    if (phone != "") {
      UserEntity userEntity = UserEntity();
      final Map<String, dynamic> responseData =
          jsonDecode(await PreferencesAuthDao().loadString("user$phone"));
      userEntity.saveModelFromApiData(responseData);
    }
    return (phone != "");
  }

  Future<bool> checkServer() async {
    bool serverConnection = await ApiAuthDao().checkServerConnectivity();
    return serverConnection;
  }

  Future<bool> checkInternet() async {
    bool internetConnection = await checkConnectivity();
    return internetConnection;
  }

  Future<bool> fetchBusinessDataInitial() async {
    BusinessService businessService = BusinessService(context);
    try {
      await Future.wait([
        businessService.fetchContacts(),
        businessService.fetchBanks(),
        businessService.fetchVideos(),
        businessService.fetchDashboardTotal(),
        businessService.fetchDashboardToday(),
        businessService.loadListTotalQR(),
      ]);

      await Future.wait([
        businessService.loadAcceptedTotalQR(),
        businessService.loadPendingTotalQR(),
        businessService.loadRejectedTotalQR(),
      ]);
      Business business = Business.getInstance();
      // Verificar que todas las operaciones fueron exitosas
      final allSuccessful = [
        business.contacts,
        business.bankManager,
        business.videos,
        business.dashboardTotal,
        business.dashboardToday,
        business.listTotalQr,
        business.qrAcceptedManager,
        business.qrPendingManager,
        business.qrRejectedManager,
      ].every((result) =>
          result !=
          null); // Puedes ajustar la condición según lo que signifique "éxito" para cada operación

      return allSuccessful;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkGPSConnectivity() async {
    final Location location = Location();
    bool ison = await location.serviceEnabled();
    if (!ison) {
      //if defvice is off
      bool isturnedon = await location.requestService();
      if (!isturnedon) {
        return false;
      }
    }
    return true;
  }

  Future<bool> loadLanguage() async {
    User user = User.getInstance();
    if (user.personData?.language == null || user.personData?.language == '') {
      user.personData?.language = 'en';
    }
    MyApp.setLocale(context, Locale(user.personData!.language));
    return true;
  }

  Future<bool> loadUserInitialData() async {
    UserService userService = UserService(context);
    bool userDataLoaded = await userService.loadGeneralData();
    return userDataLoaded;
  }

  validateFields(String phone, String password) {
    // Validar que los campos no estén vacíos
    if (phone == '' || password == '') {
      debugPrint("error: Campos vacíos");
      return false;
    }
    // Validar que el telefóno tenga 10 dígitos
    if (phone.length != 10) {
      debugPrint("error: El telefóno debe tener 10 dígitos");
      return false;
    }
    // Validar que la contraseña tenga al menos 6 caracteres
    if (password.length < 6) {
      debugPrint("error: La contraseña debe tener al menos 6 caracteres");
      return false;
    }
    // Validar que la contraseña tenga menos de 10 caracteres
    if (password.length > 10) {
      debugPrint("error: La contraseña debe tener menos de 10 caracteres");
      return false;
    }
    // Validar que la contraseña contenga al menos un número
    if (!RegExp(r'\d').hasMatch(password)) {
      debugPrint("error: La contraseña debe tener al menos un número");
      return false;
    }

    // Validar que la contraseña contenga al menos una mayúscula
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      debugPrint("error: La contraseña debe tener al menos una mayúscula");
      return false;
    }

    // Validar que la contraseña contenga al menos un minúscula
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      debugPrint("error: La contraseña debe tener al menos un minúscula");
      return false;
    }

    // Validar que la contraseña contenga al menos un caracter especial
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      debugPrint("error: La contraseña debe tener al menos un caracter especial");
      return false;
    }
    debugPrint("success: Campos validados correctamente");
    return true;
  }
}
