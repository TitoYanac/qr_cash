import 'dart:convert';


import '../../../datasources/local/shared_preferences_data_source.dart';
import '../../user_dao.dart';

class PreferencesUserDao extends SharedPreferencesDataSource
    implements UserDao {
  Map<String, String> ruta = {
    'auth': 'phone',
    'register': 'user',
    'loadGeneralData': 'user'
  };
  @override
  Future<Map<String, dynamic>> loadUserData( String path, String jsonString) async {

    Map<String, dynamic> jsondata = jsonDecode(jsonString);
    String key = jsondata['mobileID'].toString();
    try {
      final response = await readRowData(ruta[path]!, key);
      if (response.statusCode == 200) {
        final String jsonBody = response.body;
        final Map<String, dynamic> responseData = jsonDecode(jsonBody);
        if (responseData['Code'] == key) {
          return responseData;
        } else {
          return {'Status': '-1', 'Message': 'load user failed'};
        }
      } else {
        return {'Status': '-1', 'Message': 'load user failed'};
      }
    } catch (e) {
      return {'Status': '-1', 'Message': 'load user failed'};
    }
  }

  @override
  Future<Map<String, dynamic>> updateBank(String path, String jsonString) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> updateUser(String path, String jsonString) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> updateUserImage(String path, String jsonString) {
    // TODO: implement updateUserImage
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> validateISFC(String path, String jsonString) {
    // TODO: implement validateISFC
    throw UnimplementedError();
  }
}
