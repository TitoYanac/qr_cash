import 'dart:convert';

import 'package:qrcash/data/dao/local/preferences/preferences_business_dao.dart';

import '../../../datasources/remote/api_datasource.dart';
import '../../business_dao.dart';

class ApiBusinessDao extends ApiDatasource implements BusinessDao {
  Map<String, String> api = {
    'getVideos': '/GetVideos',
    'getBanks': '/getBanks',
    'getAgents': '/GetAgents',
    'scanQR': '/ScanQR',
    'scanQRManual': '/ScanQRManual',
    'registerQRUser': '/RegisterQRUser',
    'qrResumenTotalDia': '/QRResumenTotalDia',
    'qrResumenTotal': '/QRResumenTotal',
    'qRResumenListado': '/QRResumenListado',
    'registerListQRUser': '/RegisterListQRUser',
    'requestTransfer': '/RequestTransfer',
    'getResumeStatusPay': '/GetResumeStatusPay',
    'getStatusAPay': '/GetStatusAPay',
    'wallet': '/QRResumenListado'
  };

  @override
  Future<List<dynamic>> loadVideos(String path, String jsonString) async {
    try {
      final response = await readListData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final List<dynamic> responseData = jsonDecode['Data'];
        if (responseData.isNotEmpty) {
          await PreferencesBusinessDao()
              .createListData("videos", jsonEncode(responseData));
          return responseData;
        } else {
          return [
            {'Status': '-1', 'Message': 'load videos failed1'}
          ];
        }
      } else {
        return [
          {'Status': '-1', 'Message': 'load videos failed2'}
        ];
      }
    } catch (e) {
      return [
        {'Status': '-1', 'Message': 'load videos failed3'}
      ];
    }
  }

  @override
  Future<List<dynamic>> loadBanks(String path, String jsonString) async {
    try {
      final response = await readListData(api[path]!, '');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final List<dynamic> responseData = jsonDecode['Data'];
        if (responseData.isNotEmpty) {
          await PreferencesBusinessDao()
              .createListData("banks", jsonEncode(responseData));
          return responseData;
        } else {
          return [
            {'Status': '-1', 'Message': 'load banks failed1'}
          ];
        }
      } else {
        return [
          {'Status': '-1', 'Message': 'load banks failed2'}
        ];
      }
    } catch (e) {
      return [
        {'Status': '-1', 'Message': 'load banks failed3'}
      ];
    }
  }

  @override
  Future<List<dynamic>> loadContacts(String path, String jsonString) async {
    try {
      final response = await readListData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final List<dynamic> responseData = jsonDecode['Data'];
        if (responseData.isNotEmpty) {
          await PreferencesBusinessDao()
              .createListData("agents", jsonEncode(responseData));
          return responseData;
        } else {
          return [
            {'Status': '-1', 'Message': 'load contact failed'}
          ];
        }
      } else {
        return [
          {'Status': '-1', 'Message': 'load contact failed'}
        ];
      }
    } catch (e) {
      return [
        {'Status': '-1', 'Message': 'load contact failed'}
      ];
    }
  }

  @override
  Future<List<dynamic>> scanQrCamera(String path, String jsonString) async {
    try {
      final response = await readListData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final List<dynamic> responseData = jsonDecode['Data'];
        if (responseData.isNotEmpty) {
          return responseData;
        } else {
          return [
            {'Status': '-1', 'Message': 'scan camera failed'}
          ];
        }
      } else {
        return [
          {'Status': '-1', 'Message': 'scan camera failed'}
        ];
      }
    } catch (e) {
      return [
        {'Status': '-1', 'Message': 'scan camera failed'}
      ];
    }
  }

  @override
  Future<List<dynamic>> scanQrManual(String path, String jsonString) async {
    try {
      return await readListData(api[path]!, jsonString).then((response) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonDecode = json.decode(response.body);
          final List<dynamic> responseData = jsonDecode['Data'];
          if (responseData.isNotEmpty) {
            return responseData;
          } else {
            return [
              {'Status': '-1', 'Message': 'scan manual failed'}
            ];
          }
        }
        else {
          return [
            {'Status': '-1', 'Message': 'scan manual failed'}
          ];
        }
      });
    } catch (e) {
      return [
        {'Status': '-1', 'Message': 'scan manual failed'}
      ];
    }
  }

  @override
  Future<Map<String, dynamic>> registerQR(
      String path, String jsonString) async {
    try {
      final response = await createRowData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final Map<String, dynamic> responseData = jsonDecode['Data'];
        final Map<String, dynamic> responseData2 = responseData['Data'];
        return responseData2;
      } else {
        return {
          'status': '-1',
          'Message': 'Upload failed'
        }; //aqui se devuelve status con s minuscula de la api
      }
    } catch (e) {
      return {'status': '-1', 'Message': 'Upload failed'};
    }
  }

  @override
  Future<List<dynamic>> loadDashboardToday(
      String path, String jsonString) async {
    try {
      final response = await readListData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final List<dynamic> responseData = jsonDecode['Data'];
        if (responseData.isNotEmpty) {
          return responseData;
        } else {
          return [
            {'Status': '-1', 'Message': 'load dashboard today failed'}
          ];
        }
      } else {
        return [
          {'Status': '-1', 'Message': 'load dashboard today failed'}
        ];
      }
    } catch (e) {
      return [
        {'Status': '-1', 'Message': 'load dashboard today failed'}
      ];
    }
  }

  @override
  Future<List<dynamic>> loadDashboardTotal(
      String path, String jsonString) async {
    print("entro api");
    try {
      final response = await readListData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final List<dynamic> responseData = jsonDecode['Data'];
        if (responseData.isNotEmpty) {
          return responseData;
        } else {
          return [
            {'Status': '-1', 'Message': 'load dashboard total failed'}
          ];
        }
      } else {
        return [
          {'Status': '-1', 'Message': 'load dashboard total failed'}
        ];
      }
    } catch (e) {
      return [
        {'Status': '-1', 'Message': 'load dashboard total failed'}
      ];
    }
  }

  @override
  Future<List> LoadListTotalQR(String path, String jsonString) async{
    try {
      final response = await readListData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final List<dynamic> responseData = jsonDecode['Data'];
        if (responseData.isNotEmpty) {
          return responseData;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<dynamic>> LoadAcceptedTotalQR(String path, String jsonString) async {
    return [];
  }

  @override
  Future<List<dynamic>> LoadPendingTotalQR(String path, String jsonString) async {
    return [];
  }

  @override
  Future<List<dynamic>> LoadRejectedTotalQR(String path, String jsonString) async {
    return [];
  }

  @override
  Future<List<dynamic>> registerListQR(String path, String jsonString) async {
    try {
      print("enviando: $jsonString");
      final response = await readListData(api[path]!, jsonString);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        print("recibiendo: $jsonDecode");
        final List<dynamic> responseData = jsonDecode['qrList'];
        print("_jsonDecode['qrList']: $responseData");
        if (responseData.isNotEmpty) {
          return responseData;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Map<String, dynamic>> requestTransfer(
      String path, String jsonbody) async {
    try {
      final response = await createRowData(api[path]!, jsonbody);
      print("response.body: ${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final responseData = jsonDecode['Data'];
        if ("${responseData['Message']??''}" == 'Request Pay Registration Successfully') {
          return {
            "status": "1",
            "Message": "Request Pay Registration Successfully"
          };
        } else {
          return {'status': '0', 'Message': 'Amount not available'};
        }
      } else {
        return {
          'status': '-1',
          'Message': 'request transfer failed'
        };
      }
    } catch (e) {
      return {'status': '-1', 'Message': 'request transer failed'};
    }
  }

  @override
  Future<Map<String, dynamic>> getResumeStatusPay(String path, String jsonbody) async {
    try {
      final response = await readRowData(api[path]!, jsonbody);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final Map<String, dynamic> responseData = jsonDecode['Data'];
        if("${responseData??''}" == 'No Data Found'){
          return {'Status': '0', 'Message': 'No Data Found'};
        }else{
          return responseData;
        }
      } else {
        return {'Status': '-1', 'Message': 'No Data Found'};
      }
    } catch (e) {
      return {'Status': '-1', 'Message': 'No Data Found'};
    }
  }

  @override
  Future<Map<String, dynamic>> getStatusAPay(String path, String jsonbody) async {
    try {
      final response = await readRowData(api[path]!, jsonbody);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecode = json.decode(response.body);
        final Map<String, dynamic> responseData = jsonDecode['Data'];
        if("$responseData" == 'No Data Found'){
          return {'Status': '0', 'Message': 'No Data Found'};
        }else{
          return responseData;
        }
      } else {
        return {'Status': '-1', 'Message': 'No Data Found'};
      }
    } catch (e) {
      return {'Status': '-1', 'Message': 'No Data Found'};
    }
  }


}
