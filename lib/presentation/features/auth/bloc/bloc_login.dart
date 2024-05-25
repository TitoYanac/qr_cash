import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../core/services/authentication_service.dart';

class BlocLogin extends Bloc<LoginEvent,LoginState>{
  final AuthenticationService authenticationService;
  BlocLogin(this.authenticationService, initialmessage):super(LoginInitialState(initialmessage)) {
    on<LoginEvent>((event, emit)async {
      final traductor = translation(authenticationService.context)!;
      emit(LoginLoadingState("${traductor.searching_user}..."));
      bool isLoginSuccess = await authenticationService.loginService(event.username, event.password);
      if(isLoginSuccess){
        emit(LoginSuccessState(traductor.welcome));
      }else{
        emit(LoginFailedState(traductor.incorrect_credentials));
      }
      await Future.delayed(const Duration(seconds: 2));
      emit(LoginInitialState(traductor.login));
    });
  }

  void triggerLogin(String username, String password){
    add(LoginEvent(username: username, password: password));
  }

}
class LoginEvent{
  String username;
  String password;
  LoginEvent({required this.username,required this.password});
}
class LoginState{
  String textButton;
  LoginState(this.textButton);
}

class LoginInitialState extends LoginState{
  LoginInitialState(super.textButton);
}

class LoginLoadingState extends LoginState{
  LoginLoadingState(super.textButton);
}

class LoginSuccessState extends LoginState{
  LoginSuccessState(super.textButton);
}

class LoginFailedState extends LoginState{
  LoginFailedState(super.textButton);
}

class LoginNoInternetState extends LoginState{
  LoginNoInternetState(super.textButton);
}

class LoginDisabledState extends LoginState{
  LoginDisabledState(super.textButton);
}