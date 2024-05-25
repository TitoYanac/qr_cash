import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_save_scan/main.dart';
import 'package:qr_save_scan/presentation/features/auth/pages/login_screen.dart';
import 'package:qr_save_scan/presentation/features/auth/pages/splash_screen.dart';
import '../../../../../domain/constants/language_constants.dart';
import '../../../../core/services/authentication_service.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../widgets/atoms/text_atom.dart';
import '../../../../widgets/molecules/custom_checkbox_validator.dart';
import '../../../../widgets/molecules/my_gradient_btn.dart';
import '../../../../widgets/molecules/row_compose.dart';
import '../../../../widgets/organisms/custom_input_form.dart';
import '../../../business/pages/composite_terms_and_conditions.dart';
import '../../bloc/bloc_recovery.dart';
import '../../bloc/bloc_sign_up.dart';
import '../../pages/otp_validator_screen.dart';

class OtpRequestSliverBody extends StatefulWidget {
  const OtpRequestSliverBody(
      {super.key,
      required this.flujo,
      required this.phone,
      required this.password});
  final String flujo;
  final String phone;
  final String password;

  @override
  State<OtpRequestSliverBody> createState() => _OtpRequestSliverBodyState();
}

class _OtpRequestSliverBodyState extends State<OtpRequestSliverBody> {
  late final TextEditingController _phoneNumberController;
  late bool isChecked;
  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    isChecked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String initialMessage = translation(context)!.continue_;
    print(widget.flujo);
    double height = MediaQuery.of(context).size.height;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          SizedBox(height: height * 0.03),
          RowCompose(
            iconSvg: "assets/icons/user_phone.svg",
            text: translation(context)!.check_your_phone_number,
          ),
          SizedBox(height: height * 0.05),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
              child: TextAtom(
                text: translation(context)!
                    .listoil_sent_you_an_sms_to_verify_your_identity_enter_your_phone_number,
              ),
            ),
          ]),
          SizedBox(height: height * 0.05),
          CustomInputForm(
            label: translation(context)!.phone,
            type: TextInputType.phone,
            hintText: translation(context)!.enter_cell_phone_number,
            controller: _phoneNumberController,
            iconSuffix: "assets/icons/phone.svg",
            maxLength: 10,
          ),
          SizedBox(height: height * 0.05),
          CustomCheckBoxValidator(
            initialText: translation(context)!.accept_the_terms_and_conditions,
            isChecked: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value!;
              });
            },
            navigatorPage: const CompositeTermsAndConditionsScreen(),
          ),
          (widget.flujo == "register")
              ? BlocConsumer<BlocSignUp, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpSuccessState) {
                      NavigationService().navigateTo(
                          context,
                          OtpValidatorScreen(
                            flujo: widget.flujo,
                            phone: widget.phone,
                            password: widget.password,
                            /*blocSignUp:
                                  BlocProvider.of<BlocSignUp>(context)*/
                          ),);
                    }
                  },
                  builder: (context, state) {
                    return MyGradientBtn(
                      onPressed: () {
                        NavigationService().navigateToAndRemoveUntil(
                            context, const LoginScreen());
                      },
                      text: translation(context)!.finish,
                      icon: "assets/icons/hand.svg",
                    );
                  },
                )
              : BlocConsumer<BlocRecovery, RecoveryState>(
                  listener: (context, state) {
                    if (state is RecoverySuccessState) {
                      NavigationService().navigateTo(
                        context,
                        BlocProvider(
                          create: (context) => BlocRecovery(
                              AuthenticationService(context), initialMessage),
                          child: OtpValidatorScreen(
                            flujo: widget.flujo,
                            phone: _phoneNumberController.text,
                            password: widget.password,
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return MyGradientBtn(
                      onPressed: () {
                        if (isChecked &&
                            _phoneNumberController.text.isNotEmpty) {
                          BlocProvider.of<BlocRecovery>(context).sendOtp(
                              widget.flujo,
                              _phoneNumberController.text,
                              isChecked);
                        }
                      },
                      text: state.textButton,
                      icon: "assets/icons/next.svg",
                    );
                  },
                ),
          SizedBox(height: height * .25),
        ]),
      ),
    );
  }
}
