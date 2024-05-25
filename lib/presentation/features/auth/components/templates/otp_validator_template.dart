import 'package:flutter/material.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../widgets/organisms/custom_sliver_appbar.dart';
import '../organisms/otp_validator_sliver_body.dart';

class OtpValidatorTemplate extends StatefulWidget {
  const OtpValidatorTemplate({super.key, required this.flujo, required this.phone, required this.password});
  final String flujo;
  final String phone;
  final String password;

  @override
  State<OtpValidatorTemplate> createState() => _OtpValidatorTemplateState();
}

class _OtpValidatorTemplateState extends State<OtpValidatorTemplate> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomSliverAppbar(title: translation(context)!.otp, leading: true,),
            OtpValidatorSliverBody(flujo: widget.flujo, phone: widget.phone,password: widget.password),
          ],
        )
      ),
    );
  }
}
