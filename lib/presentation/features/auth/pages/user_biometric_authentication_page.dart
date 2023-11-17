import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:transparent_image/transparent_image.dart'
    show kTransparentImage;

import '../../../../domain/constants/language_constants.dart';

class UserBiometricAuthenticationPage extends StatefulWidget {
  const UserBiometricAuthenticationPage({super.key});

  @override
  UserBiometricAuthenticationPageState createState() => UserBiometricAuthenticationPageState();
}

class UserBiometricAuthenticationPageState extends State<UserBiometricAuthenticationPage> {
  bool _authSuccess = false;
  late LocalAuthentication _localAuth;

  @override
  void initState() {
    super.initState();
    _localAuth = LocalAuthentication();
  }

  Future<bool> _auth() async {
    setState(() => _authSuccess = false);
    if (await _localAuth.canCheckBiometrics == false) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${translation(context)!.your_device_is_not_capable_of_checking_biometrics}.\n'
              '${translation(context)!.this_demo_will_not_work_on_your_device}!\n'
              '${translation(context)!.you_must_have_android_6_and_have_fingerprint_sensor}.',
            ),
          ),
        );
      }
      return false;
    }
    try {
      final authSuccess = await _localAuth.authenticate(
            localizedReason: translation(context)!.auth_in_to_unlock_your_device,
            options: const AuthenticationOptions(biometricOnly: true),
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$authSuccess')),
        );
      }
      return authSuccess;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const Spacer(),
          if (_authSuccess)
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image:
                  const AssetImage('assets/images/tanques_azul_register_2.png'),
            )
          else
            const Placeholder(),
          const Spacer(),
          TextButton.icon(
            icon: const Icon(Icons.fingerprint),
            label:  Text(translation(context)!.auth_in_to_unlock_your_device),
            onPressed: () async {
              final authSuccess = await _auth();
              setState(() => _authSuccess = authSuccess);
            },
          ),
        ],
      ),
    );
  }
}
