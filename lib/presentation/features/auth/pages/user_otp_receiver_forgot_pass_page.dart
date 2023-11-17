import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/constants/language_constants.dart';
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

  const UserOtpReceiverForgotPassPage(
      {super.key, required this.number, required this.codeOTP});
  @override
  UserOtpReceiverForgotPassPageState createState() => UserOtpReceiverForgotPassPageState();
}

class UserOtpReceiverForgotPassPageState extends State<UserOtpReceiverForgotPassPage> {
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
    return Scaffold(
      appBar: MyAppBarWithLeading(title: translation(context)!.otp).getAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            '${translation(context)!.check} ${widget.number}\n ${widget.codeOTP ?? "no hay code"}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: TextAtom(
              text: translation(context)!.by_joining_you_agree_to_the_privacy_policy_and_terms_of_use,
              size: 16,
            ),
          ),
          // Utilizamos un Row para alinear los TextField
          MyInputFormNumber(
            controller: numberController,
            maxLength: 6,
            labelText: translation(context)!.code_otp,
          ),
          const SizedBox(height: 16),
          Text(
            translation(context)!.enter_the_6_digit_code,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              if (_isClickable) {
                Navigator.pop(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.message),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(translation(context)!.wait),
                  const SizedBox(
                    width: 12,
                  ),
                  BlocBuilder<TimerBloc, TimerState>(
                    builder: (context, state) {
                      final minutesStr = ((state.duration / 60) % 60).floor().toString().padLeft(2, '0');
                      final secondsStr = (state.duration % 60).toString().padLeft(2, '0');
                      return Text('$minutesStr:$secondsStr');
                    },
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(translation(context)!.to_send_again),
                ],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: isCheckBoxChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isCheckBoxChecked = value ?? false;
                  });
                },
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translation(context)!.by_joining_you_agree_to_the_privacy_policy_and_terms_of_use.split(" ").first,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 6,),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CompositePrivacyPolicyScreen(),
                            ),
                          );
                        },
                        child: Text(
                          translation(context)!.by_joining_you_agree_to_the_privacy_policy_and_terms_of_use.split(" ").sublist(1).join(' '),
                          style: const TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          BlocBuilder<MyBlocBtn, MyStateBtn>(
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
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
