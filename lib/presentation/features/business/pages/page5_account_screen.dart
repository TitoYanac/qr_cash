import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/constants/language_constants.dart';
import '../../../core/services/user_service.dart';
import '../widgets/templates/account_template.dart';
import '../../user/bloc/bloc_user.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    String initialmessage = translation(context)!.submit;
    BlocUser blocUser = BlocUser(UserService(context), initialmessage);
    return BlocProvider(
      create: (context) => blocUser,
      child: AccountTemplate(blocUser: blocUser),
    );
  }
}
