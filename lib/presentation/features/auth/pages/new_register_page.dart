import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_save_scan/presentation/core/services/navigation_service.dart';
import 'package:qr_save_scan/presentation/features/auth/components/molecules/my_button_submit_gradient.dart';
import 'package:qr_save_scan/presentation/features/auth/pages/otp_validator_screen.dart';
import 'package:qr_save_scan/presentation/widgets/atoms/error_snackbar.dart';
import 'package:qr_save_scan/presentation/widgets/molecules/my_gradient_btn.dart';
import 'package:qr_save_scan/presentation/widgets/organisms/custom_sliver_appbar.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../bloc/btn/bloc_btn.dart';
import '../../../bloc/btn/bloc_btn_state.dart';
import '../../../core/services/authentication_service.dart';
import '../../../widgets/appbar_with_leading.dart';
import '../../../widgets/atoms/title_roboto16.dart';
import '../../../widgets/molecules/custom_checkbox_validator.dart';
import '../../business/pages/composite_terms_and_conditions.dart';
import '../bloc/bloc_sign_up.dart';
import '../components/molecules/my_button_submit.dart';
import 'otp_request_screen.dart';

class NewRegisterPage extends StatefulWidget {
  const NewRegisterPage({super.key});
  @override
  NewRegisterPageState createState() => NewRegisterPageState();
}

class NewRegisterPageState extends State<NewRegisterPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool isChecked = false;
  @override
  void dispose() {
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomSliverAppbar(
              title: translation(context)!.registration,
              leading: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 36.0),
                        child: TitleRoboto16(
                            title: translation(context)!.cell_phone_number),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          hintText:
                              translation(context)!.enter_cell_phone_number,
                          suffixIcon: const Icon(Icons.phone),
                        ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TitleRoboto16(
                            title: translation(context)!.password),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FancyPasswordField(
                      validationRules: {
                        DigitValidationRule(),
                        UppercaseValidationRule(),
                        LowercaseValidationRule(),
                        SpecialCharacterValidationRule(),
                        MinCharactersValidationRule(6),
                        MaxCharactersValidationRule(10),
                      },
                      controller: _passwordController,
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText:
                            translation(context)!.please_enter_your_password,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomCheckBoxValidator(
                      initialText: translation(context)!
                          .accept_the_terms_and_conditions,
                      isChecked: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      navigatorPage: const CompositeTermsAndConditionsScreen(),
                    ),
                  ),
                  BlocConsumer<BlocSignUp, SignUpState>(
                    listener: (context, state) {
                      if (state is SignUpSuccessState) {
                        NavigationService().navigateTo(
                          context,
                          BlocProvider.value(
                            value: BlocProvider.of<BlocSignUp>(context),
                            child: OtpValidatorScreen(
                              flujo: "register",
                              phone: _phoneNumberController.text,
                              password: _passwordController.text,
                            ),
                          ),
                        );
                      }
                      if (state is SignUpFailedState) {
                        MyErrorSnackBar(context: context, message: state.textButton).showSnackBar();
                      }
                    },
                    builder: (context, state) {
                      return MyGradientBtn(
                        onPressed: () {
                          debugPrint("boton presionado");
                          BlocProvider.of<BlocSignUp>(context).validateFields(
                              _phoneNumberController.text,
                              _passwordController.text, isChecked);
                        },
                        text: state.textButton,
                        icon: "assets/icons/next.svg",
                      );
                    },
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
