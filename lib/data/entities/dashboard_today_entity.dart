import 'dart:convert';

import '../../domain/models/business/dashboard_today.dart';

class DashboardTodayEntity {
  String qtyAccepted;
  String amountWon;
  String qtyScanned;
  String sumScanned;
  String qtyPaid;
  String sumPaid;

  DashboardTodayEntity({
    required this.qtyAccepted,
    required this.amountWon,
    required this.qtyScanned,
    required this.sumScanned,
    required this.qtyPaid,
    required this.sumPaid,
  });

  factory DashboardTodayEntity.fromJson(Map<String, dynamic> data) {
    return DashboardTodayEntity(
      qtyAccepted: "${data['QtyAccepted']??''}",
      amountWon: "${data['AmountWon']??''}",
      qtyScanned: "${data['QtyScanned']??''}",
      sumScanned: "${data['SumScanned']??''}",
      qtyPaid: "${data['QtyPaid']??''}",
      sumPaid: "${data['SumPaid']??''}",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'QtyAccepted': qtyAccepted,
      'AmountWon': amountWon,
      'QtyScanned': qtyScanned,
      'SumScanned': sumScanned,
      'QtyPaid': qtyPaid,
      'SumPaid': sumPaid,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  DashboardToday toDashboardToday() {
    return DashboardToday(
      qtyAccepted: qtyAccepted,
      amountWon: amountWon,
      qtyScanned: qtyScanned,
      sumScanned: sumScanned,
      qtyPaid: qtyPaid,
      sumPaid: sumPaid,
    );
  }
}
