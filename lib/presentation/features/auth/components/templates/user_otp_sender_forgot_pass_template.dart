import 'package:flutter/material.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../widgets/appbar_with_leading.dart';
import '../organisms/user_otp_sender_forgot_pass_form.dart';
import '../organisms/user_otp_sender_forgot_pass_info.dart';

class UserOtpSenderForgotPassTemplate extends StatefulWidget {
  const UserOtpSenderForgotPassTemplate({super.key});

  @override
  State<UserOtpSenderForgotPassTemplate> createState() => _UserOtpSenderForgotPassTemplateState();
}

class _UserOtpSenderForgotPassTemplateState extends State<UserOtpSenderForgotPassTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWithLeading(
          title: translation(context)!.password_recovery
      ).getAppBar(),
      body: Form(
        //key: GlobalKeyOtpSenderForm().otpSenderFormKey,
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: const [
              UserOtpSenderForgotPassInfo(),
              UserOtpSenderForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}
