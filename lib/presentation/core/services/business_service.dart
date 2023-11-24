import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcash/domain/models/business/business.dart';
import 'package:qrcash/domain/models/dashboard/qr_response.dart';
import 'package:qrcash/presentation/features/business/bloc/bloc_business.dart';

import '../../../domain/constants/language_constants.dart';
import '../../../domain/usecases/use_case_business.dart';
import '../../features/bloc/status/bloc_status_text.dart';
import 'util.dart';
import 'package:intl/intl.dart';

class BusinessService extends Util {
  BusinessService(super.context);
  Future<void> fetchVideos() async {
    final String videosLoaded = translation(context)!.videos_loaded;
    final String failToLoadVideos = translation(context)!.fail_to_load_videos;
    final statusText = BlocProvider.of<BlocStatusText>(context);
    final bool online = await checkConnectivity();
    String response = await UseCaseBusiness(isOnline: online).loadVideos();
    if (response != 'success') {
      statusText.changeStatus(failToLoadVideos);
    }
    statusText.changeStatus(videosLoaded);
  }

  Future<void> fetchContacts() async {
    final String contactsLoaded = translation(context)!.contacts_loaded;
    final String failToLoadContacts = translation(context)!.fail_to_load_contacts;
    final BlocStatusText blocStatusText =BlocProvider.of<BlocStatusText>(context);
    final bool online = await checkConnectivity();
    final String response = await UseCaseBusiness(isOnline: online).loadContacts();
    if (response != 'success') {
      blocStatusText.changeStatus(failToLoadContacts);
    }
    blocStatusText.changeStatus(contactsLoaded);
  }

  Future<void> fetchBanks() async {
    BlocStatusText blocStatusText =BlocProvider.of<BlocStatusText>(context);
    final String banksLoaded = translation(context)!.banks_loaded;
    final String failToLoadBanks = translation(context)!.fail_to_load_banks;

    bool online = await checkConnectivity();
    final String response = await UseCaseBusiness(isOnline: online).loadBanks();
    if (response != 'success') {
      blocStatusText.changeStatus(failToLoadBanks);
    }
    blocStatusText.changeStatus(banksLoaded);
  }

  Future<QrResponse?> validateQrManual(String codeManual) async {
    final String validCode = translation(context)!.valid_code;
    final String codeExpired = translation(context)!.code_expired;
    final String codeUsed = translation(context)!.code_used;
    final String offline = translation(context)!.offline;
    final String failedToFindCode = translation(context)!.failed_to_find_code;
    Map<String, Function> messageActions = {
      "QR Registration Successfully": () => SuccesfulResponseService(validCode),
      "Code Expired": () => ErrorResponseService(codeExpired),
      "Used": () => ErrorResponseService(codeUsed),
      "Offline": () => SuccesfulResponseService(offline),
      "failed to find code": () => ErrorResponseService(failedToFindCode),
    };
    final String isAllOk = isValidQrManual(codeManual);
    if (isAllOk != 'true') {
      ErrorResponseService(isAllOk);
      return null;
    }
    bool online = await checkConnectivity();
    QrResponse? response = await UseCaseBusiness(isOnline: online).validateQrCodeManual(codeManual);
    Function? action = messageActions[response?.Message];
    action?.call();
    return response;
  }

  Future<QrResponse?> validateQrCamera(String codeCamera) async {
    // Captura los valores necesarios del context antes del async gap.
    final String validCodeMessage = translation(context)!.valid_code;
    final String usedCodeMessage = translation(context)!.code_used;
    final String failedToFindCodeMessage = translation(context)!.failed_to_find_code;
    final String errorMessage = translation(context)!.something_went_wrong;

    bool online = await checkConnectivity();
    if (!online) {
      return QrResponse(
        QR: codeCamera,
        From: '',
        To: '',
        StatusUser: '',
        MessageUser: '',
        Ammount: '0',
        Status: '0',
        StatusSAP: '0',
        Message: 'Offline',
        fecha: DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
        hora: ("${DateTime.now()}").toString().split(" ").last.toString(),
        Latitude: '0',
        Longitude: '0',
        LocalDate: DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
      );
    } else {
      try {
        QrResponse? response = await UseCaseBusiness(isOnline: online)
            .validateQrCodeCamera(codeCamera);

        if (response?.Message == "Enabled") {
          SuccesfulResponseService(validCodeMessage);
          return response;
        } else if (response?.Message == "Used") {
          ErrorResponseService(usedCodeMessage);
          return null;
        } else {
          ErrorResponseService(failedToFindCodeMessage);
          return null;
        }
      } catch (e) {
        ErrorResponseService(errorMessage);
        return null;
      }
    }
  }

