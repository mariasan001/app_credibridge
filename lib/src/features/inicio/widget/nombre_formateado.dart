  String obtenerNombreFormateado(String nombreCompleto) {
    final partes = nombreCompleto.trim().split(RegExp(r'\s+'));
    if (partes.length < 2) return nombreCompleto;

    final primerApellido = partes[0][0].toUpperCase() + partes[0].substring(1).toLowerCase();
    final primerNombre = partes.length > 2
        ? partes[2][0].toUpperCase() + partes[2].substring(1).toLowerCase()
        : partes[1][0].toUpperCase() + partes[1].substring(1).toLowerCase();

    return '$primerNombre $primerApellido';
  }
