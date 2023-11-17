import 'dart:convert';

class WalletEntity {
  final String Mobile;
  final String Quantity;
  final String Status;
  final String Amount;

  WalletEntity({
    required this.Mobile,
    required this.Quantity,
    required this.Status,
    required this.Amount,
  });

  Map<String, dynamic> toMap() => {
    'Mobile': Mobile,
    'Quantity': Quantity,
    'Status': Status,
    'Amount': Amount,
  };

  String toJson() => jsonEncode(toMap());

  factory WalletEntity.fromJson(Map<String, dynamic> json) {
    return WalletEntity(
      Mobile: "${json['Mobile']??''}",
      Quantity: "${json['Quantity']??'0'}",
      Status: "${json['Status']??''}",
      Amount: "${json['Amount']??'0'}"
    );
  }
}
