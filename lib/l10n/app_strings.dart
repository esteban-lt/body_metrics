import 'package:flutter/widgets.dart';

/// Idioma actual de la app ('es' o 'en'). Cambiarlo reconstruye al instante
/// todos los widgets que leen textos con [L10n.of].
final appLanguage = ValueNotifier<String>('es');

/// Pone el idioma al alcance de todo el árbol. Cada widget que llama a
/// [L10n.of] queda suscrito y se redibuja cuando cambia [appLanguage].
class L10n extends InheritedNotifier<ValueNotifier<String>> {
  L10n({super.key, required super.child}) : super(notifier: appLanguage);

  static Strings of(BuildContext context) {
    final lang =
        context.dependOnInheritedWidgetOfExactType<L10n>()!.notifier!.value;
    return Strings(lang);
  }
}

/// Acceso a los textos traducidos: `L10n.of(context).t('calculate')`.
class Strings {
  final String lang;
  const Strings(this.lang);

  String t(String key) => (_texts[lang] ?? _texts['es']!)[key] ?? key;
}

const Map<String, Map<String, String>> _texts = {
  'es': {
    'app_title': 'BodyMetrics',
    'gender': 'Género',
    'male': 'Hombre',
    'female': 'Mujer',
    'height': 'Estatura',
    'weight': 'Peso',
    'age': 'Edad',
    'years': 'años',
    'calculate': 'Calcular',
    'err_empty': 'Escribe un valor',
    'err_weight': 'Entre 20 y 300 kg',
    'err_age': 'Entre 18 y 100 años',
    'err_form': 'Revisa los campos marcados en rojo',
  },
};
