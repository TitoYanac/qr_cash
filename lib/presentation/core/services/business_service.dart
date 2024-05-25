import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/constants/language_constants.dart';
import '../../../domain/models/dashboard/qr_response.dart';
import '../../../domain/usecases/use_case_business.dart';
import '../../features/business/bloc/bloc_business.dart';
import 'authentication_service.dart';
import 'util.dart';
import 'package:intl/intl.dart';

class BusinessService extends Util {
  BusinessService(super.context);
  Future<bool> fetchVideos() async {
    final bool online = await checkConnectivity();
    String response = await UseCaseBusiness(isOnline: online).loadVideos();
    return (response == 'success');
  }

  Future<bool> fetchContacts() async {
    //final BlocStatusText blocStatusText =BlocProvider.of<BlocStatusText>(context);
    final bool online = await checkConnectivity();
    final String response =
        await UseCaseBusiness(isOnline: online).loadContacts();
    return (response == 'success');
  }

  Future<bool> fetchBanks() async {
    bool online = await checkConnectivity();
    final String response = await UseCaseBusiness(isOnline: online).loadBanks();
    return (response == 'success');
  }

  Future<QrResponse?> validateQrManual(String codeManual) async {
    final String validCode = translation(context)!.valid_code;
    final String codeExpired = translation(context)!.code_expired;
    final String codeUsed = translation(context)!.code_used;
    final String offline = translation(context)!.offline;
    final String failedToFindCode = translation(context)!.failed_to_find_code;
    Map<String, Function> messageActions = {
      "QR Registration Successfully": () => succesfulResponseService(validCode),
      "Code Expired": () => errorResponseService(codeExpired),
      "Used": () => errorResponseService(codeUsed),
      "Offline": () => succesfulResponseService(offline),
      "Failed to find code": () => errorResponseService(failedToFindCode),
    };
    final String isAllOk = isValidQrManual(codeManual);
    if (isAllOk != 'true') {
      errorResponseService(isAllOk);
      return null;
    }
    bool online = await checkConnectivity();
    QrResponse? response = await UseCaseBusiness(isOnline: online)
        .validateQrCodeManual(codeManual);
    Function? action = messageActions[response?.message];
    //print(response?.Message == "Failed to find code");
    //print(response?.Message);
    action?.call();
    return response;
  }

  Future<QrResponse?> validateQrCamera(String codeCamera) async {
    final String usedCodeMessage = translation(context)!.code_used;
    final String failedToFindCodeMessage = translation(context)!.failed_to_find_code;
    final String errorMessage = translation(context)!.something_went_wrong;

    bool online = await checkConnectivity();
    if (!online) {
      return QrResponse(
        qr: codeCamera,
        from: '',
        to: '',
        statusUser: '',
        messageUser: '',
        amount: '0',
        status: '0',
        statusSAP: '0',
        message: 'Offline',
        fecha: DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
        hora: ("${DateTime.now()}").toString().split(" ").last.toString(),
        latitude: '0',
        longitude: '0',
        localDate: DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
      );
    } else {
      try {
        QrResponse? response = await UseCaseBusiness(isOnline: await checkConnectivity()).validateQrCodeCamera(codeCamera);
        if (response?.message == "Enabled" && response?.statusSAP == "P" && response?.status == "1") {
          return response;
        } else if (response?.message == "Used" && response?.statusSAP == "U" && response?.status == "0") {
          errorResponseService(usedCodeMessage);
          return null;
        } else if (response?.message == "" && response?.statusSAP == "R" && response?.status == "0") {
          errorResponseService(usedCodeMessage);
          return null;
        }else {
          errorResponseService(failedToFindCodeMessage);
          return null;
        }
      } catch (e) {
        errorResponseService(errorMessage);
        return null;
      }
    }
  }

  Future<bool> registerQr(QrResponse qrResponse) async {
    final String uploadFailed = translation(context)!.error_sending_data;
    final String codeExpired = translation(context)!.code_expired;
    final String usedCode = translation(context)!.code_used;
    bool online = await checkConnectivity();
    return await UseCaseBusiness(isOnline: online)
        .registerQr(qrResponse)
        .then((value) {
      try {
        if (value == 'QR Registration Successfully') {
          return AuthenticationService(context).fetchBusinessDataInitial()
              .then((value) {
            succesfulResponseService(
                translation(context)!.successful_validation);
            return true;
          });
        } else if (value == 'Upload failed') {
          errorResponseService(uploadFailed);
          return false;
        } else if (value == 'Code Expired') {
          errorResponseService(codeExpired);
          return false;
        } else if (value == 'Used') {
          errorResponseService(usedCode);
          return false;
        } else if (value == 'Offline') {
          succesfulResponseService(translation(context)!.offline);
          return true;
        } else {
          errorResponseService(translation(context)!.failed_to_find_code);
          return false;
        }
      } catch (e) {
        errorResponseService(translation(context)!.something_went_wrong);
        return false;
      }
    });
  }

