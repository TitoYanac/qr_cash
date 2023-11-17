import '../../domain/models/business/status_pay.dart';

class StatusPayEntity {
  String id;
  String available;
  String redeem;
  String date;
  String balance;
  String status;
  String notified;

  StatusPayEntity({
    required this.id,
    required this.available,
    required this.redeem,
    required this.date,
    required this.balance,
    required this.status,
    required this.notified,
  });

  StatusPay toStatusPay() {
    return StatusPay(
      id: id,
      available: available,
      redeem: redeem,
      date: date,
      balance: balance,
      status: status,
      notified: notified,
    );
  }

  factory StatusPayEntity.fromJson(Map<String, dynamic> json) {
    return StatusPayEntity(
      id:  "${json['Id']??''}",
      available: "${json['Available']??''}",
      redeem: "${json['Redeem']??''}",
      date: "${json['Date']??''}",
      balance: "${json['Balance']??''}",
      status: "${json['Status']??''}",
      notified: "${json['Notified']??''}"
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Available': available,
      'Redeem': redeem,
      'Date': date,
      'Balance': balance,
      'Status': status,
      'Notified': notified,
    };
  }
}

