import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/constants/language_constants.dart';
import '../../../domain/usecases/use_case_auth.dart';
import '../../../splash_screen.dart';
import '../../features/auth/bloc/bloc_timer.dart';
import '../../features/auth/pages/user_change_password_page.dart';
import '../../features/auth/pages/user_gps_validator_page.dart';
import '../../features/auth/pages/user_login_page.dart';
import '../../features/auth/pages/user_new_password_page.dart';
import '../../features/auth/pages/user_otp_receiver_forgot_pass_page.dart';
import '../../features/auth/pages/user_otp_receiver_page.dart';
import 'navigation_service.dart';
import 'util.dart';

class AuthenticationService extends Util {
  final String successMessage = 'success';
  AuthenticationService(super.context);

  Future<void> loginService(final String phoneNumber, final String password) async {
    final String isAllOk = validatorFieldsLogin(phoneNumber, password, password);
    final String successfulLogin = translation(context)!.successful_login;
    final String wrongUserData = translation(context)!.wrong_user_data;
    void redirect()=> NavigationService().navigateTo(context, const UserGpsValidator());
    if (isAllOk != 'true') {
      ErrorResponseService(isAllOk);
      return;
    }
    bool isOnline = await checkConnectivity();
    final String responseLogin = await UseCaseAuth(isOnline: isOnline).login(phoneNumber, password);
    if (responseLogin != successMessage) {
      ErrorResponseService(wrongUserData);
      return;
    }
    SuccesfulResponseService(successfulLogin);
    redirect();
  }

  Future<void> createUserService(final String phoneNumber, final String password, final String confirmPassword) async {
    final String isAllOk = validatorFieldsLogin(phoneNumber, password, confirmPassword);
    final String somethingWentWrong = translation(context)!.something_went_wrong;
    final String welcome = translation(context)!.welcome;
    void redirect()=> NavigationService().navigateToAndRemoveUntil(context, const UserLoginPage());

    if(isAllOk!='true'){
      ErrorResponseService(isAllOk);
      return;
    }
    bool isOnline = await checkConnectivity();
    final String responseAuth = await UseCaseAuth(isOnline: isOnline).createUser(phoneNumber, password);
    if (responseAuth != 'Created') {
      ErrorResponseService(somethingWentWrong);
      return;
    }
    SuccesfulResponseService(welcome);
    redirect();
  }

  Future<void> requestOtpService(final String phoneNumber, bool isCheckBoxChecked) async {
    final String acceptTerms = translation(context)!.accept_the_terms_and_conditions;
    final String otpSentBySms = translation(context)!.otp_sent_by_sms;
    final String phoneRegistered = translation(context)!.mobile_number_already_registered;
    void redirect(res)=> NavigationService().navigateTo(
        context,
        BlocProvider(
            create: (context) => TimerBloc(),
            child: UserOtpReceiverPage(
              number: phoneNumber,
              codeOTP: res,
            ),
        ),
    );

    if(!isCheckBoxChecked){
      ErrorResponseService(acceptTerms);
      return;
    }

    final String isAllOk = isValidPhoneNumber(phoneNumber);
    if(isAllOk!='true'){
      ErrorResponseService(isAllOk);
      return;
    }
    bool isOnline = await checkConnectivity();
    final String resposeOtp = await UseCaseAuth(isOnline:isOnline).sendOtp(phoneNumber);
    if (resposeOtp.length != 6) {
      ErrorResponseService(phoneRegistered);
      return;
    }

    SuccesfulResponseService(otpSentBySms);
    redirect(resposeOtp);
  }

  Future<void> validateCodeOtp(final String inputCodeOtp, final String phoneNumber, final String originalCodeOTP, bool isCheckBoxChecked) async {
    final String isAllOk = isInputOtpValid(inputCodeOtp, originalCodeOTP, isCheckBoxChecked);
    final String correctCode = translation(context)!.correct_code;
    final String codeOtpExpired = translation(context)!.code_otp_expired;
    void redirect()=> NavigationService().navigateTo(context, UserNewPaswordPage(number: phoneNumber));
    if(isAllOk!='true'){
      ErrorResponseService(isAllOk);
      return;
    }
    bool isOnline = await checkConnectivity();
    final String responseOtpValid = await UseCaseAuth(isOnline: isOnline).validateOtp(inputCodeOtp);
    print("responseOtpValid $responseOtpValid");
    if (responseOtpValid != '1') {
      ErrorResponseService(codeOtpExpired);
      return;
    }
    SuccesfulResponseService(correctCode);
    redirect();
  }

  Future<void> validateCodeOtpForgotPass(final String inputCodeOtp, final String phoneNumber, final String originalCodeOTP, bool isCheckBoxChecked) async {
    final String isAllOk = isInputOtpValid(inputCodeOtp, originalCodeOTP, isCheckBoxChecked);
    final String correctCode = translation(context)!.correct_code;
    final String codeOtpExpired = translation(context)!.code_otp_expired;
    void redirect()=> NavigationService().replaceWith(context, UserChangePasswordPage(number: phoneNumber));
    if(isAllOk!='true'){
      ErrorResponseService(isAllOk);
      return;
    }

    bool isOnline = await checkConnectivity();

    final String responseOtpValid = await UseCaseAuth(isOnline: isOnline).validateOtp(inputCodeOtp);
    if (responseOtpValid != '1') {
      ErrorResponseService(codeOtpExpired);
      return;
    }
    SuccesfulResponseService(correctCode);

    redirect();
  }

  Future<void> requestOtpPassForgotService(final String phoneNumber, bool isCheckBoxChecked) async {
    final String acceptTerms = translation(context)!.accept_the_terms_and_conditions;
    final String otpSentBySms = translation(context)!.otp_sent_by_sms;
    final String networkError = translation(context)!.network_error;
    final String wrongNumber = translation(context)!.wrong_number_try_again;
    void redirect(res)=> NavigationService().navigateTo(
        context,
        BlocProvider(
          create: (context) => TimerBloc(),
          child: UserOtpReceiverForgotPassPage(
            number: phoneNumber,
            codeOTP: res,
          ),
        ));
    if (!isCheckBoxChecked) {
      ErrorResponseService(acceptTerms);
      return;
    }

    final String isAllOk = isValidPhoneNumber(phoneNumber);
    if(isAllOk!='true'){
      ErrorResponseService(isAllOk);
      return;
    }
    bool isOnline = await checkConnectivity();
    final String responseOtpSent = await UseCaseAuth(isOnline: isOnline).sendForgotPassOtp(phoneNumber);
    if (responseOtpSent.length != 6) {
      ErrorResponseService(networkError);
      return;
    }
    if(responseOtpSent != 'network error') {
      ErrorResponseService(wrongNumber);
      return;
    }

    SuccesfulResponseService(otpSentBySms);

    redirect(responseOtpSent);
  }

  Future<void> changePassword(final String phoneNumber, final String password, final String confirmPassword) async {
    final String isAllOk = validatorFieldsLogin(phoneNumber, password, confirmPassword);
    final String somethingWentWrong = translation(context)!.something_went_wrong;
    final String welcome = translation(context)!.welcome;
    void redirect()=> NavigationService().navigateToAndRemoveUntil(context, const SplashScreen());
    if(isAllOk!='true'){
      ErrorResponseService(isAllOk);
      return;
    }
    bool isOnline = await checkConnectivity();

    final String responseChangePass = await UseCaseAuth(isOnline: isOnline).changePassWord(phoneNumber, password);
    if (responseChangePass != successMessage) {
      ErrorResponseService(somethingWentWrong);
      return;
    }

    SuccesfulResponseService(welcome);
    redirect();
  }


}
