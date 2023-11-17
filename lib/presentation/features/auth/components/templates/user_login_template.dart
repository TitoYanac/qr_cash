import 'package:flutter/material.dart';

import '../organisms/user_login_bg.dart';
import '../organisms/user_login_form.dart';

class UserLoginTemplate extends StatefulWidget {
  const UserLoginTemplate({super.key});

  @override
  State<UserLoginTemplate> createState() => _UserLoginTemplateState();
}

class _UserLoginTemplateState extends State<UserLoginTemplate> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          UserLoginBg(),
          UserLoginForm(),
        ],
      ),
    );
  }
}
