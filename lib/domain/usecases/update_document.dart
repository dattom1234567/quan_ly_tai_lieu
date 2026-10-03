import '../entities/document.dart';
import '../repositories/document_repository.dart';

class UpdateDocument {
  final DocumentRepository repository;

  UpdateDocument(this.repository);

  void call(Document document) {
    repository.updateDocument(document);
  }
}
