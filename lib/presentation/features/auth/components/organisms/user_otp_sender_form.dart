import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../atoms/paragraph_component.dart';
import '../../../../atoms/title_component.dart';
import '../../../../core/services/authentication_service.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../bloc/btn/bloc_btn_state.dart';
import '../../../bloc/btn/bloc_btn.dart';
import '../../../business/pages/composite_terms_and_conditions.dart';
import '../molecules/my_button_submit.dart';
import '../molecules/my_input_form_phone.dart';

class UserOtpSenderForm extends StatefulWidget {
  const UserOtpSenderForm({super.key});

  @override
  State<UserOtpSenderForm> createState() => _UserOtpSenderFormState();
}

class _UserOtpSenderFormState extends State<UserOtpSenderForm> {

  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isCheckBoxChecked = false;
  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        // Utilizamos un Row para alinear los TextField
        MyInputFormPhone(phoneNumberController: _phoneNumberController),
        const SizedBox(
          height: 32,
        ),
        Row(
          children: [
            Checkbox(
              value: _isCheckBoxChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isCheckBoxChecked = value ?? false;
                });
              },
            ),
            GestureDetector(
              onTap: ()=> NavigationService().navigateTo(context, const CompositeTermsAndConditionsScreen()),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   ParagraphComponent(translation(context)!.i_accept_the).render(),
                   const SizedBox(width: 6),
                   TitleComponent(translation(context)!.terms_and_conditions[0].toUpperCase() + translation(context)!.terms_and_conditions.substring(1)).render(),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 40,
        ),
        BlocBuilder<MyBlocBtn, MyStateBtn>(
          builder: (context, state) {
            return MyButtonSubmit(
              onButtonPressed: () async {
                AuthenticationService(context).requestOtpService(_phoneNumberController.text,_isCheckBoxChecked);
              },
              label: translation(context)!.continue_,
            );
          },
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
