import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qrcash/presentation/atoms/text_atom.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../core/services/form_key_singleton.dart';
import '../../../core/services/human_validation_service.dart';
import '../../widgets/appbar.dart';

class UserHumanValidatorPage extends StatefulWidget {
  const UserHumanValidatorPage({Key? key}) : super(key: key);
  @override
  State<UserHumanValidatorPage> createState() => _UserHumanValidatorPageState();
}

class _UserHumanValidatorPageState extends State<UserHumanValidatorPage> {
  late int _randomNumber;
  final TextEditingController _numberInputController = TextEditingController();

  String _errorMessage = '';

  //TextEditingController textEditingController = TextEditingController();

  bool hasError = false;
  String currentText = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      _randomNumber = 1000 + Random().nextInt(9000);
      _errorMessage = '';
      _numberInputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "${translation(context)!.welcome}!",
        srcItem: "assets/icons/isotipo.png",
      ).getAppBar(),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Form(
            key: GlobalKeyHumanValidationForm().humanValidationFormKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/shield_icon.png",
                        width: MediaQuery.of(context).size.width * 0.25),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextAtom(
                        text:
                            "${translation(context)!.welcome_for_your_safety_enter_the_following_code_to_continue}:",
                        size: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _randomNumber.toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PinCodeTextField(
                        length: 4, // Longitud del PIN
                        appContext: context,
                        controller: _numberInputController,
                        keyboardType:
                            TextInputType.number, // Tipo de teclado numérico
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'[.,\- ]')),
                        ], //                        ],
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape
                              .box, // Forma del campo de entrada del PIN
                          borderRadius:
                              BorderRadius.circular(5), // Radio de las esquinas
                          fieldHeight:
                              60, // Altura del campo de entrada del PIN
                          fieldWidth: 60, // Ancho del campo de entrada del PIN
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
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _numberInputController,
                        keyboardType: TextInputType.number,
                        autocorrect: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 4,
                        autofocus: false,
                        onChanged: (e) => HumanValidationService(
                          context,
                          _randomNumber.toString(),
                          _numberInputController,
                        ).requestValidation(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return translation(context)!
                                .enter_the_displayed_number;
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return translation(context)!
                                .enter_only_numbers;
                          }
                          if (value.length != 4) {
                            return translation(context)!
                                .the_number_should_be_have_4_digits;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: translation(context)!.captcha_code,
                            filled: true,
                            fillColor: Colors.grey[300], // Color de fondo gris
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Bordes redondeados
                              borderSide: const BorderSide(
                                  color: Colors.grey), // Color del borde gris
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Bordes redondeados
                              borderSide: const BorderSide(
                                  color: Colors.grey), // Color del borde gris
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Bordes redondeados
                              borderSide: const BorderSide(
                                  color: Colors.grey), // Color del borde gris
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Bordes redondeados
                              borderSide: const BorderSide(
                                  color: Colors.grey), // Color del borde gris
                            ),
                            //prefixIcon: Icon(Icons.phone),
                            labelStyle: const TextStyle(color: Colors.black54)),
                        onTapOutside: (e) {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                  ],
                ),*/
                /*Container(
                  width: 200,
                  height: 400,
                  color: Colors.green,
                  child: Stack(
                    fit: StackFit.passthrough,
                    clipBehavior: Clip.hardEdge, // Asegúrate de tener esta línea
                    children: [
                      Transform.translate(
                        offset: const Offset(50, -450),
                        child: Transform.rotate(
                          angle: -45,
                          child: Container(
                            width: 200,
                            height: 400,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.orange,
                                  Colors.deepOrange,
                                ],
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    color: Colors.orange,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Colors.orangeAccent,
                                          Colors.deepOrange,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),*/

                const SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
