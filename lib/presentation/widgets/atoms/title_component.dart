import 'package:flutter/material.dart';

import 'text_atom.dart';

class TitleComponent extends StatelessWidget {
  final String title;
  final String? align;

  const TitleComponent({super.key, required this.title, this.align});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextAtom(
          text: title,
          align: align=='center'?TextAlign.center:TextAlign.left,
          size: 18,
          weight: FontWeight.bold,
        ),
      ],
    );
  }
}
