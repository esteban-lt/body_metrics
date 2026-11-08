/// Género elegido en el formulario. Solo se usa para mostrar el resumen;
/// la fórmula del IMC es la misma para ambos.
enum Gender { male, female }

/// Datos que captura el formulario y viajan a la pantalla de resultados.
class PersonData {
  final Gender gender;
  final double heightCm;
  final double weightKg;
  final int age;

  const PersonData({
    required this.gender,
    required this.heightCm,
    required this.weightKg,
    required this.age,
  });
}
