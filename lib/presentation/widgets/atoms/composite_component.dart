import 'package:flutter/material.dart';
import 'package:qr_save_scan/presentation/widgets/atoms/text_atom.dart';

class CompositeComponent extends StatefulWidget {
  final String name;
  final List<Widget> children;
  //final ExpansionTileController expansionTileController = ExpansionTileController();
  const CompositeComponent(
      {super.key, required this.name, required this.children});

  @override
  State<CompositeComponent> createState() => _CompositeComponentState();
}

class _CompositeComponentState extends State<CompositeComponent> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: _isExpanded
              ? Colors.transparent
              : Theme.of(context).colorScheme.primary,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: ExpansionTile(
        //controller: expansionTileController,
        backgroundColor: Theme.of(context).colorScheme.primary,
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (value) {
          setState(() {
            _isExpanded = value;
          });
        },
        title: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildTitle(widget.name.toUpperCase()),
          ),
        ),
        iconColor: _isExpanded ? Colors.white : Colors.black,
        children: [
          Container(
            color: const Color.fromRGBO(245, 245, 255, 1),
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
                children: widget.children
                    .map(
                      (child) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: child,
                      ),
                    )
                    .toList()),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTitle(name) {
    String prefix = "";
    String suffix = "";
    if (name.contains("→")) {
      prefix = "${name.split("→ ").first}→ ";
      suffix = name.split("→ ").last;
    } else {
      prefix = name;
    }
    return [
      Expanded(
        child: TextAtom(
          text: "$prefix $suffix",
          weight: FontWeight.bold,
          size: (suffix != "") ? 12 : 14,
          color: _isExpanded ? Colors.white : Colors.black,
        ),
      )
    ];
  }
}
