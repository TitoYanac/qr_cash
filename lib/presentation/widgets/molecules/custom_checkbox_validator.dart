import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/services/navigation_service.dart';

class CustomCheckBoxValidator extends StatefulWidget {
  const CustomCheckBoxValidator({
    super.key,
    required this.initialText,
    this.resaltedText,
    this.lastText,
    required this.onChanged,
    required this.isChecked,
    this.navigatorPage
  });
  final Function(bool?)? onChanged;
  final String initialText;
  final String? resaltedText;
  final String? lastText;
  final bool isChecked;
  final Widget? navigatorPage;

  @override
  State<CustomCheckBoxValidator> createState() =>
      _CustomCheckBoxValidatorState();
}

class _CustomCheckBoxValidatorState extends State<CustomCheckBoxValidator> {
  late bool isChecked;
  @override
  void initState() {
    isChecked = widget.isChecked;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomCheckBoxValidator oldWidget) {
    if (widget.isChecked != oldWidget.isChecked) {
      setState(() {
        isChecked = widget.isChecked;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 100,
          color: Colors.transparent,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: -14,
                left: -14,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      widget.onChanged!(value);
                    },
                    activeColor: Theme.of(context).primaryColor,
                    checkColor: Theme.of(context).colorScheme.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if(widget.navigatorPage != null){
                NavigationService().navigateTo(
                    context, widget.navigatorPage!);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(0),
              color: Colors.transparent,
              child: RichText(
                text: TextSpan(
                  text: widget.initialText,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14.0,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                  children: <TextSpan>[
                    if (widget.resaltedText != null)
                      TextSpan(
                        text: widget.resaltedText,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    if (widget.lastText != null)
                      TextSpan(
                          text: widget.lastText,
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.normal,
                          )),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
