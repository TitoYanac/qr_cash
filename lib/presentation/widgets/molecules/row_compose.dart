import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../atoms/text_atom.dart';

class RowCompose extends StatefulWidget {
  const RowCompose({super.key, required this.iconSvg, required this.text});
  final String iconSvg;
  final String text;

  @override
  State<RowCompose> createState() => _RowComposeState();
}

class _RowComposeState extends State<RowCompose> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          widget.iconSvg,
          height: 40,
          colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.tertiary, BlendMode.srcIn),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextAtom(text: widget.text),
        ),
      ],
    );
  }
}
