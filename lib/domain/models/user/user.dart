import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../data/entities/user_entity.dart';
import '../../../presentation/widgets/atoms/error_snackbar.dart';
import 'bank.dart';
import 'person.dart';

class User {
  String? status = "0";
  String? message = "";
  String? imageUrl = "";
  Person? personData = Person();
  Bank? bankData = Bank();

  // Singleton instance
  static User? _instance;

  // Private constructor
  User._internal({
    this.status,
    this.message,
    this.imageUrl,
    this.personData,
    this.bankData,
  });

  // Singleton factory constructor
  factory User.getInstance({
    String? status,
    String? message,
    String? imageUrl,
    Person? personData,
    Bank? bankData,
  }) {
    _instance ??= User._internal(
      status: status,
      message: message,
      imageUrl: imageUrl,
      personData: personData,
      bankData: bankData,
    );
    return _instance!;
  }

  UserEntity toEntity() {
    return UserEntity(
      status: status,
      message: message,
      imageUrl: imageUrl,
    );
  }

  @override
  String toString() {
    return '{status: $status, message: $message, imageUrl: $imageUrl, personData: ${personData?.toPersonEntity().toJson()}, bankData: ${bankData?.toBankEntity().toJson()}';
  }

  Map<String, dynamic> toMap() {
    return {
      'Status': status,
      'Message': message,
      'imageUrl': imageUrl,
    };
  }

  String toJson() => jsonEncode(toMap());

  String toFullJson() {
    String generalData = jsonEncode({
      "Code": personData!.code,
      "Name": personData!.name,
      "U_MobileID": personData!.uMobileID,
      "U_PAN": personData!.uPan,
      "U_PinCode": personData!.uPinCode,
      "U_Vehicle": personData!.uVehicle,
      "U_Language": personData!.language,
      "U_IDUPI": personData!.uIDUPI,
      "U_BenfName": bankData!.uBenfName,
      "U_Account": bankData!.uAccount,
      "U_IFSCCode": bankData!.uIFSCCode,
      "U_Swift": bankData!.uSwift,
      "U_Bank": bankData!.uBank,
      "U_UserURL": imageUrl
    });
    return generalData;
  }

  Future<void> buildNetworkImage(BuildContext context) async{

    if(imageUrl != null && imageUrl != ""){
      await precacheImage(
        NetworkImage(User.getInstance().imageUrl.toString()),
        context,
        onError: (exception, stackTrace) {
          MyErrorSnackBar(context: context, message: "Error al cargar la imagen de usuario: $exception").showSnackBar();
        },
      );
    }
  }

}
