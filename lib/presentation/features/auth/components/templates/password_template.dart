import 'package:flutter/material.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../widgets/organisms/custom_sliver_appbar.dart';
import '../organisms/password_sliver_body.dart';

class PasswordTemplate extends StatefulWidget {
  const PasswordTemplate({super.key, required this.flujo, required this.phone});
  final String flujo;
  final String phone;

  @override
  State<PasswordTemplate> createState() => _PasswordTemplateState();
}

class _PasswordTemplateState extends State<PasswordTemplate> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          CustomSliverAppbar(
            title: (widget.flujo == "register")
                ? translation(context)!.registration
                : translation(context)!.new_password,
            leading: true,
          ),
          PasswordSliverBody(
            flujo: widget.flujo,
            phone: widget.phone,
          ),
        ],
      )),
    );
  }
}
