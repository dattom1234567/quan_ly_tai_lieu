import '../../domain/entities/document.dart';

class DocumentLocalDataSource {
  final List<Document> _documents = [];

  List<Document> getDocuments() {
    return List.unmodifiable(_documents);
  }

  void addDocument(Document document) {
    _documents.add(document);
  }

  void updateDocument(Document document) {
    final index = _documents.indexWhere((item) => item.id == document.id);

    if (index != -1) {
      _documents[index] = document;
    }
  }

  void deleteDocument(int id) {
    _documents.removeWhere((item) => item.id == id);
  }

  List<Document> searchDocuments(String keyword) {
    final value = keyword.toLowerCase().trim();

    if (value.isEmpty) {
      return getDocuments();
    }

    return _documents.where((document) {
      return document.title.toLowerCase().contains(value) ||
          document.description.toLowerCase().contains(value) ||
          document.category.toLowerCase().contains(value);
    }).toList();
  }
}
