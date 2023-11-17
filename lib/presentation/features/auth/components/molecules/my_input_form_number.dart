import 'package:flutter/material.dart';

import '../../../../../domain/constants/language_constants.dart';

class MyInputFormNumber extends StatefulWidget {
  const MyInputFormNumber({
    Key? key,
    required this.controller, required this.labelText, this.prefiIcon, required this.maxLength,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final Icon? prefiIcon;
  final int maxLength;

  @override
  State<MyInputFormNumber> createState() => _MyInputFormNumberState();
}

class _MyInputFormNumberState extends State<MyInputFormNumber> {
  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      labelText: widget.labelText,
      prefixIcon: widget.prefiIcon,
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
      ),
    );

    return Row(
      children: [
        Expanded(
          child: Container(
            padding:
            const EdgeInsets.only(top: 40, right: 16, left: 16, bottom: 8),
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.number,
              autocorrect: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLength: widget.maxLength,
              autofocus: false,
              onTapOutside: (e) {
                FocusScope.of(context).unfocus();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translation(context)!.please_enter_your_number;
                }
                if (value.length != widget.maxLength) {
                  return '${translation(context)!.the_number_should_be_have} ${widget.maxLength} ${translation(context)!.digits}';
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
