import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextAtom extends StatefulWidget {
  const TextAtom({
    super.key,
    this.text,
    this.color,
    this.weight,
    this.size, this.align,
  });
  final String? text;
  final Color? color;
  final FontWeight? weight;
  final double? size;
  final TextAlign? align;

  @override
  State<TextAtom> createState() => _TextAtomState();
}

class _TextAtomState extends State<TextAtom> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double pagewidth = 448;
    double textFontSize = 18;
    double fontSize = (width / pagewidth) * textFontSize;
    return Text(widget.text ?? "",
        textAlign: widget.align ?? TextAlign.left,
        style: GoogleFonts.montserrat(
          color: widget.color,
          fontWeight: widget.weight ?? FontWeight.normal,
          fontSize: widget.size ?? fontSize,
        ));
  }
}
