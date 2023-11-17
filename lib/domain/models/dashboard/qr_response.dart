import 'dart:convert';
import '../../../data/entities/qr_response_entity.dart';

class QrResponse {
  late String? QR = '';
  late String? From = '';
  late String? To = '';
  late String? StatusUser = '';
  late String? MessageUser = '';
  late String? Ammount = '';
  late String? Status = '';
  late String? StatusSAP = '';
  late String? Message = '';
  late String? fecha = '';
  late String? hora = '';
  late String? Latitude = '';
  late String? Longitude = '';
  late String? LocalDate = '';


  QrResponse({
    required this.QR,
    required this.From,
    required this.To,
    required this.StatusUser,
    required this.MessageUser,
    required this.Ammount,
    required this.Status,
    required this.StatusSAP,
    required this.Message,
    required this.fecha,
    required this.hora,
    required this.Latitude,
    required this.Longitude,
    required this.LocalDate
  });


  Map<String, dynamic> toMap() => {
    'QR': QR,
    'From': From,
    'To': To,
    'StatusUser': StatusUser,
    'MessageUser': MessageUser,
    'Ammount': Ammount,
    'Status': Status,
    'StatusSAP': StatusSAP,
    'Message': Message,
    'fecha': fecha,
    'hora': hora,
    'Latitude': Latitude,
    'Longitude': Longitude,
    'LocalDate': LocalDate
  };

  String toJson() => jsonEncode(toMap());


  QrResponseEntity toQrResponseEntity() {
    return QrResponseEntity(
      QR: QR??'',
      From: From,
      To: To,
      StatusUser: StatusUser,
      MessageUser: MessageUser,
      Ammount: Ammount,
      Status: Status??'',
      StatusSAP: StatusSAP,
      Message: Message??'',
      Latitude: Latitude,
      Longitude: Longitude,
        LocalDate: LocalDate
    );
  }

  @override
  String toString() {
    return 'QrResponse{QR: $QR, From: $From, To: $To, StatusUser: $StatusUser, MessageUser: $MessageUser, Ammount: $Ammount, Status: $Status, StatusSAP: $StatusSAP, Message: $Message, fecha: $fecha, hora: $hora, Latitude: $Latitude, Longitude: $Longitude, Localdate: $LocalDate}';
  }
}
