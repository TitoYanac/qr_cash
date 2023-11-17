import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'content_coponent.dart';

class ParagraphComponent implements ContentComponent {
  final String text;

  ParagraphComponent(this.text);

  @override
  Widget render() {
    return Text(text,
      style: GoogleFonts.nunito(fontSize: 14, color: Colors.grey),
    );
  }
}