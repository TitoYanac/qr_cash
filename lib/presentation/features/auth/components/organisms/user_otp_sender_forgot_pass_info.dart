import 'package:flutter/material.dart';
import 'package:qrcash/presentation/atoms/paragraph_component.dart';
import 'package:qrcash/presentation/atoms/title_component.dart';

import '../../../../../domain/constants/language_constants.dart';

class UserOtpSenderForgotPassInfo extends StatefulWidget {
  const UserOtpSenderForgotPassInfo({super.key});

  @override
  State<UserOtpSenderForgotPassInfo> createState() => _UserOtpSenderForgotPassInfoState();
}

class _UserOtpSenderForgotPassInfoState extends State<UserOtpSenderForgotPassInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 40),
              child: TitleComponent(translation(context)!.check_your_phone_number).render(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              width: MediaQuery.of(context).size.width * 0.24,
              child: Image.asset("assets/icons/no_cliente.png"),
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ParagraphComponent(translation(context)!.listoil_sent_you_an_sms_to_verify_your_identity_enter_your_phone_number).render(),
            ),
          ],
        ),

      ],
    );
  }
}
