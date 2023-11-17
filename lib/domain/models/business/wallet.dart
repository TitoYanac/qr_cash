import 'dart:convert';

import '../../../data/entities/wallet_entity.dart';

class Wallet {
  final List<WalletEntity> entry;

  Wallet({
    required this.entry,
  });

  void addItem(WalletEntity item) {
    entry.add(item);
  }

  String toJson() {
    List<Map<String, dynamic>> entryList = entry.map((item) => item.toMap()).toList();
    return jsonEncode(entryList);
  }
}

