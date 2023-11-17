import 'dart:convert';

import '../../domain/models/user/person.dart';

class PersonEntity {
  String code;
  String name;
  String mobileId;
  String pan;
  String pinCode;
  String vehicle;
  String language;
  String idupi;

  PersonEntity({
    this.code = '',
    this.name = '',
    this.mobileId = '',
    this.pan = '',
    this.pinCode = '',
    this.vehicle = '',
    this.language = '',
    this.idupi = '',
  });

  factory PersonEntity.fromJson(Map<String, dynamic>? json) {
    return json!=null?PersonEntity(
      code : "${json['Code'] ?? ''}",
      name : "${json['Name'] ?? ''}",
      mobileId : "${json['U_MobileID'] ?? ''}",
      pan : "${json['U_PAN'] ?? ''}",
      pinCode : "${json['U_PinCode'] ?? ''}",
      vehicle : "${json['U_Vehicle'] ?? ''}",
      language : "${json['U_Language'] ?? ''}",
      idupi : "${json['U_IDUPI'] ?? ''}",):PersonEntity();
  }

  Map<String, dynamic> toMap() {
    return {
      'Code': code,
      'Name': name,
      'U_MobileID': mobileId,
      'U_PAN': pan,
      'U_PinCode': pinCode,
      'U_Vehicle': vehicle,
      'U_Language': language,
      'U_IDUPI': idupi,
    };
  }

  String toJson() => jsonEncode(toMap());

  Person toPerson() {
    return Person(
      uPan: pan,
      name: name,
      code: code,
      uMobileID: mobileId,
      language: language,
      uPinCode: pinCode,
      uIDUPI: idupi,
      uVehicle: vehicle,
    );
  }

  @override
  String toString() {
    return 'PersonEntity{code: $code, name: $name, mobileId: $mobileId, pan: $pan, pinCode: $pinCode, vehicle: $vehicle, language: $language, idupi: $idupi}';
  }
}
