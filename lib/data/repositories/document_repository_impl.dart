import '../../domain/entities/document.dart';
import '../../domain/repositories/document_repository.dart';
import '../datasources/document_local_datasource.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentLocalDataSource dataSource;

  DocumentRepositoryImpl(this.dataSource);

  @override
  List<Document> getDocuments() {
    return dataSource.getDocuments();
  }

  @override
  void addDocument(Document document) {
    dataSource.addDocument(document);
  }

  @override
  void updateDocument(Document document) {
    dataSource.updateDocument(document);
  }

  @override
  void deleteDocument(int id) {
    dataSource.deleteDocument(id);
  }

  @override
  List<Document> searchDocuments(String keyword) {
    return dataSource.searchDocuments(keyword);
  }
}
