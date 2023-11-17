import 'package:qrcash/domain/models/business/business.dart';
import 'package:qrcash/domain/models/dashboard/qr_response.dart';

import '../../data/dao/business_dao.dart';
import '../models/business/status_pay.dart';
import '../models/user/user.dart';

abstract class BusinessRepository{

  void setStrategyBusinessDao(BusinessDao dao);

  Future<String> loadVideos(Business business, String phoneNumber); //GetVideos
  Future<String> loadBanks(Business business); //getBanks
  Future<String> loadContacts(Business business, String phoneNumber); //GetAgents

  Future<QrResponse?> validateQrCodeManual(String qrManual, String phoneNumber); //ScanQR
  Future<QrResponse?> validateQrCodeCamera(String qrCamera, String phoneNumber); //ScanQRManual
  Future<String> registerQR(User user, Business business, QrResponse qrResponse); //RegisterQRUser

  Future<String> loadDashboardTotal(Business business, String phoneNumber); //QRResumenTotal
  Future<String> loadDashboardToday(Business business, String phoneNumber,String dateformat); //QRResumenTotalDia

  Future<String> LoadListTotalQR(Business business, String phoneNumber);
  Future<String> LoadAcceptedTotalQR(Business business, String phoneNumber);
  Future<String> LoadPendingTotalQR(Business business, String phoneNumber);
  Future<String> LoadRejectedTotalQR(Business business, String phoneNumber);

  Future<String> registerListQRrejected(Business business, String phoneNumber); //RegisterListQRUser

  Future<String> requestTransfer(String phoneNumber, String amount); //RequestTransfer
  Future<StatusPay?> getResumeStatusPay(Business business, String phoneNumber); //GetResumeStatusPay
  Future<StatusPay?> getStatusAPay(String phoneNumber, String line);



}