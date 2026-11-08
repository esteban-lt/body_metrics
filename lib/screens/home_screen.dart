import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';
import '../models/person_data.dart';
import '../widgets/counter_field.dart';
import '../widgets/fade_slide_route.dart';
import '../widgets/gender_selector.dart';
import 'result_screen.dart';

/// Pantalla principal: formulario con género, estatura, edad y peso.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _weightCtrl = TextEditingController(text: '70');
  final _ageCtrl = TextEditingController(text: '25');
  Gender _gender = Gender.male;
  double _height = 170;

  @override
  void dispose() {
    _weightCtrl.dispose();
    _ageCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    final s = L10n.of(context);
    if (!(_formKey.currentState?.validate() ?? false)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(s.t('err_form'))));
      return;
    }
    final data = PersonData(
      gender: _gender,
      heightCm: _height,
      weightKg: double.parse(_weightCtrl.text),
      age: int.parse(_ageCtrl.text),
    );
    FocusScope.of(context).unfocus();
    Navigator.push(context, fadeSlideRoute(ResultScreen(data: data)));
  }

  @override
  Widget build(BuildContext context) {
    final s = L10n.of(context);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    final weightField = CounterField(
      label: s.t('weight'),
      unit: 'kg',
      controller: _weightCtrl,
      min: 20,
      max: 300,
      step: 0.5,
      decimal: true,
      onChanged: () => setState(() {}),
      validator: (v) {
        final n = double.tryParse(v ?? '');
        if (n == null) return s.t('err_empty');
        if (n < 20 || n > 300) return s.t('err_weight');
        return null;
      },
    );
    final ageField = CounterField(
      label: s.t('age'),
      unit: s.t('years'),
      controller: _ageCtrl,
      min: 18,
      max: 100,
      onChanged: () => setState(() {}),
      validator: (v) {
        final n = int.tryParse(v ?? '');
        if (n == null) return s.t('err_empty');
        if (n < 18 || n > 100) return s.t('err_age');
        return null;
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.monitor_weight_outlined),
        title: Text(s.t('app_title')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              // En tablets o en horizontal el formulario no se estira de más.
              constraints: const BoxConstraints(maxWidth: 600),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Género
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(s.t('gender'), style: text.titleMedium),
                            const SizedBox(height: 12),
                            GenderSelector(
                              value: _gender,
                              onChanged: (g) => setState(() => _gender = g),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Estatura con Slider
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Column(
                          children: [
                            Text(s.t('height'), style: text.titleMedium),
                            const SizedBox(height: 4),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: '${_height.round()}',
                                style: text.displaySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: scheme.primary),
                              ),
                              TextSpan(text: ' cm', style: text.titleMedium),
                            ])),
                            Slider(
                              value: _height,
                              min: 100,
                              max: 220,
                              divisions: 120,
                              label: '${_height.round()} cm',
                              onChanged: (v) => setState(() => _height = v),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Edad y peso: lado a lado si cabe, uno debajo del otro si no.
                    LayoutBuilder(builder: (context, c) {
                      if (c.maxWidth >= 340) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: ageField),
                            const SizedBox(width: 12),
                            Expanded(child: weightField),
                          ],
                        );
                      }
                      return Column(children: [ageField, weightField]);
                    }),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: _calculate,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      icon: const Icon(Icons.calculate_outlined),
                      label: Text(s.t('calculate')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
