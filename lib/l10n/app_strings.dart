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
    'result_title': 'Tu resultado',
    'calculating': 'Calculando tu IMC…',
    'your_bmi': 'Tu IMC',
    'cat_underweight': 'Bajo peso',
    'cat_normal': 'Peso normal',
    'cat_overweight': 'Sobrepeso',
    'cat_obese': 'Obesidad',
    'healthy_range': 'Rango saludable: 18.5 – 24.9',
    'recommendations': 'Recomendaciones',
    'rec_underweight_1': 'Agrega colaciones nutritivas entre comidas, como frutos secos, lácteos o aguacate.',
    'rec_underweight_2': 'Incluye proteína en cada comida para ganar masa muscular.',
    'rec_underweight_3': 'Haz ejercicio de fuerza ligero y, si te cuesta subir de peso, consulta a un nutriólogo.',
    'rec_normal_1': '¡Vas muy bien! Mantén una alimentación variada con frutas, verduras y proteína.',
    'rec_normal_2': 'Muévete al menos 150 minutos a la semana.',
    'rec_normal_3': 'Duerme bien y toma suficiente agua para sostener tus hábitos.',
    'rec_overweight_1': 'Reduce las bebidas azucaradas y los alimentos ultraprocesados.',
    'rec_overweight_2': 'Camina a paso rápido o haz ejercicio de bajo impacto 30 minutos al día.',
    'rec_overweight_3': 'Cuida las porciones: llena la mitad del plato con verduras.',
    'rec_obese_1': 'Consulta a un médico o nutriólogo para tener un plan seguro y a tu medida.',
    'rec_obese_2': 'Empieza con actividad de bajo impacto (caminar, bici fija, nadar) y sube poco a poco.',
    'rec_obese_3': 'Ponte metas pequeñas: bajar entre 5 y 10 % de tu peso ya trae beneficios.',
    'your_data': 'Tus datos',
    'video_button': 'Rutina sugerida de bajo impacto',
    'recalculate': 'Volver a calcular',
    'disclaimer': 'Esta app es solo orientativa y no sustituye la opinión de un profesional de la salud.',
    'video_title': 'Rutina sugerida',
    'video_desc': 'Rutina de 30 minutos de bajo impacto para principiantes (canal Body Project en YouTube, en inglés). Ve a tu ritmo y detente si sientes alguna molestia.',
    'language': 'Idioma',
  },
  'en': {
    'app_title': 'BodyMetrics',
    'gender': 'Gender',
    'male': 'Male',
    'female': 'Female',
    'height': 'Height',
    'weight': 'Weight',
    'age': 'Age',
    'years': 'years',
    'calculate': 'Calculate',
    'err_empty': 'Enter a value',
    'err_weight': 'Between 20 and 300 kg',
    'err_age': 'Between 18 and 100 years',
    'err_form': 'Check the fields marked in red',
    'result_title': 'Your result',
    'calculating': 'Calculating your BMI…',
    'your_bmi': 'Your BMI',
    'cat_underweight': 'Underweight',
    'cat_normal': 'Normal weight',
    'cat_overweight': 'Overweight',
    'cat_obese': 'Obesity',
    'healthy_range': 'Healthy range: 18.5 – 24.9',
    'recommendations': 'Recommendations',
    'rec_underweight_1': 'Add nutritious snacks between meals, like nuts, dairy or avocado.',
    'rec_underweight_2': 'Include protein in every meal to build muscle.',
    'rec_underweight_3': 'Do light strength training and, if gaining weight is hard, see a nutritionist.',
    'rec_normal_1': "You're doing great! Keep a varied diet with fruit, vegetables and protein.",
    'rec_normal_2': 'Move at least 150 minutes a week.',
    'rec_normal_3': 'Sleep well and drink enough water to keep your habits going.',
    'rec_overweight_1': 'Cut back on sugary drinks and ultra-processed food.',
    'rec_overweight_2': 'Walk briskly or do low-impact exercise 30 minutes a day.',
    'rec_overweight_3': 'Watch your portions: fill half your plate with vegetables.',
    'rec_obese_1': 'See a doctor or nutritionist for a safe plan made for you.',
    'rec_obese_2': 'Start with low-impact activity (walking, stationary bike, swimming) and build up slowly.',
    'rec_obese_3': 'Set small goals: losing 5 to 10 % of your weight already brings benefits.',
    'your_data': 'Your data',
    'video_button': 'Suggested low-impact routine',
    'recalculate': 'Calculate again',
    'disclaimer': 'This app is for guidance only and does not replace advice from a health professional.',
    'video_title': 'Suggested routine',
    'video_desc': '30-minute low-impact routine for beginners (Body Project channel on YouTube). Go at your own pace and stop if anything hurts.',
    'language': 'Language',
  },
};
