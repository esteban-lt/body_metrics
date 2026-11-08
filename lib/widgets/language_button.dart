import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';

/// Selector de idioma para el AppBar. Al elegir una opción cambia
/// [appLanguage] y toda la app se redibuja al instante, sin reiniciar.
class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final s = L10n.of(context);
    return PopupMenuButton<String>(
      tooltip: s.t('language'),
      initialValue: s.lang,
      onSelected: (lang) => appLanguage.value = lang,
      itemBuilder: (_) => const [
        PopupMenuItem(value: 'es', child: Text('🇲🇽  Español')),
        PopupMenuItem(value: 'en', child: Text('🇺🇸  English')),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.translate),
            const SizedBox(width: 4),
            Text(s.lang.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
