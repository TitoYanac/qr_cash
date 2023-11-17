import 'dart:convert';


import '../../domain/models/user/bank.dart';
import '../../domain/models/user/user.dart';

class BankEntity {
  String? code='';
  String? uBenfName='';
  String? uAccount='';
  String? uIFSCCode='';
  String? uSwift='';
  String? uBank='';

  BankEntity({
    this.code='',
    this.uBenfName='',
    this.uAccount='',
    this.uIFSCCode='',
    this.uSwift='',
    this.uBank='',
  });

  factory BankEntity.fromJson(Map<String, dynamic>? json) {
    return json!=null?BankEntity(
      code: "${json['code'] ?? ''}",
      uBenfName: "${json['U_BenfName'] ?? ''}",
      uAccount: "${json['U_Account'] ?? ''}",
      uIFSCCode: "${json['U_IFSC'] ?? ''}",
      uSwift: "${json['U_Swift'] ?? ''}",
      uBank: "${json['U_Bank'] ?? ''}",
    ):BankEntity();
  }

  Map<String, dynamic> toMap() {
    return {
      'code': User.getInstance().personData!.uMobileID,
      'U_BenfName': uBenfName,
      'U_Account': uAccount,
      'U_IFSCCode': uIFSCCode,
      'U_Swift': uSwift,
      'U_Bank': uBank,
    };
  }

  String toJson() => jsonEncode(toMap());

  Bank toBank() {
    return Bank(
      uBenfName: uBenfName,
      uAccount: uAccount,
      uIFSCCode: uIFSCCode,
      uSwift: uSwift,
      uBank: uBank,
    );
  }

  @override
  String toString() {
    return 'BankEntity{code: $code, uBenfName: $uBenfName, uAccount: $uAccount, uIFSCCode: $uIFSCCode, uSwift: $uSwift, uBank: $uBank}';
  }
}
