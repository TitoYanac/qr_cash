import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'content_coponent.dart';

class TitleComponent implements ContentComponent {
  final String title;
  final String? align;

  TitleComponent(this.title,{this.align});

  @override
  Widget render() {
    return Text(
      title,
      textAlign: align=='center'?TextAlign.center:TextAlign.left,
      style: GoogleFonts.nunitoSans(fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold),
    );
  }
}
