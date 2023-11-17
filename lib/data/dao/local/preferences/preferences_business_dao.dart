import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:qrcash/domain/models/business/business.dart';
import 'package:qrcash/domain/models/dashboard/qr_response.dart';
import 'package:qrcash/domain/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../datasources/local/shared_preferences_data_source.dart';
import '../../business_dao.dart';

class PreferencesBusinessDao extends SharedPreferencesDataSource
    implements BusinessDao {
  Map<String, String> ruta = {
    'getVideos': 'videos',
    'getAgents': 'agents',
    'apiGetBanks': 'banks',

    'qrResumenTotal': 'qrResumenTotal',
    'qrResumenTotalDia': 'qrResumenTotalDia',

    'qRResumenListado': 'qRResumenListado',

    'qRAcceptedTotal': 'qRAcceptedTotal',
    'qRPendingTotal': 'qRPendingTotal',
    'qRRejectedTotal': 'qRRejectedTotal',

    //'registerQRResumen': 'qRResumenTotal',
    'registerQRUser': 'qRPendingTotal',
    'registerQRAccepted': 'qRAcceptedTotal',
    'registerQRRejected': 'qRRejectedTotal'
  };

  @override
  Future<List<dynamic>> loadVideos(String path, String jsonString) async {
    Map<String, dynamic> jsondata = jsonDecode(jsonString);
    String key = jsondata['mobileID'].toString();
    try {
      final response = await readListData(ruta[path]!, key);
      if (response.statusCode == 200) {
        final String jsonBody = response.body;
        final List<dynamic> responseData = jsonDecode(jsonBody);
        if (responseData.isNotEmpty) {
          return responseData;
        } else {
          return [
            {'Status': '-1', 'Message': 'load videos failed'}
          ];
        }
      } else {
        return [
          {'Status': '-1', 'Message': 'load videos failed'}
        ];
      }
    } catch (e) {
      return [
        {'Status': '-1', 'Message': 'load videos failed'}
      ];
    }
  }

  @override
  Future<List<dynamic>> loadContacts(String path, String jsonString) async {
    Map<String, dynamic> jsondata = jsonDecode(jsonString);
    String key = jsondata['mobileID'].toString();
    try {
      final response = await readListData(ruta[path]!, key);
      if (response.statusCode == 200) {
        final String jsonBody = response.body;
        final List<dynamic> responseData = jsonDecode(jsonBody);
        if (responseData.isNotEmpty) {
          return responseData;
        } else {
          return [
            {'Status': '-1', 'Message': 'load contacts failed'}
          ];
        }
      } else {
        return [
          {'Status': '-1', 'Message': 'load contacts failed'}
        ];
      }
    } catch (e) {
      return [
        {'Status': '-1', 'Message': 'load contacts failed'}
      ];
    }
  }

  @override
  Future<List<dynamic>> loadBanks(String path, String jsonString) async {
    try {
      final response = await readListData(ruta[path]!, '');
      if (response.statusCode == 200) {
        final String jsonBody = response.body;
        final List<dynamic> responseData = jsonDecode(jsonBody);
        if (responseData.isNotEmpty) {
          return responseData;
        } else {
          return [
            {'Status': '-1', 'Message': 'load contacts failed'}
          ];
        }
      } else {
        return [
          {'Status': '-1', 'Message': 'load contacts failed'}
        ];
      }
    } catch (e) {
      return [
        {'Status': '-1', 'Message': 'load contacts failed'}
      ];
    }
  }

  @override
  Future<List<dynamic>> scanQrCamera(String path, String jsonString) async {
    return [];
  }

  @override
  Future<List<dynamic>> scanQrManual(String path, String jsonString) async {
    return [];
  }

  @override
  Future<Map<String, dynamic>> registerQR(
      String path, String jsonString) async {
    print("entro a registerQR offline preferences: $jsonString");
    User user = User.getInstance();
    Business business = Business.getInstance();
    Map<String, dynamic> data = jsonDecode(jsonString);
    String fecha = DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());
    QrResponse qrResponse = QrResponse(
        QR: data['qr'],
        From: data['From'] ?? fecha,
        To: data['To'] ?? fecha,
        StatusUser: '1',
        MessageUser: '',
        Ammount: '0',
        Status: '0',
        StatusSAP: '',
        Message: 'Offline',
        fecha: fecha,
        hora: (DateTime.now().toString().split(" ").last).split(".").first,
        Latitude: '0',
        Longitude: '0',
        LocalDate: DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()));
    business.qrPendingManager!.addQr(qrResponse);
    String miruta = '${ruta[path]}${user.personData!.uMobileID}';
    String jsontoSave = business.qrPendingManager!.toJson();
    print("--------------------------------");
    await createListData(miruta, jsontoSave);
    SharedPreferences.getInstance().then((value) {
      String? valor = value.getString(miruta);
      print("valor: ${valor.toString()}");

      print("jsontoSave: $jsontoSave");
    });
    return {'status': '0', 'Message': 'Upload failed'};
  }

  @override
  Future<List<dynamic>> registerListQR(String path, String jsonString) async {
    return [];
  }

  @override
  Future<List<dynamic>> loadDashboardToday(
      String path, String jsonString) async {
    try {
      final response = await readListData(
          "${ruta[path]!}${User.getInstance().personData!.uMobileID}", '');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
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
  Future<List<dynamic>> loadDashboardTotal(
      String path, String jsonString) async {
    print("entro preferences");
    try {
      final response = await readListData(
          "${ruta[path]!}${User.getInstance().personData!.uMobileID}", '');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
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
  Future<List<dynamic>> LoadListTotalQR(String path, String jsonString) async {
    try {
      final response = await readListData(
          "${ruta[path]!}${User.getInstance().personData!.uMobileID}", '');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
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
  Future<List<dynamic>> LoadAcceptedTotalQR(
      String path, String jsonString) async {
    try {
      final response = await readListData(
          "${ruta[path]!}${User.getInstance().personData!.uMobileID}", '');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
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
  Future<List<dynamic>> LoadPendingTotalQR(
      String path, String jsonString) async {
    try {
      final response = await readListData(
          "${ruta[path]!}${User.getInstance().personData!.uMobileID}", '');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
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
  Future<List<dynamic>> LoadRejectedTotalQR(
      String path, String jsonString) async {
    try {
      final response = await readListData(
          "${ruta[path]!}${User.getInstance().personData!.uMobileID}", '');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
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
    return {'status': '0', 'Message': 'transfer failed'};
  }

  @override
  Future<Map<String, dynamic>> getResumeStatusPay(
      String path, String jsonbody) async {
    try {
      final response = await readListData(ruta[path]!, jsonbody);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.isNotEmpty) {
          return responseData;
        } else {
          return {'Status': '-1', 'Message': 'load pay resumen failed'};
        }
      } else {
        return {'Status': '-1', 'Message': 'load pay resumen failed'};
      }
    } catch (e) {
      return {'Status': '-1', 'Message': 'load pay resumen failed'};
    }
  }

  @override
  Future<Map<String, dynamic>> getStatusAPay(
      String path, String jsonbody) async {
    try {
      final response = await readListData(ruta[path]!, jsonbody);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.isNotEmpty) {
          return responseData;
        } else {
          return {'Status': '-1', 'Message': 'load status pay failed'};
        }
      } else {
        return {'Status': '-1', 'Message': 'load status pay failed'};
      }
    } catch (e) {
      return {'Status': '-1', 'Message': 'load status pay failed'};
    }
  }
}
