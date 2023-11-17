import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'content_coponent.dart';

class CompositeComponent implements ContentComponent {
  final String name;
  final List<ContentComponent> children;
  //final ExpansionTileController expansionTileController = ExpansionTileController();
  CompositeComponent(this.name, this.children);

  @override
  Widget render() {
    return ExpansionTile(
      //controller: expansionTileController,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildTitle(name),
      ),
      children: children
          .map((child) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: child.render(),
              ))
          .toList(),
    );
  }

  List<Widget> _buildTitle(name) {
    String prefix = "";
    String suffix = "";
    if (name.contains("→")) {
      prefix = "${name.split("→ ").first}→ ";
      suffix = name.split("→ ").last;
    }else {
      prefix = name;
    }
    return [
      Expanded(
        child: Text("$prefix $suffix",
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              fontSize: (suffix!="")?12:14,
            )),
      )
    ];
  }
}
