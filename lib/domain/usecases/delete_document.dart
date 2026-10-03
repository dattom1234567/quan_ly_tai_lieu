import '../repositories/document_repository.dart';

class DeleteDocument {
  final DocumentRepository repository;

  DeleteDocument(this.repository);

  void call(int id) {
    repository.deleteDocument(id);
  }
}
