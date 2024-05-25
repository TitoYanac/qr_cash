import 'dart:convert';

class WalletEntity {
  final String mobile;
  final String quantity;
  final String status;
  final String amount;

  WalletEntity({
    required this.mobile,
    required this.quantity,
    required this.status,
    required this.amount,
  });

  Map<String, dynamic> toMap() => {
    'Mobile': mobile,
    'Quantity': quantity,
    'Status': status,
    'Amount': amount,
  };

  String toJson() => jsonEncode(toMap());

  factory WalletEntity.fromJson(Map<String, dynamic> json) {
    return WalletEntity(
      mobile: "${json['Mobile'] ?? ''}",
      quantity: "${json['Quantity'] ?? '0'}",
      status: "${json['Status'] ?? ''}",
      amount: "${json['Amount'] ?? '0'}",
    );
  }
}
