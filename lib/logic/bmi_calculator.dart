import '../models/person_data.dart';

/// Categorías del IMC según la OMS para adultos.
enum BmiCategory { underweight, normal, overweight, obese }

class BmiResult {
  final double bmi;
  final BmiCategory category;
  const BmiResult(this.bmi, this.category);
}

class BmiCalculator {
  /// IMC = peso (kg) / estatura (m)²
  static double calculate(double weightKg, double heightCm) {
    final meters = heightCm / 100;
    return weightKg / (meters * meters);
  }

  /// < 18.5 bajo peso · 18.5–24.9 normal · 25–29.9 sobrepeso · ≥ 30 obesidad
  static BmiCategory categorize(double bmi) {
    if (bmi < 18.5) return BmiCategory.underweight;
    if (bmi < 25) return BmiCategory.normal;
    if (bmi < 30) return BmiCategory.overweight;
    return BmiCategory.obese;
  }

  static BmiResult evaluate(PersonData p) {
    final bmi = calculate(p.weightKg, p.heightCm);
    return BmiResult(bmi, categorize(bmi));
  }
}
