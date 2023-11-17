import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../domain/constants/language_constants.dart';

class MyInputFormPass extends StatefulWidget {
  const MyInputFormPass({
    Key? key,
    required this.passwordController,
    this.focusScopeNodePass,
  }) : super(key: key);

  final TextEditingController passwordController;
  final FocusScopeNode? focusScopeNodePass;

  @override
  State<MyInputFormPass> createState() => _MyInputFormPassState();
}

class _MyInputFormPassState extends State<MyInputFormPass> {
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
        child: Container(
          color: Colors.transparent,
          child: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      labelText: translation(context)!.password,
      labelStyle: GoogleFonts.nunitoSans(
          fontSize: 14
      ),
      prefixIcon: const Icon(Icons.lock),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey, // Customize the border color here
          width: 2.0, // Adjust the border thickness here
        ),
        borderRadius: BorderRadius.circular(20.0), // Customize the border radius here
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey, // Customize the border color here
          width: 2.0, // Adjust the border thickness here
        ),
        borderRadius: BorderRadius.circular(20.0), // Customize the border radius here
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red, // Customize the error border color here if needed
          width: 2.0, // Adjust the border thickness here
        ),
        borderRadius: BorderRadius.circular(20.0), // Customize the border radius here
      ),focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red, // Customize the error border color here if needed
        width: 2.0, // Adjust the border thickness here
      ),
      borderRadius: BorderRadius.circular(20.0), // Customize the border radius here
    ),
    );

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 0, right: 16, left: 16, bottom: 20),
            child: TextFormField(
              controller: widget.passwordController,
              obscureText: _obscurePassword,
              autocorrect: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTapOutside: (e) {
                FocusScope.of(context).unfocus();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translation(context)!.please_enter_your_password;
                }
                // You can add more password validations if desired.
                return null;
              },
              decoration: inputDecoration, // Use the defined InputDecoration here
            ),
          ),
        ),
      ],
    );
  }
}
