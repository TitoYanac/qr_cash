import 'package:flutter/material.dart';
class PrivacyPolicyBulletPoint extends StatelessWidget {
  final String text;

  const PrivacyPolicyBulletPoint(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 8),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}