  Future<bool> registerQr(QrResponse qrResponse) async {
    final String uploadFailed = translation(context)!.error_sending_data;
    final String codeExpired = translation(context)!.code_expired;
    final String usedCode = translation(context)!.code_used;
    bool online = await checkConnectivity();
    print("revisando conectividad: $online");
    return await UseCaseBusiness(isOnline: online)
        .registerQr(qrResponse)
        .then((value) {
          print("value response: $value");

      if (value == 'QR Registration Successfully') {

        Future.wait([
          fetchDashboardTotal(),
          fetchDashboardToday(),
          LoadAcceptedTotalQR(),
          LoadPendingTotalQR(),
          LoadRejectedTotalQR(),
        ]).then((value) => BlocProvider.of<BlocBusiness>(context)
            .refreshBusiness(Business.getInstance()));
        SuccesfulResponseService(translation(context)!.correct_code);
        return true;
      } else if (value == 'Upload failed') {
        ErrorResponseService(uploadFailed);
        return false;
      } else if (value == 'Code Expired') {
        ErrorResponseService(codeExpired);
        return false;
      } else if (value == 'Used') {
        ErrorResponseService(usedCode);
        return false;
      } else if (value == 'Offline') {
        SuccesfulResponseService(translation(context)!.offline);
        return true;
      } else {
        ErrorResponseService(translation(context)!.failed_to_find_code);
        return false;
      }
    });
  }

  Future<bool> registerListQRrejected(List<QrResponse> lista) async {
    final String errorOffline = translation(context)!.offline;
    final String textAccepted = translation(context)!.accepted;
    final String textSuccessfulValidation = translation(context)!.successful_validation;
    final String textNetworkError = translation(context)!.network_error;
    final String textSomethingWentWrong = translation(context)!.something_went_wrong;

    bool online = await checkConnectivity();
    if (!online) {
      ErrorResponseService(errorOffline);
      return false;
    }

    try {
      final String registerResponse =
          await UseCaseBusiness(isOnline: online).registerListQRrejected(lista);
      await Future.wait([
        fetchDashboardTotal(),
        fetchDashboardToday(),
        LoadAcceptedTotalQR(),
        LoadPendingTotalQR(),
        LoadRejectedTotalQR(),
      ]).then((value) => BlocProvider.of<BlocBusiness>(context)
          .refreshBusiness(Business.getInstance()));

      if (registerResponse == 'success') {
        SuccesfulResponseService(textAccepted);
        return true;
      } else if (registerResponse == 'all rejected') {
        ErrorResponseService(
            textSuccessfulValidation); //translation(context)!.upload_failed
        return false;
      } else {
        ErrorResponseService(textNetworkError);
        return false;
      }
    } catch (e) {
      ErrorResponseService(textSomethingWentWrong);
      return false;
    }
  }

  Future<void> fetchDashboardToday() async {
    String dateFormat = formatDate();
    bool online = await checkConnectivity();
    await UseCaseBusiness(isOnline: online).loadDashboardToday(dateFormat);
  }

  Future<void> fetchDashboardTotal() async {
    bool online = await checkConnectivity();
    await UseCaseBusiness(isOnline: online).loadDashboardTotal();
  }

  Future<void> LoadListTotalQR() async {
    bool online = await checkConnectivity();
    await UseCaseBusiness(isOnline: online).LoadListTotalQR();
  }

  Future<void> LoadAcceptedTotalQR() async {
    await UseCaseBusiness(isOnline: false).LoadAcceptedTotalQR();
  }

  Future<void> LoadPendingTotalQR() async {
    await UseCaseBusiness(isOnline: false).LoadPendingTotalQR();
  }

  Future<void> LoadRejectedTotalQR() async {
    bool online = await checkConnectivity();
    await UseCaseBusiness(isOnline: false).LoadRejectedTotalQR();
  }

  Future<bool> requestTransfer(String amount) async {
    final String requestPayRegistrationSuccessfully = translation(context)!.request_pay_registration_successfully;
    final String wrongNumberTryAgain = translation(context)!.wrong_number_try_again;
    final String somethingWentWrong = translation(context)!.something_went_wrong;


    bool online = await checkConnectivity();
    bool isAllOk = isAmountValid(amount);
    if (isAllOk) {
      ErrorResponseService(wrongNumberTryAgain);
      return false;
    }

    return await UseCaseBusiness(isOnline: online)
        .requestTransfer(amount)
        .then((value) {
      return Future.wait([
        fetchDashboardTotal(),
        fetchDashboardToday(),
        LoadAcceptedTotalQR(),
        LoadPendingTotalQR(),
        LoadRejectedTotalQR(),
      ]).then((val) {
        BlocProvider.of<BlocBusiness>(context)
            .refreshBusiness(Business.getInstance());
        switch (value) {
          case "Request Pay Registration Successfully":
            SuccesfulResponseService(requestPayRegistrationSuccessfully);
            return true;
          default:
            ErrorResponseService(somethingWentWrong);
            return false;
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
