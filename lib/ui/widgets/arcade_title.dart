import 'package:flutter/material.dart';

class ArcadeTitle extends StatelessWidget {
  final String text;

  const ArcadeTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF2A1041), Color(0xFF1B0C22)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(
          color: const Color(0xFF7030A0),
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFFC8503),
            blurRadius: 15,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Orbitron',
          color: Color(0xFFFFA726),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
