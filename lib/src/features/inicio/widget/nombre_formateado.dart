String obtenerNombreFormateado(String nombreCompleto) {
  final partes = nombreCompleto.trim().split(RegExp(r'\s+'));
  if (partes.length < 2) return nombreCompleto;

  final primerApellido = _capitalizar(partes[0]);

  // Si hay al menos 3 partes, asumimos que el tercer valor es el primer nombre
  final primerNombre = partes.length > 2
      ? _capitalizar(partes[2])
      : _capitalizar(partes[1]);

  return '$primerNombre $primerApellido';
}

String _capitalizar(String texto) {
  if (texto.isEmpty) return '';
  return texto[0].toUpperCase() + texto.substring(1).toLowerCase();
}
