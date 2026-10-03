import '../entities/document.dart';

abstract class DocumentRepository {
  List<Document> getDocuments();

  void addDocument(Document document);

  void updateDocument(Document document);

  void deleteDocument(int id);

  List<Document> searchDocuments(String keyword);
}
