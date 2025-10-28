import 'package:flutter/material.dart';

class LangSwitch extends StatelessWidget {
  final Locale currentLocale;
  final void Function(Locale) onChange;

  const LangSwitch({
    super.key,
    required this.currentLocale,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => onChange(const Locale('es')),
          child: Opacity(
            opacity: currentLocale.languageCode == 'es' ? 1 : 0.5,
            child: const Text('🇪🇸', style: TextStyle(fontSize: 28)),
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () => onChange(const Locale('en')),
          child: Opacity(
            opacity: currentLocale.languageCode == 'en' ? 1 : 0.5,
            child: const Text('🇺🇸', style: TextStyle(fontSize: 28)),
          ),
        ),
      ],
    );
  }
}
