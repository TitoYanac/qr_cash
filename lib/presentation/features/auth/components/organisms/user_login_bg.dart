import 'package:flutter/material.dart';

import '../molecules/user_login_bg_p1.dart';
import '../molecules/user_login_bg_p2.dart';

class UserLoginBg extends StatefulWidget {
  const UserLoginBg({super.key});

  @override
  State<UserLoginBg> createState() => _UserLoginBgState();
}

class _UserLoginBgState extends State<UserLoginBg> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.red, Color.fromRGBO(86, 2, 14, 1)],
          ),
        ),
        child: const Column(
          children: [
            UserLoginBgP1(),
            UserLoginBgP2(),
          ],
        ),
      ),
    );
  }
}
