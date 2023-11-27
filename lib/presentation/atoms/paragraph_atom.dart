import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParagraphAtom extends StatefulWidget {
  const ParagraphAtom({super.key, required this.text});
  final String text;
  @override
  State<ParagraphAtom> createState() => _ParagraphAtomState();
}

class _ParagraphAtomState extends State<ParagraphAtom> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.text,
          softWrap: true,
          style: GoogleFonts.nunito(fontSize: 14),
        ),
      ],
    );
  }
}
