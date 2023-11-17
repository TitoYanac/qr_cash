import '../../../data/entities/bank_entity.dart';
import 'user.dart';

class Bank {
  String? uBenfName;
  String? uAccount;
  String? uIFSCCode;
  String? uSwift;
  String? uBank;

  Bank({
    this.uBenfName='',
    this.uAccount='',
    this.uIFSCCode='',
    this.uSwift='',
    this.uBank='',
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      uBenfName: "${json['U_BenfName']??''}",
      uAccount: "${json['U_Account']??''}",
      uIFSCCode: "${json['U_IFSCCode']??''}",
      uSwift: "${json['U_Swift']??''}",
      uBank: "${json['U_Bank']??''}",
    );
  }

  BankEntity toBankEntity() {
    return BankEntity(
      code: User.getInstance().personData!.code,
      uBenfName: uBenfName,
      uAccount: uAccount,
      uIFSCCode: uIFSCCode,
      uSwift: uSwift,
      uBank: uBank,
    );
  }

  @override
  String toString() {
    return 'Bank{uBenfName: $uBenfName, uAccount: $uAccount, uIFSCCode: $uIFSCCode, uSwift: $uSwift, uBank: $uBank}';
  }
}
