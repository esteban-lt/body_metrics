import 'package:flutter/material.dart';

import '../logic/bmi_calculator.dart';

/// Tema claro y oscuro de la app (Material 3, a partir de un color semilla).
class AppTheme {
  static const _seed = Color(0xFF00897B); // verde azulado

  /// Color de cada categoría. En modo oscuro se usan tonos más claros para
  /// que no se pierdan sobre el fondo oscuro.
  static Color categoryColor(BmiCategory c, Brightness b) {
    final dark = b == Brightness.dark;
    switch (c) {
      case BmiCategory.underweight:
        return dark ? const Color(0xFF64B5F6) : const Color(0xFF1E88E5); // azul
      case BmiCategory.normal:
        return dark ? const Color(0xFF66BB6A) : const Color(0xFF2E7D32); // verde
      case BmiCategory.overweight:
        return dark ? const Color(0xFFFFD54F) : const Color(0xFFF9A825); // amarillo
      case BmiCategory.obese:
        return dark ? const Color(0xFFEF5350) : const Color(0xFFC62828); // rojo
    }
  }

  /// Texto blanco o negro, el que contraste mejor con [background]
  /// (por ejemplo, negro sobre amarillo).
  static Color onColor(Color background) =>
      ThemeData.estimateBrightnessForColor(background) == Brightness.dark
          ? Colors.white
          : Colors.black87;

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme =
        ColorScheme.fromSeed(seedColor: _seed, brightness: brightness);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      // AppBar personalizado: centrado, con color de marca y esquinas redondeadas.
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: scheme.onPrimaryContainer,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}
