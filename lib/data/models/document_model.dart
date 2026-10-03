import '../../domain/entities/document.dart';

class DocumentModel extends Document {
  DocumentModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.filePath,
    required super.createdAt,
  });

  factory DocumentModel.fromEntity(Document document) {
    return DocumentModel(
      id: document.id,
      title: document.title,
      description: document.description,
      category: document.category,
      filePath: document.filePath,
      createdAt: document.createdAt,
    );
  }

  Document toEntity() {
    return Document(
      id: id,
      title: title,
      description: description,
      category: category,
      filePath: filePath,
      createdAt: createdAt,
    );
  }
}
