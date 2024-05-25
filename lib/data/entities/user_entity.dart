import 'dart:convert';

import '../../domain/models/user/bank.dart';
import '../../domain/models/user/person.dart';
import '../../domain/models/user/user.dart';
import 'bank_entity.dart';
import 'person_entity.dart';

class UserEntity {
  String? status = '';
  String? message = '';
  String? imageUrl = '';

  UserEntity({
    this.status = '',
    this.message = '',
    this.imageUrl = '',
  });

  UserEntity.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      status = "${json['Status'] ?? ''}";
      message = "${json['Message'] ?? ''}";
      imageUrl = "${json['U_UserURL'] ?? ''}";
    }
  }
  Map<String, dynamic> toMap() {
    return {
      'Status': status,
      'Message': message,
      'U_UserURL': imageUrl,
    };
  }

  String toJson() => jsonEncode(toMap());

  User toUser() {
    User? user = User.getInstance();
    user.status = status ?? '';
    user.message = message ?? '';
    user.imageUrl = imageUrl ?? '';
    return user;
  }

  @override
  String toString() {
    return 'UserEntity{status: $status, message: $message, imageUrl: $imageUrl}';
  }

  Future<User> saveLoginData(Map<String, dynamic> responseData, String phoneNumber) async {
    User user = UserEntity.fromJson(responseData).toUser();
    user.personData = Person(uVehicle: "",uPinCode: "",uIDUPI: "",uPan: "",name: "",uMobileID: phoneNumber,language: "",code: phoneNumber);
    user.bankData = Bank(uAccount: "",uBank: "",uBenfName: "",uIFSCCode: "",uSwift: "");
    return user;
  }

  Future<User> saveModelFromApiData(Map<String, dynamic> responseData) async {
    User user = User.getInstance();
    user.personData = PersonEntity.fromJson(responseData).toPerson();
    user.bankData = BankEntity.fromJson(responseData).toBank();
    user.imageUrl = "${responseData['U_UserURL'] ?? ''}";
    user.status = '1';
    user.message = 'Successful login';
    return  user;
  }

  Future<User> saveUpdateUserData(responseData)async {
    User user = User.getInstance();
    UserEntity userEntity = UserEntity.fromJson(responseData);
    user = userEntity.toUser();
    return user;
  }

  Future<User> saveUpdateBankData(BankEntity bankEntity) async {
    User user = User.getInstance();
    user.bankData = bankEntity.toBank();
    return user;
  }

  Future<User> saveUpdatePersonData(PersonEntity personEntity) async{
    User user = User.getInstance();
    user.personData = personEntity.toPerson();
    return user;
  }
}
