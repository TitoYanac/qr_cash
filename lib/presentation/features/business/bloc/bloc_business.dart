import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/entities/contact_entity.dart';
import '../../../../data/entities/video_entity.dart';
import '../../../../domain/models/business/business.dart';
import '../../../../domain/models/dashboard/qr_response.dart';
import '../../../core/services/business_service.dart';

class BlocBusiness extends Bloc<BlocBusinessEvent, BlocBusinessState> {
  BusinessService businessService;
  BlocBusiness(this.businessService) : super(BlocBusinessState()) {
    on<RefreshBusiness>((event, emit) {
      state.refreshBusiness();
      emit(state);
    });
  }
  void refreshBusiness() {
    print("entro addQrAccepted");
    add(RefreshBusiness());
  }
}

class BlocBusinessEvent {}

class RefreshBusiness extends BlocBusinessEvent {}

class BlocBusinessState {
  List<QrResponse> listAcceptedQR =
      Business.getInstance().qrAcceptedManager!.data;
  List<QrResponse> listRejectedQR =
      Business.getInstance().qrRejectedManager!.data;
  List<QrResponse> listPendingQR =
      Business.getInstance().qrPendingManager!.data;
  String loaded = Business.getInstance()
      .dashboardTotal!
      .entry
      .where((element) => element.status == 'Loaded')
      .first
      .amount;
  String redeemed = Business.getInstance()
      .dashboardTotal!
      .entry
      .where((element) => element.status == 'Paid')
      .first
      .amount;
  int scanned = (int.parse(Business.getInstance().dashboardToday.qtyAccepted)) +
      (Business.getInstance().qrPendingManager!.data.length);
  int accepted = int.parse(Business.getInstance().dashboardToday.qtyAccepted);
  int pending = Business.getInstance().qrPendingManager!.data.length;
  int rejected = Business.getInstance().qrRejectedManager!.data.length;
  List<VideoEntity> listVideos = Business.getInstance().videos!.videos;
  List<ContactEntity> listContacts = Business.getInstance().contacts!.contacts;
  String todayWon = Business.getInstance().dashboardToday.amountWon;
  void refreshBusiness() {
    listAcceptedQR = Business.getInstance().qrAcceptedManager!.data;
    listRejectedQR = Business.getInstance().qrRejectedManager!.data;
    listPendingQR = Business.getInstance().qrPendingManager!.data;

    loaded = Business.getInstance()
        .dashboardTotal!
        .entry
        .where((element) => element.status == 'Loaded')
        .first
        .amount;
    redeemed = Business.getInstance()
        .dashboardTotal!
        .entry
        .where((element) => element.status == 'Paid')
        .first
        .amount;

    scanned = (int.parse(Business.getInstance().dashboardToday.qtyAccepted)) +
        (Business.getInstance().qrPendingManager!.data.length);
    accepted = int.parse(Business.getInstance().dashboardToday.qtyAccepted);
    pending = Business.getInstance().qrPendingManager!.data.length;
    rejected = Business.getInstance().qrRejectedManager!.data.length;
    listVideos = Business.getInstance().videos!.videos;
    listContacts = Business.getInstance().contacts!.contacts;
    todayWon = Business.getInstance().dashboardToday.amountWon;
  }

  List<QrResponse> getTodaAcceptedList() {
    DateTime fechaHoy = DateTime.now();
    return listAcceptedQR.where((objeto) {
      if (objeto.localDate == '' || objeto.localDate == null) {
        return false;
      } else {
        var fechaObjeto = (objeto.localDate!.split(" ").first).split("/");
        bool isSameYear = int.tryParse(fechaObjeto[2]) == fechaHoy.year;
        bool isSameMonth = int.tryParse(fechaObjeto[1]) == fechaHoy.month;
        bool isSameDay = int.tryParse(fechaObjeto[0]) == fechaHoy.day;
        return isSameYear && isSameMonth && isSameDay;
      }
    }).toList();
  }

  @override
  String toString() {
    String listToString<T>(List<T> list) {
      return '[${list.map((item) => item.toString()).join(', ')}]';
    }

    return '''
      BlocBusinessState {
        listAcceptedQR: ${listToString(listAcceptedQR)},
        listRejectedQR: ${listToString(listRejectedQR)},
        listPendingQR: ${listToString(listPendingQR)},
        redeemed: $redeemed,
        loaded: $loaded,
        scanned: $scanned,
        accepted: $accepted,
        pending: $pending,
        rejected: $rejected,
        listVideos: ${listToString(listVideos)},
        listContacts: ${listToString(listContacts)},
        todayWon: $todayWon
      }
    ''';
  }
}
