import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_recovery.dart';
import '../components/templates/otp_validator_template.dart';

class OtpValidatorScreen extends StatefulWidget {
  const OtpValidatorScreen({super.key, required this.flujo, required this.phone, required this.password});
  final String flujo;
  final String phone;
  final String password;
  @override
  State<OtpValidatorScreen> createState() => _OtpValidatorScreenState();
}

class _OtpValidatorScreenState extends State<OtpValidatorScreen> {
  @override
  Widget build(BuildContext context) {

    return widget.flujo == "register"
        ? OtpValidatorTemplate(
          flujo: widget.flujo,
      phone: widget.phone,
        password: widget.password,
        )
        : BlocProvider.value(
            value: BlocProvider.of<BlocRecovery>(context),
            child: OtpValidatorTemplate(
              flujo: widget.flujo,
              phone: widget.phone,
              password: widget.password,
            ),
          );
  }
}
