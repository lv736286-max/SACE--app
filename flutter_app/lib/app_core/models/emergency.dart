class Emergency {
  final String id;
  final String type;
  final String location;
  final String description;
  final DateTime createdAt;

  Emergency({required this.id, required this.type, required this.location, required this.description, DateTime? createdAt}) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'location': location,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Emergency.fromJson(Map<String, dynamic> json) => Emergency(
        id: json['id'] ?? '',
        type: json['type'] ?? '',
        location: json['location'] ?? '',
        description: json['description'] ?? '',
        createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      );
}
