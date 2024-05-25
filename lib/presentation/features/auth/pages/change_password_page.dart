import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../bloc/btn/bloc_btn.dart';
import '../../../bloc/btn/bloc_btn_state.dart';
import '../../../core/services/authentication_service.dart';
import '../../../widgets/appbar_with_leading.dart';
import '../../../widgets/atoms/text_atom.dart';
import '../components/molecules/my_button_submit.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key, required this.number});
  final String number;

  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWithLeading(title: translation(context)!.change_password).getAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 40),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: Image.asset(
                  "assets/icons/candado_pass_icon.png",
                  height: 150,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextAtom(text:translation(context)!.password),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: FancyPasswordField(
                    validationRules: {
                      DigitValidationRule(),
                      UppercaseValidationRule(),
                      LowercaseValidationRule(),
                      SpecialCharacterValidationRule(),
                      MinCharactersValidationRule(6),
                      MaxCharactersValidationRule(10),
                    },
                    controller: _passwordController,
                    maxLength: 10,

                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextAtom(text:translation(context)!.confirm_password),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: FancyPasswordField(
                    controller: _confirmPasswordController,
                  ),
                ),
                const SizedBox(height: 40),
                BlocBuilder<MyBlocBtn, MyStateBtn>(
                  builder: (context, state) {
                    return MyButtonSubmit(
                      onButtonPressed: () async => await AuthenticationService(context).changePassword(widget.number, _passwordController.text, _confirmPasswordController.text),
                      label: translation(context)!.submit,
                      imagenIcon: Image.asset("assets/icons/mano_icon.png"),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class PasswordField extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const PasswordField({super.key, required this.label, required this.controller});

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                child: SizedBox(
                    width:100,child: Center(child: Icon(_obscurePassword ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash))),
              )

            ],
          ),
        ),
      ),
    );
  }
}
