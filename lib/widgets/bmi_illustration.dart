import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../logic/bmi_calculator.dart';

/// Ilustración propia en SVG (dibujada aquí mismo, sin recursos externos).
/// Una figura sencilla cuyo cuerpo se ensancha según la categoría, con una
/// insignia: flecha hacia arriba (subir peso), palomita (rango sano) o
/// flecha hacia abajo (bajar peso).
class BmiIllustration extends StatelessWidget {
  final BmiCategory category;
  final Color color;
  final double size;

  const BmiIllustration(
      {super.key, required this.category, required this.color, this.size = 180});

  static const _bodyWidth = {
    BmiCategory.underweight: 34.0,
    BmiCategory.normal: 56.0,
    BmiCategory.overweight: 80.0,
    BmiCategory.obese: 104.0,
  };

  String _hex(Color c) =>
      '#${c.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';

  String _svg() {
    final c = _hex(color);
    final w = _bodyWidth[category]!;
    final half = w / 2;
    final legOff = w * 0.2 + 5;
    final badge = switch (category) {
      BmiCategory.underweight => 'M160 52 V28 M150 38 L160 28 L170 38',
      BmiCategory.normal => 'M150 40 L157 47 L171 32',
      _ => 'M160 28 V52 M150 42 L160 52 L170 42',
    };
    return '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 220">
  <circle cx="100" cy="112" r="100" fill="$c" fill-opacity="0.15"/>
  <ellipse cx="100" cy="206" rx="${half + 16}" ry="8" fill="#000000" fill-opacity="0.15"/>
  <line x1="${100 - legOff}" y1="150" x2="${100 - legOff}" y2="198" stroke="$c" stroke-width="15" stroke-linecap="round"/>
  <line x1="${100 + legOff}" y1="150" x2="${100 + legOff}" y2="198" stroke="$c" stroke-width="15" stroke-linecap="round"/>
  <line x1="${100 - half + 6}" y1="88" x2="${100 - half - 14}" y2="138" stroke="$c" stroke-width="12" stroke-linecap="round"/>
  <line x1="${100 + half - 6}" y1="88" x2="${100 + half + 14}" y2="138" stroke="$c" stroke-width="12" stroke-linecap="round"/>
  <ellipse cx="100" cy="116" rx="$half" ry="46" fill="$c"/>
  <circle cx="100" cy="46" r="22" fill="$c"/>
  <circle cx="160" cy="40" r="20" fill="#ffffff" stroke="$c" stroke-width="3"/>
  <path d="$badge" fill="none" stroke="$c" stroke-width="5" stroke-linecap="round" stroke-linejoin="round"/>
</svg>''';
  }

  @override
  Widget build(BuildContext context) =>
      SvgPicture.string(_svg(), width: size, height: size * 1.1);
}
