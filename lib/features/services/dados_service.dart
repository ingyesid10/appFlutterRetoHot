import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/posicion_model.dart';

class DadosService {
  /// 🔹 Método original: carga el JSON general
  Future<Map<String, Posicion>> cargarDatos(String idioma) async {
    try {
      final String data = await rootBundle.loadString('assets/data/dados_$idioma.json');
      final Map<String, dynamic> jsonMap = json.decode(data);
      return jsonMap.map((key, value) => MapEntry(key, Posicion.fromJson(value)));
    } catch (e) {
      print('❌ Error cargando JSON general: $e');
      return {};
    }
  }

  /// 🔹 Nuevo método: carga el JSON específico para Dado Oral
  Future<Map<String, Posicion>> cargarDatosOral(String idioma) async {
    try {
      // Validamos idioma y ruta
      final String path = 'assets/data/dadosOral_$idioma.json';
      final String data = await rootBundle.loadString(path);

      final Map<String, dynamic> jsonMap = json.decode(data);

      // Convertimos cada posición a objeto Posicion
      return jsonMap.map((key, value) => MapEntry(key, Posicion.fromJson(value)));
    } catch (e) {
      print('❌ Error cargando JSON Oral: $e');
      return {};
    }
  }
}
