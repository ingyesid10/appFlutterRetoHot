import 'package:flutter/material.dart';
import '../minigames/dice/dice_page.dart';
import '../minigames/truth_or_dare/truth_or_dare_page.dart';
import '../minigames/diceOral/dice_oral_page.dart';

class GamesPage extends StatelessWidget {
  final String mode;
  const GamesPage({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    final isFiesta = mode == 'fiesta';

    final List<Map<String, dynamic>> games = [
      {
        'title': 'Tragos y cartas',
        'icon': Icons.local_bar,
        'color': Colors.pinkAccent,
        'action': () {},
      },
      {
        'title': 'Verdad/Reto simple',
        'icon': Icons.help_outline,
        'color': Colors.deepPurpleAccent,
        'action': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TruthOrDarePage(mode: mode)),
          );
        },
      },
      {
        'title': 'Ruleta de Besos',
        'icon': Icons.favorite,
        'color': Colors.redAccent,
        'action': () {},
      },
      {
        'title': 'Retos, baile, preguntas...',
        'icon': Icons.celebration,
        'color': Colors.orangeAccent,
        'action': () {},
      },
      {
        'title': 'Verdad/Reto o Prenda',
        'icon': Icons.whatshot,
        'color': Colors.pink,
        'action': () {},
      },
      {
        'title': 'Tragos rápidos',
        'icon': Icons.local_drink,
        'color': Colors.tealAccent[700],
        'action': () {},
      },
      {
        'title': 'Dados Kamasutra',
        'icon': Icons.casino,
        'color': Colors.blueAccent,
        'action': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DicePage(mode: mode)),
          );
        },
      },
      {
        'title': 'Dados Kamasutra Orales 🔥',
        'icon': Icons.spa,
        'color': Colors.purpleAccent,
        'action': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DiceOralPage(mode: mode)),
          );
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(isFiesta ? 'Modo Fiesta 🎉' : 'Modo Pareja ❤️'),
        backgroundColor: isFiesta ? Colors.redAccent : Colors.pinkAccent,
      ),
      backgroundColor: const Color(0xFF1B0C22),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Bienvenido, elige una categoría:',
              style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.builder(
                itemCount: games.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // dos por fila
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final game = games[index];
                  return GestureDetector(
                    onTap: game['action'],
                    child: Container(
                      decoration: BoxDecoration(
                        color: game['color']!.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: game['color']!,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: game['color']!.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(game['icon'], color: game['color'], size: 45),
                          const SizedBox(height: 12),
                          Text(
                            game['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '🌀 ¡Cada día hay algo nuevo! Más juegos, más retos y más experiencias picantes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
