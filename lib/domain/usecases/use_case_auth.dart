

import '../../data/dao/auth_dao.dart';
import '../../data/dao/local/preferences/preferences_auth_dao.dart';
import '../../data/dao/remote/api/api_auth_dao.dart';
import '../../data/repositories/auth_repository.dart';
import '../repositories/authentication_repository.dart';

class UseCaseAuth {
  final AuthenticationRepository authRepository = AuthenticationRepositoryImpl();
  final bool isOnline;

  UseCaseAuth({required this.isOnline}) {
    AuthDao authDao;
    if (isOnline) {
      authDao = ApiAuthDao();
      authRepository.setStrategyAuthDao(authDao);
    } else {
      authDao = PreferencesAuthDao();
      authRepository.setStrategyAuthDao(authDao);
    }
  }

  Future<String> login(String phoneNumber, String password) async {
    return await authRepository.login(phoneNumber, password);
  }

  Future<String> createUser(String phoneNumber, String password) async {
   // print(phoneNumber);
    //print(password);
    return await authRepository.createNewUser(phoneNumber, password);
  }

  Future<String> sendOtp(String numero) async {
    return await authRepository.sendOTP(numero);
  }

  Future<String> validateOtp(String codeOtp) async {
    return await authRepository.validateOtp(codeOtp);
  }

  Future<String> sendForgotPassOtp(String numero) async {
    return await authRepository.sendForgotPassOtp(numero);
  }

  Future<String> changePassWord(String phoneNumber, String pass) async {
    return await authRepository.changePassWord(phoneNumber, pass);
  }
}
