import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';
import '../models/person_data.dart';

/// Selector de género con ToggleButtons e iconos. Cada botón ocupa la mitad
/// del ancho disponible (LayoutBuilder), así no se desborda en pantallas chicas.
class GenderSelector extends StatelessWidget {
  final Gender value;
  final ValueChanged<Gender> onChanged;

  const GenderSelector(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final s = L10n.of(context);
    final scheme = Theme.of(context).colorScheme;
    return LayoutBuilder(builder: (context, constraints) {
      final half = (constraints.maxWidth - 4) / 2;
      return ToggleButtons(
        isSelected: [value == Gender.male, value == Gender.female],
        onPressed: (i) => onChanged(i == 0 ? Gender.male : Gender.female),
        borderRadius: BorderRadius.circular(12),
        constraints: BoxConstraints(minWidth: half, minHeight: 56),
        selectedColor: scheme.onSecondaryContainer,
        fillColor: scheme.secondaryContainer,
        children: [
          _option(Icons.male, s.t('male')),
          _option(Icons.female, s.t('female')),
        ],
      );
    });
  }

  Widget _option(IconData icon, String label) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      );
}
