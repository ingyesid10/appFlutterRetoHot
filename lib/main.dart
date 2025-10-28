import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/home/home_page.dart';
import 'theme/theme.dart'; // 👈 tu nuevo tema global
import 'ui/widgets/neon_background.dart'; // 👈 fondo animado

void main() {
  runApp(const RetoHotApp());
}

class RetoHotApp extends StatelessWidget {
  const RetoHotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reto Hot 🔥',
      debugShowCheckedModeBanner: false,

      // 👇 Se usa el tema retro arcade que definimos en theme.dart
      theme: neonArcadeTheme,

      // 🌎 Soporte para español e inglés
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
      ],

      // 🪩 El fondo animado se aplica a toda la app
      home: const NeonBackground(
        child: HomePage(),
      ),
    );
  }
}
