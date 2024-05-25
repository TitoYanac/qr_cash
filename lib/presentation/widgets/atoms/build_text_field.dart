import 'package:flutter/material.dart';

class BuildTextField extends StatefulWidget {
  const BuildTextField(
      {super.key,
      required this.controller,
      required this.label,
      required this.hint,
      this.enable,
      this.maxLength,
      this.type});
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool? enable;
  final int? maxLength;
  final TextInputType? type;

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  @override
  Widget build(BuildContext context) {
    InputBorder genericBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.type ?? TextInputType.text,
        enabled: widget.enable ?? true,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          border: genericBorder,
          focusedBorder: genericBorder,
          enabledBorder: genericBorder,
          errorBorder: genericBorder,
          focusedErrorBorder: genericBorder,
        ),
      ),
    );
  }
}
