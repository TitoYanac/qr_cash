import 'dart:convert';

import '../../../datasources/remote/api_datasource.dart';
import '../../auth_dao.dart';

class ApiAuthDao extends ApiDatasource implements AuthDao {
  Map<String, String> api = {
    'auth': '/auth',
    'register': '/Register',
    'requestOTPRegister': '/ValidateExist',
    'validateOTP': '/verifyOTP',
    'requestOTPNewPassword': '/SendOTPChangedPWD',
    'changePassword': '/PasswordChanged',
  };


  @override
  Future<Map<String, dynamic>> login(String path, String jsonString) async {
    try {
      final response = await readRowData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final Map<String, dynamic> responseData = jsonDecode['Data'];
        if("${responseData['Message']??''}" == 'Successful login'){
          return {'Status': '1', 'Message': 'success'};
        }else{
          return responseData;
        }
      } else {
        return {'Status': '-1', 'Message': 'login failed'};
      }
    } catch (e) {
      return {'Status': '-1', 'Message': 'login failed'};
    }
  }

  @override
  Future<Map<String, dynamic>> createNewUser(
      String path, String jsonString) async {
    try {
      print(api[path]);
      final response = await createRowData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final Map<String, dynamic> responseData = jsonDecode['Data'];
        if ("${responseData['message'] ?? ''}" == 'Created') {
          return {'Status': '1', 'message': 'Created'};
        } else {
          return {'Status': '-1', 'message': 'signup failed'};
        }
      } else {
        return {'Status': '-1', 'message': 'signup failed'};
      }
    } catch (e) {
      return {'Status': '-1', 'message': 'signup failed'};
    }
  }

  @override
  Future<Map<String, dynamic>> sendOTP(String path, String jsonString) async {
    try {
      final response = await readRowData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['StatusSMS'] == 'success') {
          return responseData;
        } else {
          return {'Status': '0', 'Message': 'phone registered'};
        }
      } else {
        return {'Status': '-1', 'Message': 'request Otp failed'};
      }
    } catch (e) {
      return {'Status': '-1', 'Message': 'request Otp failed'};
    }
  }

  @override
  Future<Map<String, dynamic>> validateOtp(
      String path, String jsonString) async {
    try {
      final response = await readRowData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final Map<String, dynamic> responseData = jsonDecode['Data'];
        return responseData;
      } else {
        return {'status': '-1', 'Message': 'verify Otp failed'};
      }
    } catch (e) {
      return {'status': '-1', 'Message': 'verify Otp failed'};
    }
  }

  @override
  Future<Map<String, dynamic>> sendForgotPassOtp(
      String path, String jsonString) async {
    try {



      final response = await readRowData(api[path]!, jsonString);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['StatusSMS'] == 'success') {
          return responseData;
        } else {
          return {'Status': '0', 'Message': 'phone not registered'};
        }
      } else {
        return {'Status': '-1', 'Message': 'network error'};
      }
    } catch (e) {
      return {'Status': '-1', 'Message': 'request Otp failed2'};
    }
  }

  @override
  Future<Map<String, dynamic>> changePassWord(
      String path, String jsonString) async {
    try {
      final response = await readRowData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final Map<String, dynamic> responseData = jsonDecode['Data'];
        print(jsonDecode);
        if(responseData['Message']=='Changed Saved'){
          return {'Status': '1', 'Message': 'success'};
        }else{
          return responseData;
        }
      } else {
        return {'Status': '-1', 'Message': 'change password failed'};
      }
    } catch (e) {
      return {'Status': '-1', 'Message': 'change password failed'};
    }
  }
}
