import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../core/services/form_key_singleton.dart';
import '../../../core/services/human_validation_service.dart';
import '../../widgets/appbar.dart';

class UserHumanValidatorPage extends StatefulWidget {
  const UserHumanValidatorPage({Key? key}) : super(key: key);
  @override
  State<UserHumanValidatorPage> createState() => _UserHumanValidatorPageState();
}

class _UserHumanValidatorPageState extends State<UserHumanValidatorPage>
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
  void dispose() {
    _numberInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final traductor = translation(context)!;
    final String welcomeTitle = traductor.welcome;
    final String welcomeText =
        traductor.welcome_for_your_safety_enter_the_following_code_to_continue;

    return Scaffold(
      appBar: MyAppBar(
        title: "$welcomeTitle!",
        srcItem: "assets/icons/isotipo.png",
      ).getAppBar(),
      body: Form(
        key: GlobalKeyHumanValidationForm().humanValidationFormKey,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).size.height * 0.1,),

            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    width: MediaQuery.of(context).size.width*0.8,
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/icons/shield_icon.png",
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 80.0),
                    child: Text(
                      welcomeText,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      _randomNumber.toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 40.0),
                    child: PinCodeTextField(
                      length: 4,
                      appContext: context,
                      controller: _numberInputController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'[.,\- ]')),
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
            SliverFillRemaining(
              fillOverscroll: false,
              hasScrollBody: false,
              child: Container(color: Colors.transparent,),
            )
          ],
        ),
      ),
    );
  }
}
