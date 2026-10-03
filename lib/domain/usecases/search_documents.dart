import '../entities/document.dart';
import '../repositories/document_repository.dart';

class SearchDocuments {
  final DocumentRepository repository;

  SearchDocuments(this.repository);

  List<Document> call(String keyword) {
    return repository.searchDocuments(keyword);
  }
}
