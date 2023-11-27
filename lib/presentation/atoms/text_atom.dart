import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextAtom extends StatefulWidget {
  final String? text;
  final Color? color;
  final FontWeight? weight;
  final double? size;
  const TextAtom({super.key, this.text,this.color,this.weight,this.size});

  @override
  State<TextAtom> createState() => _TextAtomState();
}

class _TextAtomState extends State<TextAtom> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.text??"",
              style: GoogleFonts.nunito(color: widget.color,fontWeight: widget.weight??FontWeight.normal,fontSize: widget.size??14,)
            ),
          ),
        ),
      ],
    );
  }
}
