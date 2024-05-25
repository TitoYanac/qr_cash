import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../../presentation/core/services/authentication_service.dart';
import '../../../../presentation/features/auth/bloc/bloc_login.dart';
import '../components/templates/login_template.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    String titleAppbar = translation(context)!.login;
    return BlocProvider(
      create: (context) => BlocLogin(AuthenticationService(context),titleAppbar),
      child: const LoginTemplate(),
    );
  }
}

