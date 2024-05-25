import 'dart:async';

import '../../../data/entities/response_qr_resumen_entity.dart';
import '../dashboard/qr_response_manager.dart';
import 'bank_manager.dart';
import 'contacts.dart';
import 'dashboard_today.dart';
import 'vehicle.dart';
import 'videos.dart';
import 'wallet.dart';

class Business {
  String myText = "";
  Videos? videos = Videos(videos: []);
  Contacts? contacts = Contacts(contacts: []);
  List<Vehicle> vehicles = [
    Vehicle(1, "🏍️", "motorcycle"),
    Vehicle(2, "🏎️", "car"),
    Vehicle(3, "🚚", "truck"),
    Vehicle(4, "🚌", "bus"),
    Vehicle(5, "🛺", "other"),
  ];
  DashboardToday dashboardToday = DashboardToday(qtyAccepted: '', amountWon: '', qtyScanned: '', sumScanned: '', qtyPaid: '', sumPaid: '');
  Wallet? dashboardTotal = Wallet(entry: []);
  ResponseQrResumenEntity listTotalQr =  ResponseQrResumenEntity(data: []);
  BankManager? bankManager = BankManager(banks: []);


  QrResponseManager? qrPendingManager = QrResponseManager(data: []);
  QrResponseManager? qrRejectedManager = QrResponseManager(data: []);
  QrResponseManager? qrAcceptedManager = QrResponseManager(data: []);


  // Singleton instance
  static Business? _instance;

  // Private constructor
  Business._internal();

  // Singleton factory constructor
  factory Business.getInstance() {
    _instance ??= Business._internal(
    );
    return _instance!;
  }


  // StreamController para emitir eventos cuando cambien los datos de informes
  final _reportsController = StreamController<void>.broadcast();

  // Getter para el stream que los widgets pueden escuchar
  Stream<void> get reportsStream => _reportsController.stream;

  // Método para notificar a los oyentes sobre cambios en los datos de informes
  void notifyReportsChanged() {
    _reportsController.add(null);
  }
}
