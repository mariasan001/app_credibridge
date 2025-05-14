String capitalizarSoloPrimera(String texto) {
  if (texto.trim().isEmpty) return '';
  texto = texto.toLowerCase();
  return texto[0].toUpperCase() + texto.substring(1);
}
