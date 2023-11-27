import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyInputFormNumber extends StatefulWidget {
  const MyInputFormNumber({
    Key? key,
    required this.controller,
    required this.labelText,
    this.prefiIcon,
    required this.maxLength,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final Icon? prefiIcon;
  final int maxLength;

  @override
  State<MyInputFormNumber> createState() => _MyInputFormNumberState();
}

class _MyInputFormNumberState extends State<MyInputFormNumber> {
  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      labelText: widget.labelText,
      prefixIcon: widget.prefiIcon,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
    );

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 40, right: 16, left: 16, bottom: 8),
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              autocorrect: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLength: widget.maxLength,
              autofocus: false,
              onTapOutside: (e) {
                FocusScope.of(context).unfocus();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese su número.';
                }
                if (value.length != widget.maxLength) {
                  return 'El número debe tener ${widget.maxLength} dígitos.';
                }
                if (!_isPositiveInteger(value)) {
                  return 'Por favor, ingrese un número entero positivo.';
                }
                return null;
              },
              decoration: inputDecoration,
            ),
          ),
        ),
      ],
    );
  }

  bool _isPositiveInteger(String? value) {
    // Validar si la cadena contiene solo dígitos y es un número positivo
    return value != null && int.tryParse(value) != null && int.parse(value) > 0;
  }
}
