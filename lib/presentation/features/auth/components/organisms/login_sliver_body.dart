import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_save_scan/presentation/features/auth/bloc/bloc_recovery.dart';
import 'package:qr_save_scan/presentation/features/auth/pages/otp_request_screen.dart';
import '../../../../../domain/constants/language_constants.dart';
import '../../../../core/services/authentication_service.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../widgets/atoms/text_atom.dart';
import '../../../../widgets/molecules/my_gradient_btn.dart';
import '../../../../widgets/molecules/row_compose.dart';
import '../../../../widgets/organisms/custom_input_form.dart';
import '../../bloc/bloc_login.dart';
import '../../bloc/bloc_sign_up.dart';
import '../../pages/auth_gps_validator_page.dart';
import '../../pages/new_register_page.dart';
import '../../pages/register_page.dart';

class LoginSliverBody extends StatefulWidget {
  const LoginSliverBody({super.key});

  @override
  State<LoginSliverBody> createState() => _LoginSliverBodyState();
}

class _LoginSliverBodyState extends State<LoginSliverBody> {
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _passwordController;
  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String continueMessage = translation(context)!.continue_;
    String initialMessage = translation(context)!.continue_;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          SizedBox(height: height * 0.03),
          RowCompose(
            iconSvg: "assets/icons/lock.svg",
            text: translation(context)!.login_to_your_account,
          ),
          SizedBox(height: height * 0.05),
          CustomInputForm(
            label: translation(context)!.phone,
            type: TextInputType.phone,
            hintText: translation(context)!.enter_cell_phone_number,
            controller: _phoneNumberController,
            iconSuffix: "assets/icons/phone.svg",
            maxLength: 10,
          ),
          SizedBox(height: height * 0.05),
          CustomInputForm(
            label: translation(context)!.password,
            type: TextInputType.visiblePassword,
            hintText: translation(context)!.please_enter_your_password,
            controller: _passwordController,
            iconSuffix: "assets/icons/eye.svg",
            toggle: true,
          ),
          SizedBox(height: height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => NavigationService().navigateTo(
                  context,
                  BlocProvider(
                    create: (context) => BlocRecovery(
                        AuthenticationService(context), initialMessage),
                    child: OtpRequestScreen(
                      flujo: "forgot",
                      phone: _phoneNumberController.text,
                      password: _passwordController.text,
                    ),
                  ),
                ),
                child: TextAtom(
                  text: "¿${translation(context)!.forgot_password}?",
                  size: 12,
                ),
              )
            ],
          ),
          SizedBox(height: height * 0.07),
          BlocConsumer<BlocLogin, LoginState>(listener: (context, state) {
            if (state is LoginSuccessState) {
              NavigationService().navigateToAndRemoveUntil(
                  context, const AuthGpsValidatorPage());
            }
          }, builder: (context, state) {
            return MyGradientBtn(
              onPressed: () => BlocProvider.of<BlocLogin>(context).triggerLogin(
                  _phoneNumberController.text, _passwordController.text),
              text: state.textButton,
              icon: "assets/icons/door.svg",
            );
          }),
          SizedBox(height: height * 0.05),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextAtom(
              text: translation(context)!.dont_have_an_account_yet,
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: GestureDetector(
                onTap: () => NavigationService().navigateTo(
                  context,
                  BlocProvider(
                    create: (context) => BlocSignUp(
                        AuthenticationService(context), continueMessage),
                    child: const NewRegisterPage(),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  color: Colors.transparent,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: TextAtom(
                      text: translation(context)!.sing_up,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            )
          ]),
          //SizedBox(height: height*.25),
        ]),
      ),
    );
  }
}
