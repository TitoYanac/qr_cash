import '../../../../domain/models/user/user.dart';
import '../../../datasources/local/shared_preferences_data_source.dart';
import '../../auth_dao.dart';

class PreferencesAuthDao extends SharedPreferencesDataSource implements AuthDao {
  Map<String, String> ruta = {
    'auth': 'phone',
    'register': 'user'
  };

  @override
  Future<Map<String, dynamic>> login(String path, String jsonString) async {
    try {

      final response = await readRowData(ruta[path]!, '');
      if (response.statusCode == 200) {
        return {'Status': '1', 'Message': 'success'};
      } else {
        return {'Status': '0', 'Message': 'Invalid User'};
      }
    } catch (e) {
      return {'Status': '-1', 'Message': 'login failed'};
    }
  }

  Future<Map<String, dynamic>> createNewUserFromLoginApi(
      String path, String jsonString) async {
    try {
      User user = User.getInstance();

      final response = await createRowData(
          "${ruta[path]!}${user.personData!.uMobileID}", jsonString);

      if (response.statusCode == 200) {
        return {'Status': '1', 'Message': 'Successful login'};
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
    return {'Status': '-1', 'Message': 'signup failed'};
  }

  @override
  Future<Map<String, dynamic>> changePassWord(String path, String jsonString) async {
    return {'Status': '-1', 'Message': 'change password failed'};
  }

  @override
  Future<Map<String, dynamic>> sendForgotPassOtp(
      String path, String jsonString) async {
    return {'Status': '-1', 'Message': 'send otp to recover account failed'};
  }

  @override
  Future<Map<String, dynamic>> sendOTP(String path, String jsonString) async {
    return {'Status': '-1', 'Message': 'send otp failed'};
  }


  @override
  Future<Map<String, dynamic>> validateOtp(String path, String jsonString) async {
    return {'Status': '-1', 'Message': 'validate otp failed'};
  }

}
