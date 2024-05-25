import 'dart:convert';

class DashboardToday {
  String qtyAccepted;
  String amountWon;
  String qtyScanned;
  String sumScanned;
  String qtyPaid;
  String sumPaid;

  DashboardToday({
    required this.qtyAccepted,
    required this.amountWon,
    required this.qtyScanned,
    required this.sumScanned,
    required this.qtyPaid,
    required this.sumPaid,
  });

  factory DashboardToday.fromJson(Map<String, dynamic> json) {
    return DashboardToday(
      qtyAccepted: "${json['QtyAccepted']??'0'}",
      amountWon: "${json['AmountWon']??'0.00'}",
      qtyScanned: "${json['QtyScanned']??'0'}",
      sumScanned: "${json['SumScanned']??'0'}",
      qtyPaid: "${json['QtyPaid']??'0'}",
      sumPaid: "${json['SumPaid']??'0.00'}",
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
    final Map<String, dynamic> data = toMap();
    return json.encode(data);
  }
}
