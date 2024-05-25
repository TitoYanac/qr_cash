import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../data/entities/bank_response_entity.dart';
import '../../../../domain/constants/language_constants.dart';
import '../../../../domain/models/business/business.dart';
import '../../../../domain/models/user/bank.dart';
import '../../../../domain/models/business/bank_manager.dart';
import '../../../../domain/models/user/user.dart';
import '../../../widgets/atoms/build_text_field.dart';
import '../../../widgets/atoms/error_snackbar.dart';
import '../../../widgets/molecules/my_gradient_btn.dart';
import '../../../widgets/organisms/custom_sliver_appbar.dart';
import '../bloc/bloc_user.dart';

class BankAccountInformation extends StatefulWidget {
  const BankAccountInformation({super.key, required this.banks});
  final BankManager banks;

  @override
  State<BankAccountInformation> createState() => _BankAccountInformationState();
}

class _BankAccountInformationState extends State<BankAccountInformation> {
  final List<TextEditingController> _controllers =
      List.generate(5, (index) => TextEditingController());
  bool _isAgreed = false;
  Bank formBank = Bank();
  String bankSelected = '';
  String _codeBank = '';
  String _nameBank = '';

  @override
  void initState() {
    formBank = User.getInstance().bankData!;

    _controllers[0].text = formBank.uBenfName!;
    _controllers[1].text = formBank.uAccount!;
    _controllers[2].text = formBank.uIFSCCode!;
    _controllers[3].text = formBank.uSwift!;

    BankResponseEntity? foundBank =
        (Business.getInstance().bankManager?.banks ?? []).firstWhere(
            (bank) => bank.code == formBank.uBank,
            orElse: () => BankResponseEntity());

    _codeBank = foundBank.code;
    _nameBank = foundBank.name;

    super.initState();
  }

  @override
  void dispose() {
    _controllers[0].dispose();
    _controllers[1].dispose();
    _controllers[2].dispose();
    _controllers[3].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InputBorder borderStandar = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
    );
    return SafeArea(
      bottom: true,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomSliverAppbar(
              title: translation(context)!.bank_information,
              leading: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: SvgPicture.asset(
                            "assets/icons/bank.svg",
                            fit: BoxFit.contain,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.shadow,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    BuildTextField(
                      controller: _controllers[0],
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
                      controller: _controllers[1],
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
                      controller: _controllers[2],
                      keyboardType: TextInputType.text,
                      maxLength: 11,
                      enabled: true,
                      textCapitalization: TextCapitalization.characters,
                      onChanged: (value) {
                        if (value.length >= 4) {
                          BankResponseEntity? foundBank =
                              (Business.getInstance().bankManager?.banks ?? [])
                                  .firstWhere(
                                      (bank) =>
                                          bank.code == value.substring(0, 4),
                                      orElse: () => BankResponseEntity());
                          setState(() {
                            _codeBank = foundBank.code;
                            _nameBank = foundBank.name;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: translation(context)!.isfc_code,
                        hintText: User.getInstance()
                                .bankData!
                                .uIFSCCode!
                                .isEmpty
                            ? ''
                            : User.getInstance().bankData!.uIFSCCode.toString(),
                        border: borderStandar,
                        focusedBorder: borderStandar,
                        enabledBorder: borderStandar,
                        errorBorder: borderStandar,
                        focusedErrorBorder: borderStandar,
                      ),
                    ),
                    const SizedBox(height: 16),
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
                    MyGradientBtn(
                      onPressed: () async {
                        Bank updatedBank = _updateBankInfo();
                        openLoadingDialog(
                            context, BlocProvider.of<BlocUser>(context));
                        BlocProvider.of<BlocUser>(context)
                            .updateBankData(updatedBank);
                      },
                      text: translation(context)!.submit,
                      icon: "assets/icons/mano.svg",
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool esNombreValido(String nombre) {
    // Expresión regular que permite letras de a-z (mayúsculas y minúsculas),
    // caracteres del alfabeto hindi, y caracteres comunes en nombres como diéresis y tildes
    final RegExp regex = RegExp(r'^[a-zA-Z\u0900-\u097F\u00C0-\u00FF\s]+$');
    return regex.hasMatch(nombre);
  }

  bool validateBankAccountNumber(String input) {
    // Expresión regular para validar el número de cuenta bancaria
    RegExp regExp = RegExp(r"^[0-9]{9,18}$");

    // Verificar si la entrada coincide con la expresión regular
    if (regExp.hasMatch(input) && !input.contains(" ")) {
      return true;
    } else {
      return false;
    }
  }

  bool esValidoIFSC(String ifsc) {
    // Expresión regular para validar el código IFSC
    final RegExp regexIFSC = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');

    if (ifsc.isEmpty) {
      return false;
    } else {
      return regexIFSC.hasMatch(ifsc);
    }
  }

  Bank _updateBankInfo() {
    if (esNombreValido(_controllers[0].text) == false) {
      MyErrorSnackBar(
              context: context,
              message:
                  "${translation(context)!.in_the_field_name}\n${translation(context)!.please_enter_only_alphabet_letters}")
          .showSnackBar();
      return throw Exception();
    }
    if (validateBankAccountNumber(_controllers[1].text) == false) {
      MyErrorSnackBar(
              context: context,
              message:
                  translation(context)!.incorrect_bank_account_number_format)
          .showSnackBar();
      return throw Exception();
    }
    if (esValidoIFSC(_controllers[2].text) == false) {
      MyErrorSnackBar(
              context: context,
              message: translation(context)!.incorrect_isfc_code_format)
          .showSnackBar();
      return throw Exception();
    }
    if (_isAgreed == false) {
      MyErrorSnackBar(
              context: context, message: translation(context)!.accept_the_terms)
          .showSnackBar();
      return throw Exception();
    }
    String fullName = _controllers[0].text.isEmpty
        ? User.getInstance().bankData!.uBenfName!
        : _controllers[0].text;
    String accountNumber = _controllers[1].text.isEmpty
        ? User.getInstance().bankData!.uAccount!
        : _controllers[1].text;
    String ifscCode = _controllers[2].text.isEmpty
        ? User.getInstance().bankData!.uIFSCCode!
        : _controllers[2].text;
    String swiftCode = _controllers[3].text.isEmpty
        ? User.getInstance().bankData!.uSwift!
        : _controllers[3].text;
    String codbank =
        _codeBank == '' ? User.getInstance().bankData!.uBank! : _codeBank;

    formBank.uBenfName = fullName;
    formBank.uAccount = accountNumber;
    formBank.uIFSCCode = ifscCode;
    formBank.uSwift = swiftCode;
    formBank.uBank = codbank;

    return formBank;
    //await UserService(context).updateBankData(formBank);
  }

  Future<void> openLoadingDialog(
      BuildContext context, BlocUser blocUser) async {
    // Muestra el modal de carga
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: BlocProvider.value(
              value: blocUser,
              child:
                  BlocBuilder<BlocUser, UserState>(builder: (context, state) {
                if (state is AuthenticatedSuccessState ||
                    state is AuthenticatedErrorState) {
                  Navigator.pop(context);
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20.0),
                    SpinKitPouringHourGlassRefined(
                      color: Theme.of(context).colorScheme.primary,
                      size: 50.0,
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "${translation(context)!.running_process}...",
                    ),
                  ],
                );
              })),
        );
      },
    );

  }
}
