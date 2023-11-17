import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:qrcash/domain/models/dashboard/qr_response_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/business/bank_manager.dart';
import '../../domain/models/business/business.dart';
import '../../domain/models/business/contacts.dart';
import '../../domain/models/business/status_pay.dart';
import '../../domain/models/business/videos.dart';
import '../../domain/models/business/wallet.dart';
import '../../domain/models/dashboard/qr_response.dart';
import '../../domain/models/user/user.dart';
import '../../domain/repositories/business_repository.dart';
import '../dao/business_dao.dart';
import '../dao/local/preferences/preferences_business_dao.dart';
import '../datasources/remote/api_datasource.dart';
import '../entities/bank_response_entity.dart';
import '../entities/contact_entity.dart';
import '../entities/dashboard_today_entity.dart';
import '../entities/qr_response_entity.dart';
import '../entities/response_qr_resumen_entity.dart';
import '../entities/status_pay_entity.dart';
import '../entities/video_entity.dart';
import '../entities/wallet_entity.dart';

class BusinessRepositoryImpl extends ApiDatasource
    implements BusinessRepository {
  BusinessDao? dao;

  @override
  void setStrategyBusinessDao(BusinessDao dao) {
    this.dao = dao;
  }

  @override
  Future<String> loadVideos(Business business, String phoneNumber) async {
    try {
      final String jsonbody = jsonEncode({"mobileID": phoneNumber});
      final responseData = await dao!.loadVideos('getVideos', jsonbody);
      if (responseData.isNotEmpty) {
        final List<VideoEntity> videos = responseData
            .map((videoJson) => VideoEntity.fromJson(videoJson))
            .toList();
        business.videos = Videos(videos: videos);
        return 'success';
      }
      return 'load videos failed';
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> loadContacts(Business business, String phoneNumber) async {
    try {
      final String jsonbody = jsonEncode({"mobileID": phoneNumber});
      final responseData = await dao!.loadContacts('getAgents', jsonbody);
      if (responseData.isNotEmpty) {
        final List<ContactEntity> contacts = responseData
            .map((contactJson) => ContactEntity.fromJson(contactJson))
            .toList();
        business.contacts = Contacts(contacts: contacts);
        return 'success';
      }
      return 'load contacts failed';
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> loadBanks(Business business) async {
    try {
      final responseData = await dao!.loadBanks('getBanks', '');
      if (responseData.isNotEmpty) {
        final List<BankResponseEntity> banks = responseData
            .map((bankJson) => BankResponseEntity.fromJson(bankJson))
            .toList();
        business.bankManager = BankManager(banks: banks);
        return 'success';
      }
      return 'load banks failed';
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> loadDashboardToday(
      Business business, String phoneNumber, String dateformat) async {
    try {
      final String jsonbody = jsonEncode({"mobileID": phoneNumber, "date": dateformat});
      final List<dynamic> responseData = await dao!.loadDashboardToday('qrResumenTotalDia', jsonbody);
      print("loading dashboard today: $responseData");
      if (responseData.isNotEmpty) {
        print("como no esta vacio guardaremos sus valores");
        final DashboardTodayEntity dashboardTodayEntity =
            DashboardTodayEntity.fromJson(responseData[0]);
        business.dashboardToday = dashboardTodayEntity.toDashboardToday();
        await PreferencesBusinessDao().createListData(
            "qrResumenTotalDia${User.getInstance().personData!.uMobileID}",
            jsonEncode(responseData));

        return 'success';
      }else{
        return 'load dashboard today failed';
      }
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> loadDashboardTotal(
      Business business, String phoneNumber) async {
    try {
      final String jsonbody = jsonEncode({"mobileID": phoneNumber});
      final responseData =
          await dao!.loadDashboardTotal('qrResumenTotal', jsonbody);
      if (responseData.isNotEmpty) {
        final List<WalletEntity> wallet = responseData
            .map((contactJson) => WalletEntity.fromJson(contactJson))
            .toList();
        business.dashboardTotal = Wallet(entry: wallet);

        await PreferencesBusinessDao().createListData(
            "qrResumenTotal${User.getInstance().personData!.uMobileID}",
            jsonEncode(responseData));
        return 'success';
      }
      return 'load dashboard total failed';
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> LoadListTotalQR(Business business, String phoneNumber) async {
    try {
      final String jsonbody = jsonEncode({"mobileID": phoneNumber});
      final responseData =
          await dao!.LoadListTotalQR('qRResumenListado', jsonbody);

      if (responseData.isNotEmpty) {
        business.listTotalQr = ResponseQrResumenEntity.fromJson(responseData);
        await PreferencesBusinessDao().createListData(
            "qRResumenListado${User.getInstance().personData!.uMobileID}",
            jsonEncode(responseData));
        QrResponseManager manager = QrResponseManager(Data: []);
        for (var item in business.listTotalQr.data) {
          QrResponse qrres = QrResponse(
            QR: item.qr,
            From: '',
            To: '',
            StatusUser: '1',
            MessageUser: '',
            Ammount: item.monto,
            Status: item.status,
            StatusSAP: 'U',
            Message: item.status,
            fecha: item.date,
            hora: item.date,
            Latitude: '',
            Longitude: '',
            LocalDate: item.date,
          );
          manager.addQr(qrres);
        }

        business.qrAcceptedManager = manager;
        await PreferencesBusinessDao().createListData(
            "qRAcceptedTotal${User.getInstance().personData!.uMobileID}",
            manager.toJson());
        SharedPreferences preferences = await SharedPreferences.getInstance();
        return 'success';
      }
      return 'LoadResumeTotalQR failed';
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> LoadAcceptedTotalQR(
      Business business, String phoneNumber) async {
    try {
      final String jsonbody = jsonEncode({"mobileID": phoneNumber});
      final responseData =
          await dao!.LoadAcceptedTotalQR('qRAcceptedTotal', jsonbody);
      if (responseData.isNotEmpty) {
        business.qrAcceptedManager = QrResponseManager.fromJson(responseData);
        return 'success';
      }
      return 'LoadAcceptedTotalQR failed';
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> LoadPendingTotalQR(
      Business business, String phoneNumber) async {
    try {
      final String jsonbody = jsonEncode({"mobileID": phoneNumber});
      final responseData =
          await dao!.LoadPendingTotalQR('qRPendingTotal', jsonbody);
      if (responseData.isNotEmpty) {
        QrResponseManager qrResponseManager =
            QrResponseManager.fromJson(responseData);
        business.qrPendingManager = qrResponseManager;

        return 'success';
      }
      return 'LoadPendingTotalQR failed';
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> LoadRejectedTotalQR(
      Business business, String phoneNumber) async {
    try {
      final String jsonbody = jsonEncode({"mobileID": phoneNumber});
      final responseData =
          await dao!.LoadRejectedTotalQR('qRRejectedTotal', jsonbody);
      if (responseData.isNotEmpty) {
        business.qrRejectedManager = QrResponseManager.fromJson(responseData);
        return 'success';
      }
      return 'LoadRejectedTotalQR failed';
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<QrResponse?> validateQrCodeCamera(
      String qrCamera, String phoneNumber) async {
    try {
      final String jsonbody =
          jsonEncode({"qr": qrCamera, "mobile": phoneNumber});
      final List<dynamic> responseData = await dao!.scanQrCamera('scanQR', jsonbody);
      print("validateQrCodeCamera: $responseData");
      if (responseData.isNotEmpty) {
        QrResponse qrResponse = QrResponseEntity.fromJson(responseData[0]).toQrResponse();
        if (qrResponse.QR != '') {
          return qrResponse;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<QrResponse?> validateQrCodeManual(
      String qrManual, String phoneNumber) async {
    try {
      final String jsonbody =
          jsonEncode({"qr": qrManual, "mobile": phoneNumber});
      final List<dynamic> responseData =
          await dao!.scanQrManual('scanQRManual', jsonbody);
      if (responseData.isNotEmpty) {
        QrResponse qrResponse = QrResponseEntity.fromJson(responseData[0]).toQrResponse();
        if (qrResponse.QR != '') {
          return qrResponse;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String> registerQR(
      User user, Business business, QrResponse qrResponse) async {
    print("guardando en shared offline: $qrResponse");
    try {
      final String jsonbody = jsonEncode({
        "qr": qrResponse.QR,
        "code": user.personData!.uMobileID,
        "latitude": qrResponse.Latitude,
        "longitude": qrResponse.Longitude
      });
      DateTime dateTime = DateTime.now();
      qrResponse.LocalDate =
          DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
      qrResponse.fecha =
          DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
      qrResponse.hora = dateTime.toString().split(" ").last;
      print("testing: ${(qrResponse.Status == '1' &&
          qrResponse.StatusSAP == 'P' &&
          qrResponse.Message == 'Enabled')}");
      print("testing2: ${(qrResponse.Message == 'Offline')}");
      if (qrResponse.Status == '1' &&
          qrResponse.StatusSAP == 'P' &&
          qrResponse.Message == 'Enabled') {
        final Map<String, dynamic> responseData =
            await dao!.registerQR('registerQRUser', jsonbody);
        print("responseData registerQR: $responseData");
        qrResponse.Status = "${responseData['status'] ?? '0'}";
        qrResponse.Message = "${responseData['Message'] ?? 'upload failed'}";
        if (qrResponse.Status == '1') {
          business.qrAcceptedManager!.addQr(qrResponse);
          await PreferencesBusinessDao().createListData(
              'qRAcceptedTotal${user.personData!.uMobileID}',
              business.qrAcceptedManager!.toJson());
        } else {
          business.qrRejectedManager!.addQr(qrResponse);
          await PreferencesBusinessDao().createListData(
              'qRRejectedTotal${user.personData!.uMobileID}',
              business.qrRejectedManager!.toJson());
        }

        return "${responseData['Message'] ?? 'Upload failed'}";
      } else if (qrResponse.Message == 'Offline') {
        business.qrPendingManager!.addQr(qrResponse);
        await PreferencesBusinessDao().createListData(
            'qRPendingTotal${user.personData!.uMobileID}',
            business.qrPendingManager!.toJson());
        return qrResponse.Message!;
      } else {
        return qrResponse.StatusSAP=="U"?"Used":qrResponse.Message!;
      }
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> registerListQRrejected(Business business, String phoneNumber) async {
    try {
      var listQrPending = [];
      for (var o in business.qrPendingManager!.Data) {
        var item = {
            "u_qr": o.QR,
            "u_Latitude": o.Latitude,
            "u_Longitude": o.Longitude
          };
        listQrPending.add(item);
      }

      final String jsonbody = jsonEncode({
        "code": phoneNumber,
        "listQR": listQrPending
      });

      print(jsonbody);
      final responseData = await dao!.registerListQR('registerListQRUser', jsonbody);
print("responseData:  $responseData");
      if (responseData.isNotEmpty) {
        print("responseData que recibo : $responseData");
        business.qrPendingManager!.Data = [];

        PreferencesBusinessDao().createListData("qRPendingTotal$phoneNumber","");        //qRPendingTotal
        return 'success';
      }{
        for (var o in business.qrPendingManager!.Data) {
          business.qrRejectedManager!.addQr(o);
        }
        String key1 = "qRPendingTotal";
        PreferencesBusinessDao().createListData(key1,business.qrPendingManager!.toJson());
        business.qrPendingManager!.Data = [];
        PreferencesBusinessDao().createListData("qRPendingTotal$phoneNumber","");

        String rejectedJson = business.qrRejectedManager!.toJson();
        String key = "qRRejectedTotal$phoneNumber";
        PreferencesBusinessDao().createListData(key,rejectedJson);
        return 'all rejected';
      }

    } catch (e) {
      return 'error';
    }
  }

  @override
  Future<String> requestTransfer(String phoneNumber, String amount) async {
    try {
      final String jsonbody =
          jsonEncode({"code": phoneNumber, "amount": amount});
      final Map<String, dynamic> responseData =
          await dao!.requestTransfer('requestTransfer', jsonbody);
      return responseData['Message'];
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<StatusPay?> getResumeStatusPay(
      Business business, String phoneNumber) async {
    try {
      final jsonbody = jsonEncode({"mobileID": phoneNumber});

      final Map<String, dynamic> responseData =
          await dao!.getResumeStatusPay('getResumeStatusPay', jsonbody);
      if (responseData['Message'] != 'No Data Found') {
        // if exists then init user
        StatusPayEntity statusPayEntity =
            StatusPayEntity.fromJson(responseData);
        return statusPayEntity.toStatusPay();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<StatusPay?> getStatusAPay(String phoneNumber, String line) async {
    try {
      final jsonbody = jsonEncode({"code": phoneNumber, "line": line});

      final Map<String, dynamic> responseData =
          await dao!.getStatusAPay('getStatusAPay', jsonbody);
      if (responseData['Message'] != 'No Data Found') {
        // if exists then init user
        StatusPayEntity statusPayEntity =
            StatusPayEntity.fromJson(responseData);
        return statusPayEntity.toStatusPay();
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
