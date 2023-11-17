import 'dart:convert';

import '../../../data/entities/bank_response_entity.dart';

class BankManager {
  final List<BankResponseEntity> banks;

  BankManager({
    required this.banks,
  });

  void addBank(BankResponseEntity item) {
    banks.add(item);
  }

  String toJsonString() {
    List bankListJson = banks.map((bank) => bank.toJson()).toList();
    Map<String, dynamic> banksJson = {'banks': bankListJson};
    return jsonEncode(banksJson);
  }

  factory BankManager.fromJsonString(String jsonString) {
    Map<String, dynamic> banksJson = jsonDecode(jsonString);
    List<dynamic> bankListJson = banksJson['banks'];
    List<BankResponseEntity> bankList =
    bankListJson.map((bankJson) => BankResponseEntity.fromJson(bankJson)).toList();
    return BankManager(banks: bankList);
  }
}