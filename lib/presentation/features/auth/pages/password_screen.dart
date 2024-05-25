import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_recovery.dart';
import '../bloc/bloc_sign_up.dart';
import '../components/templates/password_template.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key, required this.flujo, this.blocSignUp, this.blocRecovery, required this.phone});
  final String phone;
  final String flujo;
  final BlocSignUp? blocSignUp;
  final BlocRecovery? blocRecovery;

  @override
  State<StatefulWidget> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.flujo == "register"?
    BlocProvider.value(
      value: widget.blocSignUp!,
      child: PasswordTemplate(
        flujo: widget.flujo,
        phone: widget.phone,
      ),
    ):
    BlocProvider.value(
      value: widget.blocRecovery!,
      child: PasswordTemplate(
        flujo: widget.flujo,
        phone: widget.phone,
      )
    );
  }
}
