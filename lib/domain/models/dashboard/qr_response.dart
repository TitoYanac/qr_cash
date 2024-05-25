import 'dart:convert';
import '../../../data/entities/qr_response_entity.dart';

class QrResponse {
  late String? qr = '';
  late String? from = '';
  late String? to = '';
  late String? statusUser = '';
  late String? messageUser = '';
  late String? amount = '';
  late String? status = '';
  late String? statusSAP = '';
  late String? message = '';
  late String? fecha = '';
  late String? hora = '';
  late String? latitude = '';
  late String? longitude = '';
  late String? localDate = '';

  QrResponse({
    required this.qr,
    required this.from,
    required this.to,
    required this.statusUser,
    required this.messageUser,
    required this.amount,
    required this.status,
    required this.statusSAP,
    required this.message,
    required this.fecha,
    required this.hora,
    required this.latitude,
    required this.longitude,
    required this.localDate,
  });

  Map<String, dynamic> toMap() => {
    'qr': qr,
    'from': from,
    'to': to,
    'statusUser': statusUser,
    'messageUser': messageUser,
    'amount': amount,
    'status': status,
    'statusSAP': statusSAP,
    'message': message,
    'fecha': fecha,
    'hora': hora,
    'latitude': latitude,
    'longitude': longitude,
    'localDate': localDate,
  };

  String toJson() => jsonEncode(toMap());

  QrResponseEntity toQrResponseEntity() {
    return QrResponseEntity(
      qr: qr ?? '',
      from: from,
      to: to,
      statusUser: statusUser,
      messageUser: messageUser,
      amount: amount,
      status: status ?? '',
      statusSAP: statusSAP,
      message: message ?? '',
      latitude: latitude,
      longitude: longitude,
      localDate: localDate,
    );
  }

  @override
  String toString() {
    return 'QrResponse{qr: $qr, from: $from, to: $to, statusUser: $statusUser, messageUser: $messageUser, amount: $amount, status: $status, statusSAP: $statusSAP, message: $message, fecha: $fecha, hora: $hora, latitude: $latitude, longitude: $longitude, localDate: $localDate}';
  }
}
