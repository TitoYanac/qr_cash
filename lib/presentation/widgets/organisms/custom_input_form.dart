import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputForm extends StatefulWidget {
  const CustomInputForm({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.iconPrefix,
    this.iconSuffix,
    this.toggle = false,
    required this.type,
    this.maxLength,
  });
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? iconPrefix;
  final String? iconSuffix;
  final bool toggle;
  final TextInputType type;
  final int? maxLength;

  @override
  State<CustomInputForm> createState() => _CustomInputFormState();
}

class _CustomInputFormState extends State<CustomInputForm> {
  late bool toggle;
  @override
  void initState() {
    toggle = widget.toggle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double pagewidth = 448;
    double textFontSize = 18;
    double fontSize = (width / pagewidth) * textFontSize;
    return TextField(
      controller: widget.controller,
      obscureText: toggle,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        prefixIcon: widget.iconPrefix == null
            ? null
            : SizedBox(
          width: 36,
          height: 60,
              child: Stack(
                children: [
                  Center(child: SvgPicture.asset(widget.iconPrefix!,height: 20,)),
                ],
              ),
            ),
        suffixIcon: widget.iconSuffix == null
            ? null
            : GestureDetector(
                onTap: () {
                  if (widget.toggle) {
                    setState(() {
                      toggle = !toggle;
                    });
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  width: 36,
                  height: 60,
                  child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 24,
                      height: 24,
                          child: SvgPicture.asset(
                            widget.iconSuffix!,
                            fit: BoxFit.contain,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.tertiary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        hintStyle: GoogleFonts.montserrat(
          color: Theme.of(context).colorScheme.shadow,
          fontWeight: FontWeight.normal,
          fontSize: fontSize,
        ),
        labelStyle: GoogleFonts.montserrat(
          color: Theme.of(context).colorScheme.shadow,
          fontWeight: FontWeight.normal,
          fontSize: fontSize,
        ),
        floatingLabelStyle: GoogleFonts.montserrat(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.normal,
          fontSize: fontSize,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            color: Color.fromRGBO(227, 0, 20, 1),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Color.fromRGBO(227, 0, 20, 1),
            )),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Color.fromRGBO(227, 0, 20, 1),
            )),
        disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Color.fromRGBO(227, 0, 20, 1),
            )),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Color.fromRGBO(227, 0, 20, 1),
            )),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            color: Color.fromRGBO(227, 0, 20, 1),
          ),
        ),
      ),
      keyboardType: widget.type,
      textInputAction: TextInputAction.next,
      onSubmitted: (value) {
        FocusScope.of(context).unfocus();
      },
      onChanged: (value) {
        setState(() {});
      },
      onTap: () {
        setState(() {});
      },
      style: TextStyle(fontSize: fontSize),
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.center,
      maxLines: 1,
      minLines: 1,
    );
  }
}