  Future<bool> registerListQRrejected(List<QrResponse> lista) async {
    final String errorOffline = translation(context)!.offline;
    final String textAccepted = translation(context)!.accepted;
    final String textSuccessfulValidation =
        translation(context)!.successful_validation;
    final String textNetworkError = translation(context)!.network_error;
    final String textSomethingWentWrong =
        translation(context)!.something_went_wrong;

    bool online = await checkConnectivity();
    if (!online) {
      errorResponseService(errorOffline);
      return false;
    }

    try {
      final String registerResponse =
          await UseCaseBusiness(isOnline: online).registerListQRrejected(lista);


      if (registerResponse == 'success') {
        bool response2 = await  Future.wait([
          fetchDashboardTotal(),
          fetchDashboardToday(),
          loadAcceptedTotalQR(),
          loadPendingTotalQR(),
          loadRejectedTotalQR(),
        ]).then((value) {

          BlocProvider.of<BlocBusiness>(context)
              .refreshBusiness();
          if(value[0] && value[1] && value[2] && value[3] && value[4]){

            succesfulResponseService(textAccepted);
          }else{
            errorResponseService(textSomethingWentWrong);
          }
          return value[0] && value[1] && value[2] && value[3] && value[4];
        });
        return response2;
      } else if (registerResponse == 'all rejected') {
        errorResponseService(
            textSuccessfulValidation); //translation(context)!.upload_failed
        return false;
      } else {
        errorResponseService(textNetworkError);
        return false;
      }
    } catch (e) {
      errorResponseService(textSomethingWentWrong);
      return false;
    }
  }

  Future<bool> fetchDashboardToday() async {
    String dateFormat = formatDate();
    bool online = await checkConnectivity();
    return await UseCaseBusiness(isOnline: online)
            .loadDashboardToday(dateFormat) !=
        "";
  }

  Future<bool> fetchDashboardTotal() async {
    bool online = await checkConnectivity();
    return await UseCaseBusiness(isOnline: online).loadDashboardTotal() != "";
  }

  Future<bool> loadListTotalQR() async {
    bool online = await checkConnectivity();
    return await UseCaseBusiness(isOnline: online).loadListTotalQR() != "";
  }

  Future<bool> loadAcceptedTotalQR() async {
    return await UseCaseBusiness(isOnline: false).loadAcceptedTotalQR() != "";
  }

  Future<bool> loadPendingTotalQR() async {
    return await UseCaseBusiness(isOnline: false).loadPendingTotalQR() != "";
  }

  Future<bool> loadRejectedTotalQR() async {
    return await UseCaseBusiness(isOnline: false).loadRejectedTotalQR() != "";
  }

  Future<bool> requestTransfer(String amount) async {
    final String wrongNumberTryAgain = translation(context)!.wrong_number_try_again;
    final String requestPayRegistrationSuccessfully = translation(context)!.request_pay_registration_successfully;
    final String somethingWentWrong = translation(context)!.something_went_wrong;
    bool online = await checkConnectivity();
    bool isAllOk = isAmountValid(amount);
    if (!isAllOk) {
      errorResponseService(wrongNumberTryAgain);
      return false;
    }

    return await UseCaseBusiness(isOnline: online)
        .requestTransfer(amount)
        .then((value) {
      return Future.wait([
        fetchDashboardTotal(),
        fetchDashboardToday(),
        loadAcceptedTotalQR(),
        loadPendingTotalQR(),
        loadRejectedTotalQR(),
      ]).then((val) {
        BlocProvider.of<BlocBusiness>(context)
            .refreshBusiness();
        switch (value) {
          case "Request Pay Registration Successfully":
            succesfulResponseService(requestPayRegistrationSuccessfully);
            return true;
          default:
            errorResponseService(somethingWentWrong);
            return false;
        }
      });
    });
  }

  bool isAmountValid(String amount) {
    try {
      if (amount.contains("-")) {
        return false;
      } else if (amount.contains(" ")) {
        return false;
      } else if (int.parse(amount) > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
