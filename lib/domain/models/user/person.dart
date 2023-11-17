import '../../../data/entities/person_entity.dart';

class Person {
  String uPan;
  String name;
  String code;
  String uMobileID;
  String language;
  String uPinCode;
  String uIDUPI;
  String uVehicle;

  Person({
    this.uPan = '',
    this.name = '',
    this.code = '',
    this.uMobileID = '',
    this.language = '',
    this.uPinCode = '',
    this.uIDUPI = '',
    this.uVehicle = '',
  });

  PersonEntity toPersonEntity() {
    return PersonEntity(
      pan: uPan,
      name: name,
      code: code,
      mobileId: uMobileID,
      language: language,
      pinCode: uPinCode,
      idupi: uIDUPI,
      vehicle: uVehicle,
    );
  }

  @override
  String toString() {
    return 'Person{uPan: $uPan, name: $name, code: $code, uMobileID: $uMobileID, language: $language, uPinCode: $uPinCode, uIDUPI: $uIDUPI, uVehicle: $uVehicle}';
  }
}
