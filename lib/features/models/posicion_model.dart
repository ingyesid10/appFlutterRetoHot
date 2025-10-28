class Posicion {
  final String nombre;
  final String descripcion;
  final List<String> ventajas;
  final List<String> desventajas;
  final String datoCurioso;
  final String imagen;

  Posicion({
    required this.nombre,
    required this.descripcion,
    required this.ventajas,
    required this.desventajas,
    required this.datoCurioso,
    required this.imagen,
  });

  factory Posicion.fromJson(Map<String, dynamic> json) {
    return Posicion(
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      ventajas: List<String>.from(json['ventajas'] ?? []),
      desventajas: List<String>.from(json['desventajas'] ?? []),
      datoCurioso: json['dato_curioso'] ?? '',
      imagen: json['imagen'] ?? '',
    );
  }
}
