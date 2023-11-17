import 'package:flutter/material.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../atoms/big_title_component.dart';
class UserLoginBgP1 extends StatefulWidget {
  const UserLoginBgP1({super.key});

  @override
  State<UserLoginBgP1> createState() => _UserLoginBgP1State();
}

class _UserLoginBgP1State extends State<UserLoginBgP1> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                  height: 80,
                  child: Image.asset("assets/icons/candado_blanco.png",)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              BigTitleComponent(translation(context)!.login).render(),
            ],
          ),
        ],
      ),
    );
  }
}
