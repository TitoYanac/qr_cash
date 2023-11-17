import 'package:flutter/material.dart';

import '../features/user/pages/en_construccion.dart';
class MyErrorSnackBar {
  final BuildContext context;
  final String message;
  final String? label;
  final Widget? page;

  MyErrorSnackBar({required this.context, required this.message, this.label, this.page});

  showSnackBar() {
    // Oculta el SnackBar actual si existe
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 14.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.red[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        action: SnackBarAction(
          label: label ?? '',
          textColor: Colors.orange,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page ?? const EnConstruccion(),
              ),
            );
          },
        ),
      ),
    );
  }
}
