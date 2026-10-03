import '../entities/document.dart';
import '../repositories/document_repository.dart';

class GetDocuments {
  final DocumentRepository repository;

  GetDocuments(this.repository);

  List<Document> call() {
    return repository.getDocuments();
  }
}
