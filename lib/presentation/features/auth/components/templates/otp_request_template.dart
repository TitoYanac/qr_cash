import 'package:flutter/material.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../widgets/organisms/custom_sliver_appbar.dart';
import '../organisms/otp_request_sliver_body.dart';

class OtpRequestTemplate extends StatefulWidget {
  const OtpRequestTemplate({super.key, required this.flujo, required this.phone,required this.password});
  final String flujo;
  final String phone;
  final String password;

  @override
  State<OtpRequestTemplate> createState() => _OtpRequestTemplateState();
}

class _OtpRequestTemplateState extends State<OtpRequestTemplate> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomSliverAppbar(
              title: widget.flujo == "register"
                  ? translation(context)!.registration
                  : translation(context)!.password_recovery,
              leading: true,
            ),
            OtpRequestSliverBody(
              flujo: widget.flujo,
              phone: widget.phone,
                password: widget.password,
            ),
          ],
        ),
      ),
    );
  }
}
