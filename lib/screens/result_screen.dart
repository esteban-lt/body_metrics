import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';
import '../logic/bmi_calculator.dart';
import '../models/person_data.dart';
import '../theme/app_theme.dart';
import '../widgets/bmi_illustration.dart';
import '../widgets/fade_slide_route.dart';
import 'video_screen.dart';

/// Pantalla de resultados. Primero muestra ~1.5 s una animación de carga
/// y luego aparece el resultado con un fundido (AnimatedSwitcher).
class ResultScreen extends StatefulWidget {
  final PersonData data;
  const ResultScreen({super.key, required this.data});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _loading = true;
  late final BmiResult _result = BmiCalculator.evaluate(widget.data);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = L10n.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.t('result_title'))),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _loading
              ? _LoadingView(key: const ValueKey('loading'), text: s.t('calculating'))
              : _ResultView(
                  key: const ValueKey('result'),
                  data: widget.data,
                  result: _result),
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  final String text;
  const _LoadingView({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 72,
              height: 72,
              child: CircularProgressIndicator(strokeWidth: 6),
            ),
            const SizedBox(height: 24),
            Text(text, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      );
}

class _ResultView extends StatelessWidget {
  final PersonData data;
  final BmiResult result;
  const _ResultView({super.key, required this.data, required this.result});

  @override
  Widget build(BuildContext context) {
    final s = L10n.of(context);
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final catColor = AppTheme.categoryColor(result.category, theme.brightness);
    final onCat = AppTheme.onColor(catColor);
    final cat = result.category.name;

    final recommendations = Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.tips_and_updates_outlined, color: catColor),
              const SizedBox(width: 8),
              Text(s.t('recommendations'), style: text.titleMedium),
            ]),
            const SizedBox(height: 8),
            for (var i = 1; i <= 3; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, size: 20, color: catColor),
                    const SizedBox(width: 10),
                    Expanded(child: Text(s.t('rec_${cat}_$i'), style: text.bodyMedium)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Tarjeta principal con el color de la categoría
              Card(
                color: catColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    children: [
                      Text(s.t('your_bmi'),
                          style: text.titleMedium?.copyWith(color: onCat)),
                      Text(result.bmi.toStringAsFixed(1),
                          style: text.displayLarge?.copyWith(
                              color: onCat, fontWeight: FontWeight.bold)),
                      Text(s.t('cat_$cat').toUpperCase(),
                          style: text.titleLarge?.copyWith(
                              color: onCat, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                      const SizedBox(height: 4),
                      Text(s.t('healthy_range'),
                          style: text.bodySmall?.copyWith(color: onCat)),
                    ],
                  ),
                ),
              ),
              // Ilustración + recomendaciones: lado a lado si hay espacio.
              LayoutBuilder(builder: (context, c) {
                final illustration = Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: BmiIllustration(
                    category: result.category,
                    color: catColor,
                    size: c.maxWidth >= 520 ? 170 : (c.maxWidth * 0.45).clamp(120, 180),
                  ),
                );
                if (c.maxWidth >= 520) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [illustration, const SizedBox(width: 12), Expanded(child: recommendations)],
                  );
                }
                return Column(children: [illustration, recommendations]);
              }),
              // Resumen de los datos capturados
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.t('your_data'), style: text.titleMedium),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Chip(
                            avatar: Icon(data.gender == Gender.male ? Icons.male : Icons.female),
                            label: Text(s.t(data.gender.name)),
                          ),
                          Chip(label: Text('${data.age} ${s.t('years')}')),
                          Chip(label: Text('${data.heightCm.round()} cm')),
                          Chip(label: Text('${_fmt(data.weightKg)} kg')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                onPressed: () => Navigator.push(context, fadeSlideRoute(const VideoScreen())),
                icon: const Icon(Icons.play_circle_outline),
                label: Text(s.t('video_button')),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.refresh),
                label: Text(s.t('recalculate')),
              ),
              const SizedBox(height: 12),
              Text(s.t('disclaimer'),
                  textAlign: TextAlign.center,
                  style: text.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ],
          ),
        ),
      ),
    );
  }

  String _fmt(double v) => v % 1 == 0 ? v.toInt().toString() : v.toStringAsFixed(1);
}
