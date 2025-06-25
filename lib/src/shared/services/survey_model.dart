class Survey {
  final int id;
  final String text;
  final String type;
  final int order;

  Survey({
    required this.id,
    required this.text,
    required this.type,
    required this.order,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      id: json['id'],
      text: json['text'],
      type: json['type'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'type': type,
      'order': order,
    };
  }
}
