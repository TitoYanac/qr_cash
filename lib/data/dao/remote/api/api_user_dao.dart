import 'dart:convert';

import '../../../datasources/remote/api_datasource.dart';
import '../../user_dao.dart';

class ApiUserDao extends ApiDatasource implements UserDao {
  Map<String, String> api = {
    'loadGeneralData': '/LoadGeneralData',
    'updateGeneralData': '/UpdateGeneralData',
    'updateUserBankData': '/UpdateUserBankData',
    'updateImageUser': '/UpdateImageUser',
    'validateIFSC': '/ValidateIFSC'
  };

  @override
  Future<Map<String, dynamic>> loadUserData(String path, String jsonString) async {
    try {
      final response = await readRowData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final Map<String, dynamic> responseData = jsonDecode['Data'];
        final String phone = json.decode(jsonString)['mobileID'];
        if(responseData['Code'] == phone){
          return responseData;
        }else{
          return {'Status': '-1', 'Message': 'update user failed'};
        }
      } else {
        return {'Status': '-1', 'Message': 'update user failed'};
      }
    } catch (e) {
      return {'Status': '-1', 'Message': 'update user failed'};
    }
  }

  @override
  Future<Map<String, dynamic>> updateBank(String path, String jsonString) async {
    try {
      final response = await updateRowData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final Map<String, dynamic> responseData = jsonDecode['Data'];
        if(responseData['Message'] == 'Changes Saved'){
          return {'Status': '1', 'Message': 'success'};
        }else{
          return {'Status': '-1', 'Message': 'update bank data failed'};
        }
      } else {
        return {'Status': '-1', 'Message': 'update bank data failed'};
      }
    } catch (e) {
      return {'Status': '-1', 'Message': 'update bank data failed'};
    }
  }

  @override
  Future<Map<String, dynamic>> updateUser(String path, String jsonString) async {
    try {
      final response = await updateRowData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final Map<String, dynamic> responseData = jsonDecode['Data'];
        if(responseData['Message']=='Changes Saved'){
          return {'Status': '1', 'Message': 'success'};
        }else{
          return {'Status': '-1', 'Message': 'update user failed'};
        }
      } else {
        return {'Status': '-1', 'Message': 'update user failed'};
      }
    } catch (e) {
      return {'Status': '-1', 'Message': 'update user failed'};
    }
  }

  @override
  Future<Map<String, dynamic>> updateUserImage(
      String path, String jsonString) async {
    try {
      final response = await updateRowData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final Map<String, dynamic> responseData = jsonDecode['Data'];

        if(responseData['Message']=='Changed Saved'){
          return {'Status': '1', 'Message': 'success'};
        }else{
          return {'Status': '-1', 'Message': 'update user failed'};
        }
      } else {
        return {'Status': '-1', 'Message': 'update image failed'};
      }
    } catch (e) {
      return {'Status': '-1', 'Message': 'update image failed'};
    }
  }

  @override
  Future<Map<String, dynamic>> validateISFC(
      String path, String jsonString) async {
    try {
      final response = await readRowData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final Map<String, dynamic> responseData = jsonDecode['Data'];
        return responseData;
      } else {
        return {'Status': '-1', 'Message': 'search isfc failed'};
      }
    } catch (e) {
      return {'Status': '-1', 'Message': 'search isfc failed'};
    }
  }
}
