import '../entities/document.dart';
import '../repositories/document_repository.dart';

class AddDocument {
  final DocumentRepository repository;

  AddDocument(this.repository);

  void call(Document document) {
    repository.addDocument(document);
  }
}
