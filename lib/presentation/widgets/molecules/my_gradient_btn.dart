import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MyGradientBtn extends StatefulWidget {
  const MyGradientBtn({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.width,
    this.padding,
    this.color,
  });

  final String text;
  final Function onPressed;
  final String? icon;
  final double? width;
  final double? padding;
  final Color? color;

  @override
  State<MyGradientBtn> createState() => _MyGradientBtnState();
}

class _MyGradientBtnState extends State<MyGradientBtn> {
  String text = "";
  @override
  initState() {
    super.initState();
    text = widget.text;
  }

  @override
  void didUpdateWidget(covariant MyGradientBtn oldWidget) {
    if (widget.text != oldWidget.text) {
      setState(() {
        text = widget.text;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double pagewidth = 448;
    double textFontSize = 30;
    double fontSize = (width / pagewidth) * textFontSize;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          child: Ink(
            decoration: BoxDecoration(
              gradient: (widget.color == null)
                  ? const LinearGradient(colors: <Color>[
                      Color.fromRGBO(227, 0, 20, 1),
                      Color.fromRGBO(191, 0, 10, 1)
                    ])
                  : null,
              color: widget.color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                widget.onPressed();
               // FocusScope.of(context).unfocus();
              },
              child: Container(
                width: widget.width ?? MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.symmetric(
                    horizontal: widget.padding ??
                        MediaQuery.of(context).size.width * 0.08),
                height: 60.0,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          text,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: fontSize,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (widget.icon != null &&
                        widget.icon!.split(".").last == "svg")
                      SvgPicture.asset(
                        widget.icon!,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        height: 30,
                      ),
                    if (widget.icon != null &&
                        widget.icon!.split(".").last == "png")
                      Image.asset(
                        widget.icon!,
                        color: Colors.white,
                        height: 30,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
