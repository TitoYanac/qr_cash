import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/constants/language_constants.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../widgets/atoms/text_atom.dart';
import '../../../../widgets/molecules/my_gradient_btn.dart';
import '../../../../widgets/molecules/row_compose.dart';
import '../../../../widgets/organisms/custom_input_form.dart';
import '../../bloc/bloc_recovery.dart';
import '../../bloc/bloc_sign_up.dart';
import '../../pages/login_screen.dart';

class PasswordSliverBody extends StatefulWidget {
  const PasswordSliverBody({
    super.key,
    required this.flujo,
    required this.phone,
  });
  final String flujo;
  final String phone;

  @override
  State<PasswordSliverBody> createState() => _PasswordSliverBodyState();
}

class _PasswordSliverBodyState extends State<PasswordSliverBody> {
  late final TextEditingController _passwordController1;
  late final TextEditingController _passwordController2;
  late bool hasDigit;
  late bool hasLowerCase;
  late bool hasUpperCase;
  late bool hasSpecialCharacter;
  late bool hasMin6;
  late bool hasMax10;

  @override
  void dispose() {
    _passwordController1.dispose();
    _passwordController2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _passwordController1 = TextEditingController();
    _passwordController2 = TextEditingController();
    hasDigit = false;
    hasLowerCase = false;
    hasUpperCase = false;
    hasSpecialCharacter = false;
    hasMin6 = false;
    hasMax10 = false;
    _passwordController1.addListener(() {
      setState(() {
        hasDigit = RegExp(r'[0-9]').hasMatch(_passwordController1.text);
        hasLowerCase =
            RegExp(r'[a-z]').hasMatch(_passwordController1.text);
        hasUpperCase = RegExp(r'[A-Z]').hasMatch(_passwordController1.text);
        hasSpecialCharacter = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(_passwordController1.text);
        hasMin6 = _passwordController1.text.length >= 6;
        hasMax10 = _passwordController1.text.length <= 10;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          SizedBox(height: height * 0.03),
          RowCompose(
            iconSvg: "assets/icons/key.svg",
            text: (widget.flujo == "register")
                ? translation(context)!.complete_registration
                : translation(context)!.new_password,
          ),
          SizedBox(height: height * 0.05),
          CustomInputForm(
            label: translation(context)!.password,
            type: TextInputType.visiblePassword,
            hintText: translation(context)!.please_enter_your_password,
            controller: _passwordController1,
            iconSuffix: "assets/icons/eye.svg",
            toggle: true,
            maxLength: 10,
          ),
          RowValidationPassword(isChecked: hasDigit,
            text: translation(context)!.password_contains_at_least_one_digit,
          ),
          RowValidationPassword(isChecked: hasLowerCase,
            text: translation(context)!.password_contains_at_least_one_lowercase_letter,
          ),
          RowValidationPassword(isChecked: hasUpperCase,
            text: translation(context)!.password_contains_at_least_one_uppercase_letter,
          ),
          RowValidationPassword(isChecked: hasSpecialCharacter,
            text: translation(context)!.password_contains_at_least_one_special_character,
          ),
          RowValidationPassword(isChecked: hasMin6,
            text: translation(context)!.password_contains_at_least_6_characters,
          ),
          RowValidationPassword(isChecked: hasMax10,
            text: translation(context)!.password_contains_at_most_10_characters,
          ),
          SizedBox(height: height * 0.05),
          CustomInputForm(
            label: translation(context)!.confirm_password,
            type: TextInputType.visiblePassword,
            hintText: translation(context)!.please_enter_your_password,
            controller: _passwordController2,
            iconSuffix: "assets/icons/eye.svg",
            toggle: true,
            maxLength: 10,
          ),
          SizedBox(height: height * 0.05),
          (widget.flujo == "register")
              ? BlocConsumer<BlocSignUp, SignUpState>(
                  listener: (context, state) {
                  if (state is SignUpSuccessState) {
                    NavigationService()
                        .navigateToAndRemoveUntil(context, const LoginScreen());
                  }
                }, builder: (context, state) {
                  return MyGradientBtn(
                    onPressed: () => BlocProvider.of<BlocSignUp>(context)
                        .finish(state.phone,_passwordController1.text,
                            _passwordController2.text),
                    text: state.textButton,
                    icon: "assets/icons/door.svg",
                  );
                })
              : BlocConsumer<BlocRecovery, RecoveryState>(
                  listener: (context, state) {
                  if (state is RecoverySuccessState) {
                    NavigationService()
                        .navigateToAndRemoveUntil(context, const LoginScreen());
                  }
                }, builder: (context, state) {
                  return MyGradientBtn(
                    onPressed: (){
                      debugPrint("phone: ${widget.phone}");
                      debugPrint("password1: ${_passwordController1.text}");
                      debugPrint("password2: ${_passwordController2.text}");
                       BlocProvider.of<BlocRecovery>(context)
                        .finish(widget.phone,_passwordController1.text,
                            _passwordController2.text);
                    },
                    text: state.textButton,
                    icon: "assets/icons/door.svg",
                  );
                }),
          SizedBox(height: height * 0.05),
        ]),
      ),
    );
  }
}

class RowValidationPassword extends StatefulWidget {
  const RowValidationPassword({super.key, required this.text, required this.isChecked});
  final String text;
  final bool isChecked;

  @override
  State<RowValidationPassword> createState() => _RowValidationPasswordState();
}

class _RowValidationPasswordState extends State<RowValidationPassword> {
  late bool isValid;
  late String text;
  @override
  void initState() {
    isValid = widget.isChecked;
    text = widget.text;
    super.initState();
  }
  @override
  void didUpdateWidget(covariant RowValidationPassword oldWidget) {
    if(widget.isChecked != isValid || widget.text != text){
      setState(() {
        isValid = widget.isChecked;
        text = widget.text;
      });
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.transparent,
          width: 24,
          height: 48,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                  top: -12,
                  left: -14,
                  child: Checkbox(
                      value: isValid,
                      onChanged: (value) {})),
            ],
          ),
        ),
        Expanded(
            child:
            Container(padding: const EdgeInsets.only(top: 3),child: TextAtom(text:text,size: 14,))),
      ],
    );
  }
}
