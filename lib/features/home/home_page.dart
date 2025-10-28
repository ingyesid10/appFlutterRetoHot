import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../games/games_page.dart';
import '../../ui/widgets/reto_hot_title.dart';
import '../../ui/widgets/arcade_info_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // 🔹 Fondo espacial con gradiente púrpura y azul oscuro
          gradient: LinearGradient(
            colors: [Color(0xFF1B0C22), Color(0xFF2A1451), Color(0xFF0E071B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            image: AssetImage('assets/img/bg/bg_08.jpeg'),
            fit: BoxFit.cover,
            opacity: 0.35,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // 🔹 LOGO
                  Image.asset(
                    'assets/img/icon/logoPP.png',
                    height: 90,
                  ),

                  const SizedBox(height: 15),

                  // 🔹 TÍTULO principal con efecto neón
                  const RetoHotTitle('🔥 Reto Hot: juegos picantes y retos para parejas 🔥'),

                  const SizedBox(height: 40),

                  // 🔹 Subtítulo
                  const Text(
                    'Elige tu modo de juego:',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Orbitron',
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 🔹 Grid de modos de juego
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 25,
                      children: [
                        _buildCategoryCard(
                          context,
                          title: 'Modo Pareja',
                          image: 'assets/img/icon/pareja.png',
                          color: Colors.pinkAccent,
                          mode: 'pareja',
                        ),
                        _buildCategoryCard(
                          context,
                          title: 'Modo Fiesta',
                          image: 'assets/img/icon/fiesta.png',
                          color: Colors.cyanAccent,
                          mode: 'fiesta',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 🔹 Información tipo "tarjeta arcade"
                  const ArcadeInfoCard(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Widget reutilizable para cada categoría
  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required String image,
    required Color color,
    required String mode,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GamesPage(mode: mode)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.3), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Orbitron',
                shadows: [
                  Shadow(
                    blurRadius: 8,
                    color: color.withOpacity(0.7),
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
