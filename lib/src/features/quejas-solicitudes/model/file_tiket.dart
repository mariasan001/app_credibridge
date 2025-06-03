class TicketFileModel {
  final int id;
  final String filename;
  final String filetype;

  TicketFileModel({
    required this.id,
    required this.filename,
    required this.filetype,
  });

  factory TicketFileModel.fromJson(Map<String, dynamic> json) {
    return TicketFileModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      filename: json['fileName'] ?? json['filename'] ?? 'archivo_desconocido',
      filetype: json['fileType'] ?? json['filetype'] ?? 'application/octet-stream',
    );
  }
}