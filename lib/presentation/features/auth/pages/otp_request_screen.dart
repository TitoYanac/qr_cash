import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_save_scan/domain/constants/language_constants.dart';

import '../../../core/services/authentication_service.dart';
import '../bloc/bloc_recovery.dart';
import '../bloc/bloc_sign_up.dart';
import '../components/templates/otp_request_template.dart';

class OtpRequestScreen extends StatefulWidget {
  const OtpRequestScreen({super.key, required this.flujo, required this.phone, required this.password});
  final String flujo;
  final String phone;
  final String password;

  @override
  State<OtpRequestScreen> createState() => _OtpRequestScreenState();
}

class _OtpRequestScreenState extends State<OtpRequestScreen> {
  @override
  Widget build(BuildContext context) {
    String initialMessage = translation(context)!.continue_;
    return widget.flujo == "register"
        ? BlocProvider(
            create: (context) => BlocSignUp(AuthenticationService(context),initialMessage),
            lazy: true,
            child: OtpRequestTemplate(
              flujo: widget.flujo,
              phone: widget.phone,
                password: widget.password,
            ),
          )
        : BlocProvider.value(
      value: BlocProvider.of<BlocRecovery>(context),

            child: OtpRequestTemplate(
              flujo: widget.flujo,
              phone: widget.phone,
                password: widget.password,
            ),
          );
  }
}
