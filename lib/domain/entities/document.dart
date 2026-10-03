class Document {
  final int id;
  final String title;
  final String description;
  final String category;
  final String filePath;
  final DateTime createdAt;

  Document({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.filePath,
    required this.createdAt,
  });

  Document copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    String? filePath,
    DateTime? createdAt,
  }) {
    return Document(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      filePath: filePath ?? this.filePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
