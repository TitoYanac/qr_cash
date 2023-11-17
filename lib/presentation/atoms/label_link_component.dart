import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'content_coponent.dart';

class LabelLinkComponent implements ContentComponent {
  final String label;

  LabelLinkComponent(this.label);

  @override
  Widget render() {
    return Text(
      label,
      style: GoogleFonts.nunito(fontSize: 12, color: Colors.grey,fontWeight: FontWeight.bold),
    );
  }
}
