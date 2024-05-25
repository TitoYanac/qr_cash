import 'dart:math';
import 'package:flutter/material.dart';

Color generarColorPastelRandom() {
  Random random = Random();

  // Generar componentes RGB en el rango adecuado para colores pasteles
  int red = 150 + random.nextInt(56); // Rango: 150-206
  int green = 150 + random.nextInt(56); // Rango: 150-206
  int blue = 150 + random.nextInt(56); // Rango: 150-206

  return Color.fromARGB(255, red, green, blue);
}

List<Color> generarColoresPastelesRandom(int cantidad) {
  List<Color> colores = [];

  for (int i = 0; i < cantidad; i++) {
    colores.add(generarColorPastelRandom());
  }

  return colores;
}
