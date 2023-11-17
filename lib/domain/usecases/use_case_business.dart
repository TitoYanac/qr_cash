import 'package:geolocator/geolocator.dart';
import 'package:qrcash/domain/models/dashboard/qr_response.dart';

import '../../data/dao/business_dao.dart';
import '../../data/dao/local/preferences/preferences_business_dao.dart';
import '../../data/dao/remote/api/api_business_dao.dart';
import '../../data/repositories/business_repository_impl.dart';
import '../models/business/business.dart';
import '../models/business/status_pay.dart';
import '../models/user/user.dart';
import '../repositories/business_repository.dart';

class UseCaseBusiness {
  final BusinessRepository businessRepository = BusinessRepositoryImpl();
  final bool isOnline;

  UseCaseBusiness({required this.isOnline}) {
    BusinessDao businessDao;
    if (isOnline) {
      businessDao = ApiBusinessDao();
      businessRepository.setStrategyBusinessDao(businessDao);
    } else {
      businessDao = PreferencesBusinessDao();
      businessRepository.setStrategyBusinessDao(businessDao);
    }
  }

  Future<String> loadVideos() async {
    return await businessRepository.loadVideos(
        Business.getInstance(), User.getInstance().personData!.uMobileID);
  }

  Future<String> loadContacts() async {
    return await businessRepository.loadContacts(
        Business.getInstance(), User.getInstance().personData!.uMobileID);
  }

  Future<String> loadBanks() async {
    return await businessRepository.loadBanks(Business.getInstance());
  }

  Future<QrResponse?> validateQrCodeCamera(String codeCamera) async {
    String phoneNumber = User.getInstance().personData!.uMobileID;
    return await businessRepository.validateQrCodeCamera(codeCamera, phoneNumber);
  }

  Future<QrResponse?> validateQrCodeManual( String codeManual) async {
    String qrCode = formatQrCode(codeManual);
    String phoneNumber = User.getInstance().personData!.uMobileID;
    return await businessRepository.validateQrCodeManual(qrCode, phoneNumber);
  }

  Future<String> registerQr(QrResponse qrResponse) async {
    User user = User.getInstance();
    Business business = Business.getInstance();
    if(isOnline){
      Position? position = await getCurrentLocation();
      qrResponse.Latitude = position!.latitude.toString();
      qrResponse.Longitude = position.longitude.toString();
    }
    return await businessRepository.registerQR(user, business, qrResponse);
  }
  Future<String> registerListQRrejected(List<QrResponse> lista) async {
    User user = User.getInstance();
    Business business = Business.getInstance();
    return await businessRepository.registerListQRrejected(business, user.personData!.uMobileID);
  }

  Future<String> loadDashboardToday(String dateFormat) async {
    Business business = Business.getInstance();
    return await businessRepository.loadDashboardToday(
        business, User.getInstance().personData!.uMobileID, dateFormat);
  }

  Future<String> loadDashboardTotal() async {
    Business business = Business.getInstance();
    return await businessRepository.loadDashboardTotal(
        business, User.getInstance().personData!.uMobileID);
  }

  Future<String> LoadListTotalQR() async {
    Business business = Business.getInstance();
    return await businessRepository.LoadListTotalQR(
        business, User.getInstance().personData!.uMobileID);
  }

  Future<String> LoadAcceptedTotalQR() async {
    Business business = Business.getInstance();
    return await businessRepository.LoadAcceptedTotalQR(
        business, User.getInstance().personData!.uMobileID);
  }

  Future<String> LoadPendingTotalQR() async {
    Business business = Business.getInstance();
    return await businessRepository.LoadPendingTotalQR(
        business, User.getInstance().personData!.uMobileID);
  }

  Future<String> LoadRejectedTotalQR() async {
    Business business = Business.getInstance();
    return await businessRepository.LoadRejectedTotalQR(
        business, User.getInstance().personData!.uMobileID);
  }

  Future<String> requestTransfer(String amount) async {
    return await businessRepository.requestTransfer(
        User.getInstance().personData!.uMobileID, amount);
  }

  Future<StatusPay?> getStatusAPay(String line) async {
    return businessRepository.getStatusAPay(
        User.getInstance().personData!.uMobileID, line);
  }

  Future<StatusPay?> getResumeStatusPay() async {
    return businessRepository.getResumeStatusPay(
        Business.getInstance(), User.getInstance().personData!.uMobileID);
  }

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;

    LocationPermission permission;

    // Verificar si los servicios de geolocalización están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
    }

    // Verificar los permisos de geolocalización
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    // Obtener la posición actual
    return await Geolocator.getCurrentPosition();
  }

  Future<QrResponse> generateEmptyQrResponse(String qrCode) async {
    Position? position = await getCurrentLocation();
    String latitude = "";
    String longitude = "";
    if (position != null) {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
    }
    DateTime now = DateTime.now();
    String fecha = '${now.day}-${now.month}-${now.year}';
    String period = now.hour >= 12 ? 'PM' : 'AM';
    int hourOfPeriod = now.hour % 12;
    hourOfPeriod = hourOfPeriod == 0
        ? 12
        : hourOfPeriod; // to display 12 for noon and midnight instead of 0
    String hora =
        "${hourOfPeriod.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} $period";

    QrResponse qrResponse = QrResponse(
        QR: qrCode,
        From: '',
        To: '',
        StatusUser: '',
        MessageUser: '',
        Ammount: '0',
        Status: '-1',
        StatusSAP: '',
        Message: '',
        fecha: fecha,
        hora: hora,
        Latitude: latitude,
        Longitude: longitude,
        LocalDate: now.toString());
    return qrResponse;
  }

  String formatQrCode(String codeQr) {
    String qrCode = codeQr;
    if (codeQr.length == 12) {
      qrCode = codeQr
          .replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)}-")
          .substring(0, 14);
    }
    return qrCode;
  }



}
