import 'package:flutter/material.dart';

class RetoHotTitle extends StatelessWidget {
  final String text; // ← texto dinámico

  const RetoHotTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3A0CA3), Color(0xFF7209B7), Color(0xFF480CA8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orangeAccent, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.deepOrangeAccent,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Orbitron', // fuente tipo arcade
          fontSize: 14,
          color: Color(0xFFFFA500),
          letterSpacing: 1.2,
          shadows: [
            Shadow(
              blurRadius: 8,
              color: Colors.orangeAccent,
              offset: Offset(0, 0),
            ),
          ],
        ),
      ),
    );
  }
}
