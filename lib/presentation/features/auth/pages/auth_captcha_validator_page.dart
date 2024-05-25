import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../core/services/form_key_singleton.dart';
import '../../../core/services/human_validation_service.dart';
import '../../../widgets/atoms/text_atom.dart';
import '../../../widgets/organisms/custom_sliver_appbar.dart';

class AuthCaptchaValidatorPage extends StatefulWidget {
  const AuthCaptchaValidatorPage({super.key});
  @override
  State<AuthCaptchaValidatorPage> createState() =>
      _AuthCaptchaValidatorPageState();
}

class _AuthCaptchaValidatorPageState extends State<AuthCaptchaValidatorPage>
    with SingleTickerProviderStateMixin {
  late final int _randomNumber;
  late final TextEditingController _numberInputController;

  late bool hasError;
  late String currentText;

  @override
  void initState() {
    super.initState();
    _randomNumber = 1000 + Random().nextInt(9000);
    currentText = "";
    _numberInputController = TextEditingController();
    hasError = false;
  }

  @override
  Widget build(BuildContext context) {
    final traductor = translation(context)!;
    final String welcomeTitle = traductor.welcome;
    final String welcomeText =
        traductor.welcome_for_your_safety_enter_the_following_code_to_continue;

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: GlobalKeyHumanValidationForm().humanValidationFormKey,
          child: CustomScrollView(
            slivers: [
              CustomSliverAppbar(
                title: "$welcomeTitle!",
                leading: false,
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: MediaQuery.of(context).size.height * 0.1),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: Image.asset(
                              "assets/icons/escudo.png",
                              width: MediaQuery.of(context).size.width * 0.14,
                            ),
                          ),
                          Expanded(
                            child: TextAtom(
                              text: welcomeText,
                              align: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: TextAtom(
                          text:_randomNumber.toString(),
                          size: 50,
                          weight: FontWeight.bold,
                          align: TextAlign.center,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: PinCodeTextField(
                          length: 4,
                          appContext: context,
                          controller: _numberInputController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                                RegExp(r'[.,\- ]')),
                          ],
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 60,
                            fieldWidth: 60,
                          ),
                          onChanged: (pin) {
                            if (pin.length == 4) {
                              HumanValidationService(
                                context,
                                _randomNumber.toString(),
                                _numberInputController,
                              ).requestValidation();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
