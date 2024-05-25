import 'package:flutter/material.dart';

import 'text_atom.dart';

class ListComponent extends StatelessWidget {
  final List<String> children;

  const ListComponent({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children
          .map(
            (item) => ListTile(
              dense: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 24,
                    height: 12,
                    child: Stack(
                      children: [
                        Center(child: Icon(Icons.arrow_right_outlined)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextAtom(
                      text: item,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
