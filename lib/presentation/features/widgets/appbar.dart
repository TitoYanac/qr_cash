import 'package:flutter/material.dart';
import '../../atoms/text_atom.dart';

class MyAppBar {
  String title;
  String? srcItem;
  Widget? leadingPage;
  MyAppBar({required this.title, this.leadingPage, this.srcItem});
  getAppBar() {
    return AppBar(
      title: TextAtom(
        text: title,
        color: Colors.white,
        size: 24,
        weight: FontWeight.bold,
      ),
      backgroundColor: Colors.red,
      automaticallyImplyLeading: false,
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset(
                "assets/icons/isotipo.png",
                height: 30,
              ),
            ),
          ],
        )
      ],
    );
  }
}
