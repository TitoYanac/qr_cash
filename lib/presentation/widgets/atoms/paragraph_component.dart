import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParagraphComponent extends StatelessWidget {
  final String text;

  const ParagraphComponent(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(text,
        style: GoogleFonts.montserrat(fontSize: 14, color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}