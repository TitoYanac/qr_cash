import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MyButtonSubmitGradient extends StatefulWidget {
  const MyButtonSubmitGradient(
      {super.key,
      required this.onButtonPressed,
      required this.label,
      this.isEnabled,
      this.imagenIcon});

  final VoidCallback onButtonPressed;
  final String label;
  final bool? isEnabled;
  final Widget? imagenIcon;
  @override
  State<MyButtonSubmitGradient> createState() => _MyButtonSubmitGradientState();
}

class _MyButtonSubmitGradientState extends State<MyButtonSubmitGradient> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () => widget.onButtonPressed(),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blue, Color.fromRGBO(86, 2, 14, 1)],
                ),
                borderRadius: BorderRadius.circular(300.0),
              ),
              constraints: const BoxConstraints(
                minWidth: 200,
              ),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.label,
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
