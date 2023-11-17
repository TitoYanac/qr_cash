import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../core/services/authentication_service.dart';
import '../../bloc/btn/bloc_btn_state.dart';
import '../../bloc/btn/bloc_btn.dart';
import '../../widgets/appbar_with_leading.dart';
import '../bloc/bloc_timer.dart';
import '../components/molecules/my_button_submit.dart';
import '../components/molecules/my_input_form_number.dart';
class UserOtpReceiverPage extends StatefulWidget {
  final String number;
  final String codeOTP;

  const UserOtpReceiverPage(
      {super.key, required this.number, required this.codeOTP});
  @override
  UserOtpReceiverPageState createState() => UserOtpReceiverPageState();
}

class UserOtpReceiverPageState extends State<UserOtpReceiverPage> {
  final TextEditingController numberController = TextEditingController();
  final CountdownTimerController _timercontroller = CountdownTimerController(endTime: 0);
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
    _timercontroller.dispose();
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
            child: Text(
              translation(context)
                  !.waiting_for_automatic_verification_of_the_SMS_sent_to_this_number,
              style: const TextStyle(fontSize: 16),
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
                child: Text(
                  translation(context)
                  !.by_joining_you_agree_to_the_privacy_policy_and_terms_of_use,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          BlocBuilder<MyBlocBtn, MyStateBtn>(
            builder: (context, state) {
              return MyButtonSubmit(
                onButtonPressed: () async {
                  AuthenticationService(context).validateCodeOtp(
                      numberController.text,
                      widget.number,
                      widget.codeOTP,
                      isCheckBoxChecked);
                },
                label: 'Continuar',
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
