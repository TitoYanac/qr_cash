import 'package:flutter/material.dart';
class PrivacyPolicyParagraph extends StatelessWidget {
  final String text;

  const PrivacyPolicyParagraph(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 16));
  }
}