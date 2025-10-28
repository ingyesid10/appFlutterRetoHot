import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TruthOrDarePage extends StatefulWidget {
  final String mode;

  const TruthOrDarePage({super.key, required this.mode});

  @override
  State<TruthOrDarePage> createState() => _TruthOrDarePageState();
}

class _TruthOrDarePageState extends State<TruthOrDarePage>
    with SingleTickerProviderStateMixin {
  final List<String> segments = ['😈 DARE', '💋 TRUTH'];
  String currentSegmentDisplay = '-';
  bool showResult = false;
  String resultName = '';
  String resultSub = '';
  bool hasSpun = false;

  Timer? spinTimer;
  late AnimationController _zoomController;
  late Animation<double> _zoomAnim;
  int countdown = 60;
  Timer? countdownTimer;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _zoomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _zoomAnim = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _zoomController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    spinTimer?.cancel();
    countdownTimer?.cancel();
    _zoomController.dispose();
    super.dispose();
  }

  void startSpin() {
    spinTimer?.cancel();
    countdownTimer?.cancel();

    setState(() {
      showResult = false;
      hasSpun = true;
    });

    spinTimer = Timer.periodic(const Duration(milliseconds: 80), (_) {
      final randomIndex = Random().nextInt(segments.length);
      setState(() {
        currentSegmentDisplay = segments[randomIndex];
      });
    });

    final duration = 1200 + Random().nextInt(1000);
    Future.delayed(Duration(milliseconds: duration), () {
      spinTimer?.cancel();
      final finalIndex = Random().nextInt(segments.length);
      setState(() {
        currentSegmentDisplay = segments[finalIndex];
      });
      _finalizeResult(finalIndex);
    });
  }

  void _finalizeResult(int index) {
    if (segments[index].contains('DARE')) {
      resultName = '🔥 Reto';
      resultSub = 'Cumple un reto atrevido elegido por tu pareja o grupo.';
    } else {
      resultName = '💋 Verdad';
      resultSub = 'Responde sinceramente la pregunta que te hagan.';
    }

    setState(() {
      showResult = true;
      countdown = 60;
    });
  }

  void startCountdown() {
    countdownTimer?.cancel();
    _zoomController.forward();
    countdown = 60;

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countdown--;
      });
      if (countdown == 5) {
        _audioPlayer.play(AssetSource('audio/beep.mp3'));
      }
      if (countdown <= 0) {
        timer.cancel();
        _zoomController.reverse();
      }
    });
  }

  void stopCountdown() {
    countdownTimer?.cancel();
    _zoomController.reverse();
  }

  void resetGame() {
    spinTimer?.cancel();
    countdownTimer?.cancel();
    _zoomController.reverse();

    setState(() {
      currentSegmentDisplay = '-';
      showResult = false;
      hasSpun = false;
      countdown = 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B0C22),
      appBar: AppBar(
        title: const Text("Verdad o Reto 🔥"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "¿Verdad o Reto?",
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  color: Colors.orangeAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Haz girar para descubrir tu destino...",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontFamily: 'PressStart2P',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ScaleTransition(
                scale: _zoomAnim,
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [Color(0xFF400030), Color(0xFF100010)],
                      center: Alignment.center,
                      radius: 0.9,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pinkAccent.withOpacity(0.8),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      currentSegmentDisplay,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Orbitron',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (hasSpun && !showResult)
                ElevatedButton(
                  onPressed: startSpin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Girar otra vez 🎲",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PressStart2P',
                    ),
                  ),
                )
              else
                ElevatedButton(
                  onPressed: startSpin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    hasSpun ? "Intentar de nuevo 🔁" : "Girar 🎲",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PressStart2P',
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              if (showResult) ...[
                Text(
                  resultName,
                  style: const TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 24,
                    fontFamily: 'Orbitron',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  resultSub,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 16,
                    fontFamily: 'PressStart2P',
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "⏱️ $countdown s",
                  style: const TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 18,
                    fontFamily: 'Orbitron',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: startCountdown,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Iniciar",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PressStart2P',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: stopCountdown,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Detener",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PressStart2P',
                        ),
                      ),
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
