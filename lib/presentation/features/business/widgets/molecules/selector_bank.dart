import 'package:flutter/material.dart';

import '../../../../../data/entities/bank_response_entity.dart';
import '../../../../../domain/models/user/user.dart';

class BankSelector extends StatefulWidget {
  final List<BankResponseEntity> bankList;
  final Function(String) onBankSelected;

  const BankSelector({super.key, required this.bankList, required this.onBankSelected});

  @override
  State<BankSelector> createState() => _BankSelectorState();
}

class _BankSelectorState extends State<BankSelector> {
  String _selected = '0';
  @override
  void initState() {
    User user = User.getInstance();
    user.bankData!.uBank = 'HDFC';
    setState(() {
      _selected = (user.bankData!.uBank=='')?'0':user.bankData!.uBank!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.grey),

              borderRadius: BorderRadius.circular(8)
          ),
          child: DropdownButton<String>(
            value: _selected,
            padding: const EdgeInsets.all(8),
            isExpanded: true,
            underline: Container(),
            onChanged: (bank) {
              setState(() {
                _selected = bank??'0';
                widget.onBankSelected(bank??'0');
              });
            },
            items: widget.bankList.map<DropdownMenuItem<String>>(
                  (BankResponseEntity bank) {
                return DropdownMenuItem<String>(
                  value: bank.code,
                  child: Text(bank.name),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}