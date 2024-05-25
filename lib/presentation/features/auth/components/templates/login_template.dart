import 'package:flutter/material.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../../presentation/widgets/organisms/custom_sliver_appbar.dart';
import '../organisms/login_sliver_body.dart';

class LoginTemplate extends StatefulWidget {
  const LoginTemplate({super.key});

  @override
  State<LoginTemplate> createState() => _LoginTemplateState();
}

class _LoginTemplateState extends State<LoginTemplate> {
  @override
  Widget build(BuildContext context) {
    String titleAppbar = translation(context)!.login;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSliverAppbar(title: titleAppbar,leading: false),
            const LoginSliverBody(),
          ],
        ),
      ),
    );
  }
}
