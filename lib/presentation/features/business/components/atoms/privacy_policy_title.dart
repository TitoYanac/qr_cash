import 'package:flutter/material.dart';
class PrivacyPolicyTitle extends StatelessWidget {
  final String title;

  const PrivacyPolicyTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}