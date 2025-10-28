import 'package:flutter/material.dart';

class ArcadeInfoCard extends StatelessWidget {
  const ArcadeInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1B0C22).withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepPurpleAccent, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF7B2FF7),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          // 🔸 Encabezado principal
          _ArcadeParagraph(
            emoji: '🔥',
            title: '¡Bienvenidos a Hot Arcade Games!',
            text:
                'El portal de minijuegos para adultos donde la diversión y el deseo se mezclan al estilo retro arcade.',
          ),

          SizedBox(height: 14),

          // 🔸 Modo Pareja
          _ArcadeParagraph(
            emoji: '💞',
            title: 'Modo Pareja:',
            text:
                'Diseñado para juegos para parejas que buscan salir de la rutina. Con retos sensuales, juegos calientes y dinámicas románticas, cada partida despierta la pasión y la conexión.',
          ),

          SizedBox(height: 14),

          // 🔸 Modo Fiesta
          _ArcadeParagraph(
            emoji: '🎉',
            title: 'Modo Fiesta:',
            text:
                'Perfecto para grupos de amigos con ganas de reír y atreverse. Descubre juegos de beber, retos atrevidos y desafíos que suben la temperatura.',
          ),

          SizedBox(height: 14),

          // 🔸 Final
          _ArcadeParagraph(
            emoji: '💫',
            title: '',
            text:
                '¡Juega, ríe y deja que la noche comience con Hot Arcade Games!',
          ),
        ],
      ),
    );
  }
}

// 🔹 Sub-widget para cada párrafo con su emoji, título y texto
class _ArcadeParagraph extends StatelessWidget {
  final String emoji;
  final String title;
  final String text;

  const _ArcadeParagraph({
    required this.emoji,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(
      fontFamily: 'Orbitron',
      color: Colors.white.withOpacity(0.9),
      height: 1.4,
    );

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          TextSpan(
            text: '$emoji  ',
            style: const TextStyle(fontSize: 18),
          ),
          if (title.isNotEmpty)
            TextSpan(
              text: '$title ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
          TextSpan(text: text),
        ],
      ),
    );
  }
}
