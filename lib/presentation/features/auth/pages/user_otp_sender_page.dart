import 'package:flutter/material.dart';

import '../components/templates/user_otp_sender_template.dart';

class UserOtpSenderPage extends StatefulWidget {
  const UserOtpSenderPage({
    Key? key,
  }) : super(key: key);

  @override
  UserOtpSenderPageState createState() => UserOtpSenderPageState();
}

class UserOtpSenderPageState extends State<UserOtpSenderPage> {
  @override
  Widget build(BuildContext context) {
    return const UserOtpSenderTemplate();
  }
}
