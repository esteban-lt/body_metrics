import 'package:flutter/material.dart';

import 'l10n/app_strings.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const BodyMetricsApp());

class BodyMetricsApp extends StatelessWidget {
  const BodyMetricsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BodyMetrics',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      // L10n envuelve al Navigator: todas las pantallas leen el idioma de aquí.
      builder: (context, child) => L10n(child: child!),
      home: const HomeScreen(),
    );
  }
}
