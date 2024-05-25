import 'package:flutter/material.dart';

import '../../../../widgets/atoms/text_atom.dart';



class RowTextMolecule extends StatefulWidget {
  final String firstText;
  final String? secondText;
  final String? thirdText;
  final String? fourthText;
  final String? fifthText;
  final Color? color;
  final FontWeight? weight;
  const RowTextMolecule({
    required this.firstText,
    this.secondText,
    this.thirdText,
    this.fourthText,
    this.fifthText,this.color,this.weight,super.key});

  @override
  State<RowTextMolecule> createState() => _RowTextMoleculeState();
}

class _RowTextMoleculeState extends State<RowTextMolecule> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextAtom(text: widget.firstText,color: widget.color,weight: widget.weight,),
        if(widget.secondText != null) TextAtom(text: widget.secondText,color: widget.color,weight: widget.weight,),
        if (widget.thirdText != null) TextAtom(text: widget.thirdText!,color: widget.color,weight: widget.weight,),
        if (widget.fourthText != null) TextAtom(text: widget.fourthText!,color: widget.color,weight: widget.weight,),
        if (widget.fifthText != null) TextAtom(text: widget.fifthText!,color: widget.color,weight: widget.weight,),
      ],
    );
  }
}

