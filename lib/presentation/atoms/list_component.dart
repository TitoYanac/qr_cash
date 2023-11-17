import 'package:flutter/material.dart';
import 'package:qrcash/presentation/atoms/text_atom.dart';

import 'content_coponent.dart';
class ListComponent implements ContentComponent {
  final List<String> items;

  ListComponent(this.items);

  @override
  Widget render() {
    return Column(
      children: items
          .map((item) => ListTile(
        dense: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //const Icon(Icons.arrow_right_outlined),
              Expanded(child: TextAtom(text: item, color: Colors.grey),),
            ],
          )))
          .toList(),
    );
  }
}
