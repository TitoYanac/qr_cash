import 'package:flutter/material.dart';
class EnConstruccion extends StatefulWidget {
  const EnConstruccion({super.key});

  @override
  State<EnConstruccion> createState() => _EnConstruccionState();
}

class _EnConstruccionState extends State<EnConstruccion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(child: Image.asset("assets/images/enconstruccion.png"),),
    );
  }
}
