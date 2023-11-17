import 'dart:convert';

import '../../../data/entities/qr_response_entity.dart';
import 'qr_response.dart';

class QrResponseManager {
  List<QrResponse> Data = [];

  QrResponseManager({
    required this.Data,
  });

  void addQr(QrResponse qr) {
    //print("entro addQR: $qr");

    bool alreadyExists = Data.any((existingQr) => existingQr.QR == qr.QR);

    if (!alreadyExists) {
      //print("adding : ${qr.toJson()}");
      Data.add(qr);
    } else {
      print("QR ya registrado");
    }
  }

  String toJson() {
    List<dynamic> list = Data.map((scan) => scan.toJson()).toList();
    return jsonEncode(list);
  }

  factory QrResponseManager.fromJson(List<dynamic> qrListJson) {
    QrResponseManager manager = QrResponseManager(Data: []);
    for (int i = 0; i < qrListJson.length; i++) {
      manager.addQr(
          QrResponseEntity.fromJson(jsonDecode(qrListJson[i])).toQrResponse());
    }
    return manager;
  }
}
