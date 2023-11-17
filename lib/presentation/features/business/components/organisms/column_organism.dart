import 'package:flutter/material.dart';

class ColumnOrganism extends StatefulWidget {
  final Widget firstWidget;
  final Widget? secondWidget;
  final Widget? thirdWidget;
  final Widget? fourthWidget;
  final Widget? fifthWidget;
  const ColumnOrganism({
    required this.firstWidget,
    this.secondWidget,
    this.thirdWidget,
    this.fourthWidget,
    this.fifthWidget,super.key});

  @override
  State<ColumnOrganism> createState() => _ColumnOrganismState();
}

class _ColumnOrganismState extends State<ColumnOrganism> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: Colors.transparent)),
      child: Column(
        children: [
          widget.firstWidget,
          widget.secondWidget??Container(),
          widget.thirdWidget??Container(),
          widget.fourthWidget??Container(),
          widget.fifthWidget??Container(),
        ],
      ),
    );
  }
}