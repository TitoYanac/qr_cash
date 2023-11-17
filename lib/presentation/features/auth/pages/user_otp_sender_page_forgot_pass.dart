import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc_timer.dart';
import '../components/templates/user_otp_sender_forgot_pass_template.dart';

class UserOtpSenderPageForgotPass extends StatefulWidget {
  const UserOtpSenderPageForgotPass({
    Key? key,
  }) : super(key: key);

  @override
  UserOtpSenderPageForgotPassState createState() => UserOtpSenderPageForgotPassState();
}

class UserOtpSenderPageForgotPassState extends State<UserOtpSenderPageForgotPass> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(  create: (context) => TimerBloc(),
        child: const UserOtpSenderForgotPassTemplate());
  }
}
