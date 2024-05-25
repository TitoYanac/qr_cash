import 'dart:convert';

import 'qr_response.dart';

class QrResponseManager {
  List<QrResponse> data = [];

  QrResponseManager({
    required this.data,
  });

  void addQr(QrResponse qr) {
    //print("entro addQR: $qr");

    bool alreadyExists = data.any((existingQr) => existingQr.qr == qr.qr);

    if (!alreadyExists) {
      //print("adding : ${qr.toJson()}");
      data.add(qr);
    } else {
      //print("QR ya registrado");
    }
  }

  String toJson() {
    List<dynamic> list = data.map((scan) => scan.toJson()).toList();
    return jsonEncode(list);
  }

  factory QrResponseManager.fromJson(List<dynamic> qrListJson) {
    QrResponseManager manager = QrResponseManager(data: []);
    for (var e in qrListJson) {
      QrResponse qrres = QrResponse(
        qr: e.qr,
        from: '',
        to: '',
        statusUser: '1',
        messageUser: '',
        amount: e.monto,
        status: e.status,
        statusSAP: 'U',
        message: e.status,
        fecha: e.date,
        hora: e.date,
        latitude: '',
        longitude: '',
        localDate: e.date,
      );
      manager.addQr(qrres);
    }
    return manager;
  }
}
