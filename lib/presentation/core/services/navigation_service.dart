import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;

  NavigationService._internal();

  // Navegación básica
  Future<dynamic> navigateTo(BuildContext context, Widget screen) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => screen,
    ));
  }

  // Reemplazar la pantalla actual con una nueva
  Future<dynamic> replaceWith(BuildContext context, Widget screen) {
    return Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => screen,
    ));
  }

  // Navegación y eliminación de todas las pantallas anteriores
  Future<dynamic> navigateToAndRemoveUntil(BuildContext context, Widget screen) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
          (Route<dynamic> route) => false,
    );
  }

  // Regresar a la pantalla anterior
  void goBack(BuildContext context, {dynamic result}) {
    Navigator.of(context).pop(result);
  }
}
