import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcash/domain/models/business/business.dart';
import 'package:qrcash/presentation/atoms/error_snackbar.dart';
import 'package:qrcash/presentation/features/widgets/appbar_with_leading.dart';

import '../../../../data/entities/bank_response_entity.dart';
import '../../../../domain/constants/language_constants.dart';
import '../../../../domain/models/user/bank.dart';
import '../../../../domain/models/business/bank_manager.dart';
import '../../../../domain/models/user/user.dart';
import '../../../atoms/build_text_field.dart';
import '../../../core/services/user_service.dart';
import '../../auth/components/molecules/my_button_submit.dart';
import '../../bloc/btn/bloc_btn_state.dart';
import '../../bloc/btn/bloc_btn.dart';

class BankAccountInformation extends StatefulWidget {
  const BankAccountInformation({super.key, required this.banks});
  final BankManager banks;

  @override
  State<BankAccountInformation> createState() => _BankAccountInformationState();
}

class _BankAccountInformationState extends State<BankAccountInformation> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _accountNumberController =
  TextEditingController();
  final _ifscCodeController = TextEditingController();
  final TextEditingController _swiftCodeController = TextEditingController();
  final bool _isPaymentConsolidated = false;
  bool _isAgreed = false;
  String bankSelected = '';
  Bank formBank = Bank();
  String _codeBank = '';
  String _nameBank = '';

  @override
  void initState() {
    Bank dataBank = User.getInstance().bankData!;
    _fullNameController.text = dataBank.uBenfName!;
    _accountNumberController.text = dataBank.uAccount!;
    _ifscCodeController.text = dataBank.uIFSCCode!;
    _swiftCodeController.text = dataBank.uSwift!;
    BankResponseEntity? foundBank =
    (Business.getInstance().bankManager?.banks ?? []).firstWhere(
            (bank) => bank.code == dataBank.uBank,
        orElse: () => BankResponseEntity());
    setState(() {
      _codeBank = foundBank.code ?? '';
      _nameBank = foundBank.name ?? '';
    });
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _accountNumberController.dispose();
    _ifscCodeController.dispose();
    _swiftCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        appBar:
        MyAppBarWithLeading(title: translation(context)!.bank_information)
            .getAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.asset("assets/icons/bank_icon.png"),
                  )
                ],
              ),
              const SizedBox(height: 16),
              BuildTextField(
                controller: _fullNameController,
                label: translation(context)!.beneficiary_name,
                hint: User.getInstance()
                    .bankData!
                    .uBenfName
                    .toString()
                    .compareTo('null') ==
                    0
                    ? ''
                    : User.getInstance().bankData!.uBenfName.toString(),
              ),
              const SizedBox(height: 16),
              BuildTextField(
                controller: _accountNumberController,
                label: translation(context)!.bank_account_number,
                hint: User.getInstance()
                    .bankData!
                    .uAccount
                    .toString()
                    .compareTo('null') ==
                    0
                    ? ''
                    : User.getInstance().bankData!.uAccount.toString(),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _ifscCodeController,
                keyboardType: TextInputType.text,
                maxLength: 11,
                enabled: true,
                textCapitalization: TextCapitalization.characters,
                onChanged: (value) {
                  if (value.length >= 4) {
                    BankResponseEntity? foundBank =
                    (Business.getInstance().bankManager?.banks ?? [])
                        .firstWhere(
                            (bank) => bank.code == value.substring(0, 4),
                        orElse: () => BankResponseEntity());
                    setState(() {
                      _codeBank = foundBank.code ?? '';
                      _nameBank = foundBank.name ?? '';
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: translation(context)!.isfc_code,
                  hintText: User.getInstance()
                      .bankData!
                      .uIFSCCode
                      .toString()
                      .compareTo('null') ==
                      0
                      ? ''
                      : User.getInstance().bankData!.uIFSCCode.toString(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                    const BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(40),
                  margin: const EdgeInsets.all(40),
                  color: Colors.grey.withOpacity(0.2),
                  child: Center(
                      child: Text(
                        _nameBank,
                        textAlign: TextAlign.center,
                      ))),
              const SizedBox(height: 36),
              Row(
                children: [
                  Checkbox(
                    value: _isAgreed,
                    onChanged: (value) {
                      setState(() {
                        _isAgreed = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      translation(context)!
                          .i_agree_to_share_my_bank_account_information_to_receive_payments,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              BlocBuilder<MyBlocBtn, MyStateBtn>(
                builder: (context, state) {
                  return MyButtonSubmit(
                    onButtonPressed: () async {
                      if(_codeBank!=""&&_nameBank!=""){
                        _updateBankInfo();
                      }else{
                        MyErrorSnackBar(context: context, message: translation(context)!.select_your_bank).showSnackBar();
                        BlocProvider.of<MyBlocBtn>(context).cancelFetch();
                      }
                    },
                    label: translation(context)!.save_changes,
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateBankInfo() async {
    String fullName = _fullNameController.text.isEmpty
        ? User.getInstance().bankData!.uBenfName!
        : _fullNameController.text;
    String accountNumber = _accountNumberController.text.isEmpty
        ? User.getInstance().bankData!.uAccount!
        : _accountNumberController.text;
    String ifscCode = _ifscCodeController.text.isEmpty
        ? User.getInstance().bankData!.uIFSCCode!
        : _ifscCodeController.text;
    String swiftCode = _swiftCodeController.text.isEmpty
        ? User.getInstance().bankData!.uSwift!
        : _swiftCodeController.text;
    String codbank =
    _codeBank == '' ? User.getInstance().bankData!.uBank! : _codeBank;

    formBank.uBenfName = fullName;
    formBank.uAccount = accountNumber;
    formBank.uIFSCCode = ifscCode;
    formBank.uSwift = swiftCode;
    formBank.uBank = codbank;


    await UserService(context).updateBankData(formBank, _isAgreed);
  }
}
