import 'package:flutter/material.dart';
import 'package:qrcash/presentation/atoms/paragraph_atom.dart';
import 'package:qrcash/presentation/atoms/paragraph_component.dart';
import 'package:qrcash/presentation/atoms/title_component.dart';
import 'package:qrcash/presentation/core/services/navigation_service.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../atoms/label_link_component.dart';
import '../../../../core/services/authentication_service.dart';
import '../../../../core/services/form_key_singleton.dart';
import '../../../auth/pages/user_otp_sender_page.dart';
import '../../../auth/pages/user_otp_sender_page_forgot_pass.dart';
import '../molecules/my_button_submit_gradient.dart';
import '../molecules/my_input_form_pass.dart';
import '../molecules/my_input_form_phone.dart';


class UserLoginForm extends StatefulWidget {
  const UserLoginForm({super.key});
  @override
  State<UserLoginForm> createState() =>
      _UserLoginFormState();
}

class _UserLoginFormState extends State<UserLoginForm> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget decorationBar = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150,
          height: 4,
          color: Colors.grey,
        ),
      ],
    );
    Widget userInput = MyInputFormPhone(
      phoneNumberController: _phoneNumberController,
    );
    Widget buttonForgotPass = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 20),
          child: TextButton(
            onPressed: () {
              NavigationService().navigateTo(context, const UserOtpSenderPageForgotPass());
            },
            child: LabelLinkComponent(translation(context)!.forgot_password).render(),
          ),
        ),
      ],
    );
    Widget labelRegister = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 20),
          child: LabelLinkComponent(translation(context)!.dont_have_an_account_yet).render(),
        ),
      ],
    );
    Widget passInput = MyInputFormPass(
      passwordController: _passwordController,
    );
    Widget buttonLogin = Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        MyButtonSubmitGradient(
          label: translation(context)!.login,
          onButtonPressed: () => AuthenticationService(context)
              .loginService(_phoneNumberController.text,_passwordController.text),
        ),
      ],
    );
    Widget buttonRegister = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 20),
          child: TextButton(
            onPressed: () =>NavigationService().navigateTo(context, const UserOtpSenderPage()),
            child: TitleComponent('→ ${translation(context)!.sing_up}').render(),
          ),
        ),
      ],
    );
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.12,
      maxChildSize: 0.7,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              decorationBar,
              const SizedBox(height: 30),
              userInput,
              const SizedBox(height: 20),
              passInput,
              buttonForgotPass,

              const SizedBox(height: 40),
              buttonLogin,
              const SizedBox(height: 20),
              labelRegister,
              buttonRegister,
            ],
          ),
        );
      },
    );
  }
}
