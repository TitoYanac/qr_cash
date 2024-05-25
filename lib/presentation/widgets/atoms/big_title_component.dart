import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'content_coponent.dart';

class BigTitleComponent implements ContentComponent {
  final String title;

  BigTitleComponent(this.title);

  @override
  Widget render() {
    return Text(
      title,
      style: GoogleFonts.nunito(fontSize: 22, color: Colors.white,fontWeight: FontWeight.bold),
    );
  }
}
