import 'package:intl/intl.dart';
import '../../domain/models/dashboard/qr_response.dart';

class QrResponseEntity {
  String qr = '';
  String? from = '';
  String? to = '';
  String? statusUser = '';
  String? messageUser = '';
  String? amount = '';
  String status = '';
  String? statusSAP = '';
  String message = '';
  String? latitude = '';
  String? longitude = '';
  String? localDate = '';

  QrResponseEntity({
    required this.qr,
    this.from = '',
    this.to = '',
    this.statusUser,
    this.messageUser,
    this.amount = '',
    required this.status,
    this.statusSAP = '',
    required this.message,
    required this.latitude,
    required this.longitude,
    required this.localDate,
  });

  factory QrResponseEntity.fromJson(Map<String, dynamic> json) {
    return QrResponseEntity(
      qr: "${json['QR'] ?? ''}",
      from: "${json['From'] ?? ''}",
      to: "${json['To'] ?? ''}",
      statusUser: "${json['StatusUser'] ?? ''}",
      messageUser: "${json['MessageUser'] ?? ''}",
      amount: "${json['Ammount'] ?? ''}",
      status: "${json['Status'] ?? ''}",
      statusSAP: "${json['StatusSAP'] ?? ''}",
      message: "${json['Message'] ?? ''}",
      latitude: "${json['Latitude'] ?? ''}",
      longitude: "${json['Longitude'] ?? ''}",
      localDate: "${json['LocalDate'] ?? ''}",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'QR': qr,
      'From': from,
      'To': to,
      'StatusUser': statusUser,
      'MessageUser': messageUser,
      'Ammount': amount,
      'Status': status,
      'StatusSAP': statusSAP,
      'Message': message,
      'Latitude': latitude,
      'Longitude': longitude,
      'LocalDate': localDate,
    };
  }

  QrResponse toQrResponse() {
    return QrResponse(
        qr: qr,
        from: from ?? '',
        to: to ?? '',
        statusUser: statusUser ?? '',
        messageUser: messageUser ?? '',
        amount: amount ?? '',
        status: status,
        statusSAP: statusSAP ?? '',
        message: message,
        fecha: DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
        hora: ("${DateTime.now()}").split(" ").last.toString(),
        latitude: latitude ?? '',
        longitude: longitude ?? '',
        localDate: localDate ?? '');
  }

  @override
  String toString() {
    return 'QrResponseEntity{QR: $qr, From: $from, To: $to, StatusUser: $statusUser, MessageUser: $messageUser, Ammount: $amount, Status: $status, StatusSAP: $statusSAP, Message: $message, Latitude: $latitude, Longitude: $longitude, Localdate: $localDate}';
  }
}
