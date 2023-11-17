import '../../data/dao/auth_dao.dart';

abstract class AuthenticationRepository {
  void setStrategyAuthDao(AuthDao dao);

  Future<String> login(String username, String password);

  Future<String> createNewUser(String username, String password);

  Future<String> sendOTP(String qrCode);

  Future<String> validateOtp(String codeOtp);

  Future<String> sendForgotPassOtp(String qrCode);

  Future<String> changePassWord(String phoneNumber, String pass);
}
