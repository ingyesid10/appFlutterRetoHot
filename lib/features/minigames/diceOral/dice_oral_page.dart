import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../models/posicion_model.dart';
import '../../services/dados_service.dart';

class DiceOralPage extends StatefulWidget {
  final String mode;
  const DiceOralPage({Key? key, required this.mode}) : super(key: key);

  @override
  State<DiceOralPage> createState() => _DiceOralPageState();
}

class _DiceOralPageState extends State<DiceOralPage> with TickerProviderStateMixin {
  final DadosService _dadosService = DadosService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  Map<String, Posicion> _posiciones = {};
  Posicion? _posicionActual;
  int dado1 = 1;
  int dado2 = 1;
  bool cargando = true;
  bool girando = false;

  late AnimationController _controller;
  late Animation<double> _anim;

  late AnimationController _zoomController;
  late Animation<double> _zoomAnim;

  Timer? _timer;
  int tiempoRestante = 60;
  int tiempoConfigurado = 60;
  bool corriendo = false;

  @override
  void initState() {
    super.initState();
    _cargarDatosOral();

    // Animación de los dados
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _anim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    // Animación de zoom de la imagen
    _zoomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _zoomAnim = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _zoomController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _zoomController.dispose();
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _cargarDatosOral() async {
    final datos = await _dadosService.cargarDatosOral('es');
    setState(() {
      _posiciones = datos;
      cargando = false;
    });
  }

  Future<void> _tirarDados() async {
    if (girando) return;
    setState(() => girando = true);

    final random = Random();

    // Efecto tipo "spinFake" al girar los dados
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 80));
      setState(() {
        dado1 = random.nextInt(4) + 1;
        dado2 = random.nextInt(4) + 1;
      });
    }

    final key = '$dado1-$dado2';
    final reversedKey = '$dado2-$dado1';
    setState(() {
      _posicionActual = _posiciones[key] ?? _posiciones[reversedKey];
      girando = false;
    });

    _controller.forward(from: 0);
    _zoomController.forward(from: 0); // 🔥 zoom al mostrar imagen
    _reiniciarVisualTemporizador();
  }

  void _iniciarTemporizador() {
    _timer?.cancel();
    setState(() {
      corriendo = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (tiempoRestante <= 0) {
        timer.cancel();
        setState(() => corriendo = false);
      } else {
        setState(() => tiempoRestante--);
        if (tiempoRestante == 5) {
          await _audioPlayer.play(AssetSource('audio/beep.mp3'));
        }
      }
    });
  }

  void _detenerTemporizador() {
    _timer?.cancel();
    setState(() => corriendo = false);
  }

  void _reiniciarVisualTemporizador() {
    _detenerTemporizador();
    setState(() {
      tiempoRestante = tiempoConfigurado;
    });
  }

  void _mostrarDialogoTiempo() {
    final controller = TextEditingController(text: tiempoConfigurado.toString());
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF13001F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text(
          "Configurar Tiempo",
          style: TextStyle(
            fontFamily: 'Orbitron',
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Segundos",
            hintStyle: TextStyle(color: Colors.white38),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar", style: TextStyle(color: Colors.redAccent)),
          ),
          TextButton(
            onPressed: () {
              final nuevo = int.tryParse(controller.text);
              if (nuevo != null && nuevo > 0) {
                setState(() {
                  tiempoConfigurado = nuevo;
                  tiempoRestante = nuevo;
                });
              }
              Navigator.pop(ctx);
            },
            child: const Text("Guardar", style: TextStyle(color: Colors.cyanAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFiesta = widget.mode == 'fiesta';
    final colorPrimario = isFiesta ? Colors.redAccent : Colors.pinkAccent;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0014),
      appBar: AppBar(
        backgroundColor: const Color(0xFF320043),
        title: Text(
          widget.mode == 'pareja' ? 'Modo Pareja ❤️' : 'Modo Fiesta 🎉',
          style: const TextStyle(
            fontFamily: 'Orbitron',
            color: Color(0xFF00FFFF),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: cargando
          ? const Center(child: CircularProgressIndicator(color: Colors.pinkAccent))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 15),

            // 🎲 Dados
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ScaleTransition(scale: _anim, child: _buildDiceBox(dado1)),
                ScaleTransition(scale: _anim, child: _buildDiceBox(dado2)),
              ],
            ),

            const SizedBox(height: 20),

            // Botón Lanzar
            ElevatedButton.icon(
              onPressed: _tirarDados,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellowAccent,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 36),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                elevation: 10,
                shadowColor: Colors.cyanAccent,
              ),
              icon: const Icon(Icons.casino, color: Colors.black),
              label: const Text(
                'Lanzar Dados',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Orbitron',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Resultado
            AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: _posicionActual == null ? 0.6 : 1,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF13001F),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: colorPrimario.withOpacity(0.6),
                      blurRadius: 12,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: _posicionActual == null
                    ? const Text(
                  '🎯 Presiona “Lanzar Dados” para descubrir una posición',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white60,
                    fontFamily: 'Orbitron',
                    fontSize: 13,
                  ),
                )
                    : _buildResultado(_posicionActual!, colorPrimario),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🎲 Caja de dado
  Widget _buildDiceBox(int valor) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 85,
      height: 85,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.cyanAccent, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.6),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        valor.toString(),
        style: const TextStyle(
          fontFamily: 'Orbitron',
          fontSize: 34,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildResultado(Posicion pos, Color colorPrimario) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 🔹 Título
        Text(
          pos.nombre,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Orbitron',
            color: colorPrimario,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // 🔹 Imagen con zoom suave
        if (pos.imagen.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SizedBox(
              height: 280,
              child: Center(
                child: AnimatedScale(
                  scale: corriendo ? 1.15 : 1.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      pos.imagen,
                      fit: BoxFit.contain,
                      height: 260,
                    ),
                  ),
                ),
              ),
            ),
          ),

        // 🔹 Tiempo debajo de la imagen
        if (_posicionActual != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 10),
            child: Text(
              "$tiempoRestante s",
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 28,
                color: corriendo ? Colors.cyanAccent : Colors.white54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        // 🔹 Descripción
        Text(
          pos.descripcion,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Orbitron',
            color: Colors.white70,
            fontSize: 14,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 15),

        // 🔹 Botón Iniciar / Detener justo debajo de la descripción
        if (_posicionActual != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: corriendo
                    ? Colors.redAccent
                    : const Color.fromARGB(255, 255, 0, 149),
                padding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                      color: corriendo
                          ? Colors.redAccent.shade100
                          : Colors.pinkAccent.shade100,
                      width: 2),
                ),
                shadowColor: Colors.pinkAccent,
                elevation: 8,
              ),
              onPressed: () {
                if (corriendo) {
                  _detenerTemporizador();
                } else {
                  _iniciarTemporizador();
                }
              },
              child: Text(
                corriendo ? "Detener ⏸️" : "Iniciar ▶️",
                style: const TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        const SizedBox(height: 15),

        // 🔹 Ventajas
        if (pos.ventajas.isNotEmpty)
          _buildCard("💚 Ventajas", pos.ventajas, Colors.greenAccent),

        // 🔹 Desventajas
        if (pos.desventajas.isNotEmpty)
          _buildCard("💢 Desventajas", pos.desventajas, Colors.redAccent),
      ],
    );
  }


  Widget _buildCard(String titulo, List<String> lista, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.6), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontFamily: 'Orbitron',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          ...lista.map((txt) => Text(
            "• $txt",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Orbitron',
              fontSize: 13,
              color: Colors.white,
              height: 1.4,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTimerControl(Color colorPrimario) {
    return Column(
      children: [
        Text(
          "$tiempoRestante s",
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 30,
            color: corriendo ? Colors.cyanAccent : Colors.white54,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.timer, color: Colors.amberAccent),
              onPressed: _mostrarDialogoTiempo,
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: corriendo ? _detenerTemporizador : _iniciarTemporizador,
              style: ElevatedButton.styleFrom(
                backgroundColor: corriendo ? Colors.redAccent : Colors.greenAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                corriendo ? 'Detener' : 'Iniciar',
                style: const TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
