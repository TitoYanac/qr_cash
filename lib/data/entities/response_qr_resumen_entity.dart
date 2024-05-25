import 'dart:convert';

import 'qr_resumen_data.dart';

class ResponseQrResumenEntity {
  List<QrResumenData> data;

  ResponseQrResumenEntity({required this.data});

  factory ResponseQrResumenEntity.fromJson(List<dynamic> dataList) {
    final qrResumenDataList =
    dataList.map((item) => QrResumenData.fromJson(item)).toList();

    return ResponseQrResumenEntity(data: qrResumenDataList);
  }

  String toJson() {
    return jsonEncode(data.map((qrResumenData) => qrResumenData.toJson()).toList());
  }
}