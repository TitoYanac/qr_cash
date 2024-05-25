import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/status/bloc_gps_screen.dart';
import '../../../core/services/authentication_service.dart';
import '../components/templates/auth_gps_validator_template.dart';

class AuthGpsValidatorPage extends StatefulWidget {
  const AuthGpsValidatorPage({super.key});

  @override
  State<AuthGpsValidatorPage> createState() => _AuthGpsValidatorPageState();
}

class _AuthGpsValidatorPageState extends State<AuthGpsValidatorPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocGpsScreen>(
      create: (context) =>
          BlocGpsScreen(AuthenticationService(context)),
      child: const AuthGpsValidatorTemplate(),
    );
  }

}
