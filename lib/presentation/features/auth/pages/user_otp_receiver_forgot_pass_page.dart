import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcash/presentation/atoms/title_component.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../atoms/big_title_component.dart';
import '../../../atoms/paragraph_atom.dart';
import '../../../atoms/text_atom.dart';
import '../../../core/services/authentication_service.dart';
import '../../bloc/btn/bloc_btn_state.dart';
import '../../bloc/btn/bloc_btn.dart';
import '../../business/pages/composite_privacy_policy.dart';
import '../../widgets/appbar_with_leading.dart';
import '../bloc/bloc_timer.dart';
import '../components/molecules/my_button_submit.dart';
import '../components/molecules/my_input_form_number.dart';

class UserOtpReceiverForgotPassPage extends StatefulWidget {
  final String number;
  final String codeOTP;

  const UserOtpReceiverForgotPassPage({super.key, required this.number, required this.codeOTP});
  @override
  UserOtpReceiverForgotPassPageState createState() =>
      UserOtpReceiverForgotPassPageState();
}

class UserOtpReceiverForgotPassPageState
    extends State<UserOtpReceiverForgotPassPage> {
  final TextEditingController numberController = TextEditingController();
  bool _isClickable = false;
  bool isCheckBoxChecked = false;

  int startTime = 120 * 1000; // 120 segundos en milisegundos

  String timeText = '120';
  late String code;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(minutes: 2),
      () {
        if (mounted) {
          setState(() {
            _isClickable = true;
          });
        }
      },
    );
    setState(() {
      code = widget.codeOTP ?? '';
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TimerBloc>().add(StartTimer());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    numberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget pagetitle = TextAtom(
      text: translation(context)!.code_otp,
      size: 24,
      weight: FontWeight.bold,
    );
    Widget paragraph1 = ParagraphAtom(text: translation(context)!.waiting_for_automatic_verification_of_the_SMS_sent_to_this_number);
    Widget inputCode = MyInputFormNumber(
      controller: numberController,
      maxLength: 6,
      labelText: translation(context)!.code_otp,
    );
    Widget paragraph2 = ParagraphAtom(text: translation(context)!.enter_the_6_digit_code);
    Widget tileTimer = ListTile(
      leading: const Icon(Icons.message),
      contentPadding: const EdgeInsets.all(0),
      title: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ParagraphAtom(text: translation(context)!.wait),
            const SizedBox(
              width: 12,
            ),
            BlocBuilder<TimerBloc, TimerState>(
              builder: (context, state) {
                final minutesStr = ((state.duration / 60) % 60)
                    .floor()
                    .toString()
                    .padLeft(2, '0');
                final secondsStr =
                (state.duration % 60).toString().padLeft(2, '0');
                return ParagraphAtom(text: '$minutesStr:$secondsStr');
              },
            ),
            const SizedBox(
              width: 12,
            ),
            ParagraphAtom(text: translation(context)!.to_send_again),
          ],
        ),
      ),
      onTap: (){
        if (_isClickable) {
          Navigator.pop(context);
        }
      },
    );
    Widget tileTerms = ListTile(
      leading: Checkbox(
        value: isCheckBoxChecked,
        onChanged: (bool? value) {
          setState(() {
            isCheckBoxChecked = value ?? false;
          });
        },
      ),
      contentPadding: const EdgeInsets.all(0),
      dense: true,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CompositePrivacyPolicyScreen(),
          ),
        );
      },
      title: TextAtom(
        text: translation(context)!
            .by_joining_you_agree_to_the_privacy_policy_and_terms_of_use,
        size: 16,
      ),
    );
    Widget btnSubmit = BlocBuilder<MyBlocBtn, MyStateBtn>(
      builder: (context, state) {
        return MyButtonSubmit(
          onButtonPressed: () async {
            AuthenticationService(context).validateCodeOtpForgotPass(
                numberController.text,
                widget.number,
                widget.codeOTP,
                isCheckBoxChecked);
          },
          label: translation(context)!.continue_,
        );
      },
    );
    return Scaffold(
      appBar: MyAppBarWithLeading(title: translation(context)!.otp).getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            pagetitle,
            paragraph1,
            inputCode,
            paragraph2,
            //poner un row con 3 hijos que abarque todo el ancho de la pantalla
            Row(
              children: [
                Expanded(
                  child: tileTimer,
                ),
                Expanded(
                  child: SizedBox.shrink(), // Puedes ajustar según tus necesidades
                ),
                Expanded(
                  child: SizedBox.shrink(), // Puedes ajustar según tus necesidades
                ),
              ],
            ),
            tileTerms,
            btnSubmit,
          ],
        ),
      ),
    );
  }
}
