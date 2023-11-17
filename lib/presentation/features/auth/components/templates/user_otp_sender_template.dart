import 'package:flutter/material.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../widgets/appbar_with_leading.dart';
import '../organisms/user_otp_sender_form.dart';
import '../organisms/user_otp_sender_info.dart';

class UserOtpSenderTemplate extends StatefulWidget {
  const UserOtpSenderTemplate({super.key});

  @override
  State<UserOtpSenderTemplate> createState() => _UserOtpSenderTemplateState();
}

class _UserOtpSenderTemplateState extends State<UserOtpSenderTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWithLeading(
          title: translation(context)!.registration
      ).getAppBar(),
      body: Form(
        //key: GlobalKeyOtpSenderForm().otpSenderFormKey,
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: const [
              UserOtpSenderInfo(),
              UserOtpSenderForm(),
            ],
          ),
        ),
      ),
    );
  }
}
