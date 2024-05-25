import 'package:flutter/material.dart';

class CustomArrowBack extends StatelessWidget {
  final Widget nextPage;
  final Color color;
  final double size;
  const CustomArrowBack(
      {super.key, required this.nextPage, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: size,
        color: color,
      ),
      onPressed: () {
        // Navegar a la siguiente pantalla usando pushReplacement
        Navigator.pop(context);
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => nextPage));
      },
    );
  }
}
