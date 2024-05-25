import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_save_scan/presentation/features/auth/pages/login_screen.dart';
import 'package:qr_save_scan/presentation/features/business/pages/composite_use_terms.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../widgets/atoms/text_atom.dart';
import '../../../../widgets/molecules/custom_checkbox_validator.dart';
import '../../../../widgets/molecules/my_gradient_btn.dart';
import '../../../../widgets/molecules/row_compose.dart';
import '../../../../widgets/organisms/custom_input_form.dart';
import '../../bloc/bloc_recovery.dart';
import '../../bloc/bloc_sign_up.dart';
import '../../pages/password_screen.dart';

class OtpValidatorSliverBody extends StatefulWidget {
  const OtpValidatorSliverBody(
      {super.key,
      required this.flujo,
      required this.phone,
      required this.password});
  final String flujo;
  final String phone;
  final String password;

  @override
  State<OtpValidatorSliverBody> createState() => _OtpValidatorSliverBodyState();
}

class _OtpValidatorSliverBodyState extends State<OtpValidatorSliverBody> {
  late final TextEditingController _otpController;
  late bool isChecked;
  @override
  void initState() {
    _otpController = TextEditingController();
    isChecked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          SizedBox(height: height * 0.03),
          RowCompose(
            iconSvg: "assets/icons/phone.svg",
            text: translation(context)!.otp_sent_by_sms,
          ),
          SizedBox(height: height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: TextAtom(
                  text: translation(context)!.enter_the_6_digit_code,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.05),
          CustomInputForm(
            label: translation(context)!.code_otp,
            type: TextInputType.number,
            hintText: translation(context)!.enter_code,
            controller: _otpController,
            iconSuffix: "assets/icons/phone.svg",
            maxLength: 6,
          ),
          SizedBox(height: height * 0.05),
          CustomCheckBoxValidator(
              initialText: translation(context)!
                  .by_joining_you_agree_to_the_privacy_policy_and_terms_of_use,
              //resaltedText: translation(context)!.p_p_privacy_policy,
              isChecked: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              },
              navigatorPage: const CompositeUseTerms()),
          SizedBox(height: height * 0.05),
          (widget.flujo == "register")
              ? BlocConsumer<BlocSignUp, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpSuccessState) {
                      NavigationService().navigateToAndRemoveUntil(
                          context, const LoginScreen());
                    }
                  },
                  builder: (context, state) {
                    return MyGradientBtn(
                      onPressed: () {
                        if (_otpController.text.isNotEmpty) {
                          BlocProvider.of<BlocSignUp>(context).validateOtp(
                              widget.flujo,
                              _otpController.text,
                              isChecked,
                              widget.phone,
                              widget.password);
                        }
                      },
                      text: state.textButton == translation(context)!.continue_
                          ? translation(context)!.finish
                          : state.textButton,
                      icon: "assets/icons/hand.svg",
                    );
                  },
                )
              : BlocConsumer<BlocRecovery, RecoveryState>(
                  listener: (context, state) {
                    if (state is RecoverySuccessState) {
                      NavigationService().navigateTo(
                          context,
                          PasswordScreen(
                              flujo: widget.flujo,
                              phone: widget.phone,
                              blocRecovery:
                                  BlocProvider.of<BlocRecovery>(context)));
                    }
                  },
                  builder: (context, state) {
                    return MyGradientBtn(
                      onPressed: () {
                        if (isChecked && _otpController.text.isNotEmpty) {
                          BlocProvider.of<BlocRecovery>(context).validateOtp(
                              widget.flujo,
                              _otpController.text,
                              isChecked,
                              widget.phone);
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
