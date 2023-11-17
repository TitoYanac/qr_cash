import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcash/presentation/features/auth/bloc/bloc_timer.dart';
import 'package:qrcash/splash_screen.dart';

import '../../../domain/constants/language_constants.dart';
import '../../../domain/usecases/use_case_auth.dart';
import '../../features/auth/pages/user_change_password_page.dart';
import '../../features/auth/pages/user_gps_validator_page.dart';
import '../../features/auth/pages/user_login_page.dart';
import '../../features/auth/pages/user_new_password_page.dart';
import '../../features/auth/pages/user_otp_receiver_forgot_pass_page.dart';
import '../../features/auth/pages/user_otp_receiver_page.dart';
import '../../features/bloc/status/bloc_status_text.dart';
import 'navigation_service.dart';
import 'util.dart';

class AuthenticationService extends Util {
  AuthenticationService(super.context);

  Future<void> loginService(String phoneNumber, String password) async {
    String isAllOk = validatorFieldsLogin(phoneNumber, password, password);
    print(isAllOk);
    if (isAllOk == 'true') {


      await UseCaseAuth(
          isOnline:
          BlocProvider.of<BlocStatusText>(context).state.statusOnline)
          .login(phoneNumber, password)
          .then((value) {
print(value);
print("logeando");
        if (value == 'success') {
          SuccesfulResponseService(translation(context)!.successful_login);
          NavigationService().navigateTo(context, const UserGpsValidator());
        } else {
          ErrorResponseService(translation(context)!.wrong_user_data);
        }
      });
    } else {
      ErrorResponseService(isAllOk);
    }
  }

  Future<void> createUserService(
      String phoneNumber, String password, String confirmPassword) async {
    String isAllOk =
    validatorFieldsLogin(phoneNumber, password, confirmPassword);
    print(isAllOk);
    if (isAllOk == 'true') {
      await UseCaseAuth(
          isOnline:
          BlocProvider.of<BlocStatusText>(context).state.statusOnline)
          .createUser(phoneNumber, password)
          .then((value) {
            print(value);
        if (value == 'Created') {
          SuccesfulResponseService(translation(context)!.welcome);
          NavigationService()
              .navigateToAndRemoveUntil(context, const UserLoginPage());
        } else {
          ErrorResponseService(translation(context)!.something_went_wrong);
        }
      });
    } else {
      ErrorResponseService(isAllOk);
    }
  }

  Future<void> requestOtpService(
      String phoneNumber, bool isCheckBoxChecked) async {
    if (isCheckBoxChecked) {
      String isAllOk = isValidPhoneNumber(phoneNumber);
      if (isAllOk == 'true') {
        await UseCaseAuth(
            isOnline:
            BlocProvider.of<BlocStatusText>(context).state.statusOnline)
            .sendOtp(phoneNumber)
            .then((value) {

          if (value.length == 6) {
            SuccesfulResponseService(translation(context)!.otp_sent_by_sms);
            NavigationService().navigateTo(
                context,
                BlocProvider(
                  create: (context) => TimerBloc(),
                  child: UserOtpReceiverPage(
                    number: phoneNumber,
                    codeOTP: value,
                  ))
                );
          } else {
            ErrorResponseService(
                translation(context)!.mobile_number_already_registered);
          }
        });
      } else {
        ErrorResponseService(isAllOk);
      }
    } else {
      ErrorResponseService(
          translation(context)!.accept_the_terms_and_conditions);
    }
  }

  Future<void> validateCodeOtp(String inputCodeOtp, String phoneNumber,
      String originalCodeOTP, bool isCheckBoxChecked) async {
    String isAllOk =
    isInputOtpValid(inputCodeOtp, originalCodeOTP, isCheckBoxChecked);

    if (isAllOk == 'true') {
      await UseCaseAuth(
          isOnline:
          BlocProvider.of<BlocStatusText>(context).state.statusOnline)
          .validateOtp(inputCodeOtp)
          .then((value) {

        if (value == '1') {
          // Aquí iría la lógica para enviar el SMS con el código OTP
          SuccesfulResponseService(translation(context)!.correct_code);
          NavigationService().navigateTo(
              context, UserNewPaswordPage(number: phoneNumber));
        } else {
          ErrorResponseService(translation(context)!.code_otp_expired);
        }
      });
    } else {
      ErrorResponseService(isAllOk);
    }
  }

  Future<void> validateCodeOtpForgotPass(
      String inputCodeOtp,
      String phoneNumber,
      String originalCodeOTP,
      bool isCheckBoxChecked) async {
    String isAllOk =
    isInputOtpValid(inputCodeOtp, originalCodeOTP, isCheckBoxChecked);

    if (isAllOk == 'true') {
      await UseCaseAuth(
          isOnline:
          BlocProvider.of<BlocStatusText>(context).state.statusOnline)
          .validateOtp(inputCodeOtp)
          .then((value) {

        if (value == '1') {
          // Aquí iría la lógica para enviar el SMS con el código OTP
          SuccesfulResponseService(translation(context)!.correct_code);

          NavigationService().replaceWith(context, UserChangePasswordPage(number: phoneNumber));
        } else {
          ErrorResponseService(translation(context)!.code_otp_expired);
        }
      });
    } else {
      ErrorResponseService(isAllOk);
    }
  }

  Future<void> requestOtpPassForgotService(String phoneNumber, bool isCheckBoxChecked) async {
    if (isCheckBoxChecked) {
      String isAllOk = isValidPhoneNumber(phoneNumber);
      if (isAllOk == 'true') {
        await UseCaseAuth(
            isOnline:
            BlocProvider.of<BlocStatusText>(context).state.statusOnline)
            .sendForgotPassOtp(phoneNumber)
            .then((value) {

          if (value.length == 6) {
            SuccesfulResponseService(translation(context)!.otp_sent_by_sms);

            NavigationService().navigateTo(
                context,
                BlocProvider(
                  create: (context) => TimerBloc(),
                  child: UserOtpReceiverForgotPassPage(
                    number: phoneNumber,
                    codeOTP: value,
                  ),
                ));
          } else {
            if(value == 'network error') {
              ErrorResponseService(translation(context)!.network_error);
            } else {
              ErrorResponseService(translation(context)!.wrong_number_try_again);
            }
          }
        });
      } else {
        ErrorResponseService(isAllOk);
      }
    } else {
      ErrorResponseService(translation(context)!.accept_the_terms_and_conditions);
      //MyErrorSnackBar(context: context, message: translation(context)!.accept_the_terms_and_conditions).showSnackBar();
    }
  }

  Future<void> changePassword(
      String phoneNumber, String password, String confirmPassword) async {
    String isAllOk =
    validatorFieldsLogin(phoneNumber, password, confirmPassword);
    if (isAllOk == 'true') {
      await UseCaseAuth(
          isOnline:
          BlocProvider.of<BlocStatusText>(context).state.statusOnline)
          .changePassWord(phoneNumber, password)
          .then((value) {
            print(value);
        if (value == 'success') {
          SuccesfulResponseService(translation(context)!.welcome);
          NavigationService()
              .navigateToAndRemoveUntil(context, const SplashScreen());
        } else {
          ErrorResponseService(translation(context)!.something_went_wrong);
        }
      });
    } else {
      ErrorResponseService(isAllOk);
    }
  }


}
