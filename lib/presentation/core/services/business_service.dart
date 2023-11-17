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
    final statusText = BlocProvider.of<BlocStatusText>(context);
    bool online = await checkConnectivity();
    await UseCaseBusiness(isOnline: online).loadVideos().then((value) {
      switch (value) {
        case 'success':
          statusText.changeStatus(translation(context)!.videos_loaded);
          break;
        default:
          statusText.changeStatus(translation(context)!.fail_to_load_videos);
          break;
      }
    });
  }

  Future<void> fetchContacts() async {
    bool online = await checkConnectivity();
    await UseCaseBusiness(isOnline: online).loadContacts().then((value) {
      switch (value) {
        case 'success':
          BlocProvider.of<BlocStatusText>(context)
              .changeStatus(translation(context)!.contacts_loaded);
          break;
        default:
          BlocProvider.of<BlocStatusText>(context)
              .changeStatus(translation(context)!.fail_to_load_contacts);
          break;
      }
    });
  }

  Future<void> fetchBanks() async {
    bool online = await checkConnectivity();
    await UseCaseBusiness(isOnline: online).loadBanks().then((value) {
      switch (value) {
        case 'success':
          BlocProvider.of<BlocStatusText>(context)
              .changeStatus(translation(context)!.banks_loaded);
          break;
        default:
          BlocProvider.of<BlocStatusText>(context)
              .changeStatus(translation(context)!.fail_to_load_banks);
          break;
      }
    });
  }

  Future<QrResponse?> validateQrManual(String codeManual) async {
    String isAllOk = isValidQrManual(codeManual);
    if (isAllOk == 'true') {
      bool online = await checkConnectivity();
      return await UseCaseBusiness(isOnline: online)
          .validateQrCodeManual(codeManual)
          .then((value) {
        print(value);
        if (value != null) {
          if(value.Message == "QR Registration Successfully"){
            SuccesfulResponseService(translation(context)!.valid_code);
          }else if(value.Message == "Code Expired"){
            ErrorResponseService(translation(context)!.code_expired);
            return null;
          }else if(value.Message == "Used"){
            ErrorResponseService(translation(context)!.code_used);
            return value;
          }else if(value.Message == "Offline"){
            SuccesfulResponseService(translation(context)!.offline);
          }
          return value;
        } else {
          ErrorResponseService(translation(context)!.failed_to_find_code);
          return null;
        }
      });
    } else {
      ErrorResponseService(translation(context)!.invalid_code);
      return null;
    }
  }

  Future<QrResponse?> validateQrCamera(String codeCamera) async {
    // Captura los valores necesarios del context antes del async gap.
    var validCodeMessage = translation(context)!.valid_code;
    var usedCodeMessage = translation(context)!.code_used;
    var failedToFindCodeMessage = translation(context)!.failed_to_find_code;
    var errorMessage = translation(context)!.something_went_wrong;

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
    String uploadFailed = translation(context)!.error_sending_data;
    String codeExpired = translation(context)!.code_expired;
    String usedCode = translation(context)!.code_used;
    bool online = await checkConnectivity();
    return await UseCaseBusiness(isOnline: online)
        .registerQr(qrResponse)
        .then((value) {
      Future.wait([
        fetchDashboardTotal(),
        fetchDashboardToday(),
        LoadAcceptedTotalQR(),
        LoadPendingTotalQR(),
        LoadRejectedTotalQR(),
      ]).then((value) => BlocProvider.of<BlocBusiness>(context)
          .refreshBusiness(Business.getInstance()));

      if (value == 'QR Registration Successfully') {
        SuccesfulResponseService(translation(context)!.correct_code);
        return true;
      } else if (value == 'Upload failed') {
        ErrorResponseService(
            uploadFailed); //translation(context)!.upload_failed
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
    String errorOffline = translation(context)!.offline;
    String textAccepted = translation(context)!.accepted;
    String textSuccessfulValidation =
        translation(context)!.successful_validation;
    String textNetworkError = translation(context)!.network_error;
    String textSomethingWentWrong = translation(context)!.something_went_wrong;

    bool online = await checkConnectivity();
    if (!online) {
      ErrorResponseService(errorOffline);
      return false;
    }

    try {
      var registerResponse =
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
    bool online = await checkConnectivity();
    await UseCaseBusiness(isOnline: false).LoadAcceptedTotalQR();
  }

  Future<void> LoadPendingTotalQR() async {
    bool online = await checkConnectivity();
    await UseCaseBusiness(isOnline: false).LoadPendingTotalQR();
  }

  Future<void> LoadRejectedTotalQR() async {
    bool online = await checkConnectivity();
    await UseCaseBusiness(isOnline: false).LoadRejectedTotalQR();
  }

  Future<bool> requestTransfer(String amount) async {
    bool online = await checkConnectivity();
    print("online: $online");
    bool isAllOk = isAmountValid(amount);
    if (isAllOk) {
      return await UseCaseBusiness(isOnline: online)
          .requestTransfer(amount)
          .then((value) {
        print("value response: $value");
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
              SuccesfulResponseService(
                  translation(context)!.request_pay_registration_successfully);
              return true;
            default:
              ErrorResponseService(translation(context)!.offline);
              return false;
          }
        });
      });
    } else {
      ErrorResponseService(translation(context)!.wrong_number_try_again);
      return false;
    }
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
