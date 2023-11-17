import 'dart:convert';

import '../../domain/repositories/authentication_repository.dart';
import '../dao/auth_dao.dart';
import '../entities/user_entity.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthDao? dao;

  @override
  void setStrategyAuthDao(AuthDao dao) {
    this.dao = dao;
  }

  @override
  Future<String> login(String phoneNumber, String password) async {
    try {

      final jsonbody = jsonEncode({
        "user": phoneNumber,
        "password": password
      });

      final Map<String, dynamic> responseData = await dao!.login('auth', jsonbody);
      if (responseData['Status'].toString() == '1' &&
          responseData['Message'] == 'success') {
        // if exists then init user
        await UserEntity().saveLoginData(responseData, phoneNumber);
      }
      return responseData['Message'].toString();
    } catch (e) {
      return "Connection failed";
    }
  }

  @override
  Future<String> createNewUser(String phone, String password) async {
    try {
      final String jsonBody = jsonEncode({
        "U_MobileID": phone,
        "U_Password": password,
        "code": phone
      });
      print(jsonBody);
      final Map<String, dynamic> responseData = await dao!.createNewUser('register', jsonBody);
print(responseData);
      return responseData['message'].toString();
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> sendOTP(String phoneNumber) async {
    try {
      final jsonBody = jsonEncode({"mobileID": phoneNumber});
      final responseData = await dao!.sendOTP('requestOTPRegister', jsonBody);
      if (responseData['StatusSMS'] == 'success') {
        return responseData['OTP'].toString();
      }
      return responseData['Message'];
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> validateOtp(String codeOtp) async {
    try {
      final jsonBody = jsonEncode({"otp": codeOtp});
      final Map<String, dynamic> responseData = await dao!.validateOtp('validateOTP', jsonBody);

      return responseData['status'].toString();
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> sendForgotPassOtp(String phoneNumber) async {
    try {
      final jsonBody = jsonEncode({"mobileID": phoneNumber});
      final responseData = await dao!.sendForgotPassOtp('requestOTPNewPassword', jsonBody);

      if (responseData['StatusSMS'] == 'success') {
        return responseData['OTP'].toString();
      }
      return responseData['Message'];
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> changePassWord(String phone, String password) async {
    try {
      final String jsonBody = jsonEncode({
        "code": phone,
        "U_Password": password
      });
      final responseData = await dao!.changePassWord('changePassword', jsonBody);
print(responseData);
      if (responseData['Status'] == 'success') {
        return responseData['Message'].toString();
      }
      return responseData['Message'];
    } catch (e) {
      return 'Connection failed';
    }
  }

}
