import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Tarjeta con un campo numérico y botones − / + (se usa para Edad y Peso).
///
/// - `inputFormatters` impide escribir letras: solo deja pasar dígitos
///   (y un punto decimal si [decimal] es true).
/// - `validator` revisa el rango; con `AutovalidateMode.onUserInteraction`
///   en el Form, el error aparece mientras se escribe.
class CounterField extends StatelessWidget {
  final String label;
  final String unit;
  final TextEditingController controller;
  final double min;
  final double max;
  final double step;
  final bool decimal;
  final String? Function(String?) validator;
  final VoidCallback onChanged;

  const CounterField({
    super.key,
    required this.label,
    required this.unit,
    required this.controller,
    required this.min,
    required this.max,
    required this.validator,
    required this.onChanged,
    this.step = 1,
    this.decimal = false,
  });

  void _bump(double delta) {
    final current = double.tryParse(controller.text) ?? min;
    final next = (current + delta).clamp(min, max);
    controller.text = next % 1 == 0 ? next.toInt().toString() : next.toStringAsFixed(1);
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
        child: Column(
          children: [
            Text('$label ($unit)', style: text.titleMedium),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller,
              textAlign: TextAlign.center,
              style: text.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              keyboardType: TextInputType.numberWithOptions(decimal: decimal),
              inputFormatters: [
                decimal
                    ? FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}(\.\d?)?'))
                    : FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(decimal ? 5 : 3),
              ],
              decoration: const InputDecoration(
                errorMaxLines: 2,
                contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              ),
              validator: validator,
              onChanged: (_) => onChanged(),
              // Cierra el teclado al tocar fuera del campo.
              onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton.small(
                  heroTag: null,
                  tooltip: '−$step',
                  onPressed: () => _bump(-step),
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton.small(
                  heroTag: null,
                  tooltip: '+$step',
                  onPressed: () => _bump(step),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
