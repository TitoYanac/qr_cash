import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TitleRoboto16 extends StatefulWidget {
  const TitleRoboto16({super.key, required this.title});
  final String title;

  @override
  State<TitleRoboto16> createState() => _TitleRoboto16State();
}

class _TitleRoboto16State extends State<TitleRoboto16> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: GoogleFonts.roboto(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
