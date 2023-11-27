import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../domain/constants/language_constants.dart';

class MyInputFormPhone extends StatefulWidget {
  const MyInputFormPhone({
    Key? key,
    required this.phoneNumberController,
  }) : super(key: key);

  final TextEditingController phoneNumberController;

  @override
  State<MyInputFormPhone> createState() => _MyInputFormPhoneState();
}

class _MyInputFormPhoneState extends State<MyInputFormPhone> {
  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      labelText: translation(context)!.cell_phone_number,
      labelStyle: GoogleFonts.nunitoSans(
        fontSize: 14
      ),
      prefixIcon: const Icon(Icons.phone),
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
      ),errorBorder: OutlineInputBorder(
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
            padding:
            const EdgeInsets.only(top: 40, right: 16, left: 16, bottom: 8),
            child: TextFormField(
              controller: widget.phoneNumberController,
              keyboardType: TextInputType.number,
              autocorrect: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLength: 10,
              autofocus: false,
              onTapOutside: (e) {
                FocusScope.of(context).unfocus();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translation(context)!.please_enter_your_number;
                }
                if (value.length != 10) {
                  return translation(context)!.the_number_field_should_be_have_10_digits;
                }
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
