
import 'package:intl/intl.dart';
import '../../domain/models/dashboard/qr_response.dart';

class QrResponseEntity {
  String QR = '';
  String? From = '';
  String? To = '';
  String? StatusUser = '';
  String? MessageUser = '';
  String? Ammount = '';
  String Status = '';
  String? StatusSAP = '';
  String Message = '';
  String? Latitude = '';
  String? Longitude = '';
  String? LocalDate = '';

  QrResponseEntity({
    required this.QR,
    this.From = '',
    this.To = '',
    this.StatusUser,
    this.MessageUser,
    this.Ammount = '',
    required this.Status,
    this.StatusSAP = '',
    required this.Message,
    required this.Latitude,
    required this.Longitude, required this.LocalDate,
  });

  factory QrResponseEntity.fromJson(Map<String, dynamic> json) {
    print("estamos en QrResponse entity from json");

    return QrResponseEntity(
      QR: "${json['QR'] ?? ''}",
      From: "${json['From'] ?? ''}",
      To: "${json['To'] ?? ''}",
      StatusUser: "${json['StatusUser'] ?? ''}",
      MessageUser: "${json['MessageUser'] ?? ''}",
      Ammount: "${json['Ammount'] ?? ''}",
      Status: "${json['Status'] ?? ''}",
      StatusSAP: "${json['StatusSAP'] ?? ''}",
      Message: "${json['Message'] ?? ''}",
      Latitude: "${json['Latitude'] ?? ''}",
      Longitude: "${json['Longitude'] ?? ''}",
      LocalDate: "${json['LocalDate'] ?? ''}",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'QR': QR,
      'From': From,
      'To': To,
      'StatusUser': StatusUser,
      'MessageUser': MessageUser,
      'Ammount': Ammount,
      'Status': Status,
      'StatusSAP': StatusSAP,
      'Message': Message,
      'Latitude': Latitude,
      'Longitude': Longitude,
      'LocalDate': LocalDate
    };
  }

  QrResponse toQrResponse() {
    return QrResponse(
        QR: QR,
        From: From ?? '',
        To: To ?? '',
        StatusUser: StatusUser ?? '',
        MessageUser: MessageUser ?? '',
        Ammount: Ammount ?? '',
        Status: Status,
        StatusSAP: StatusSAP ?? '',
        Message: Message,
        fecha: DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
        hora: ("${DateTime.now()}").split(" ").last.toString(),
        Latitude: Latitude ?? '',
        Longitude: Longitude ?? '',
        LocalDate: LocalDate ?? '');
  }

  @override
  String toString() {
    return 'QrResponseEntity{QR: $QR, From: $From, To: $To, StatusUser: $StatusUser, MessageUser: $MessageUser, Ammount: $Ammount, Status: $Status, StatusSAP: $StatusSAP, Message: $Message, Latitude: $Latitude, Longitude: $Longitude, Localdate: $LocalDate}';
  }
}
