import '../../domain/entities/document.dart';
import '../../domain/usecases/add_document.dart';
import '../../domain/usecases/delete_document.dart';
import '../../domain/usecases/get_documents.dart';
import '../../domain/usecases/search_documents.dart';
import '../../domain/usecases/update_document.dart';

class DocumentController {
  final GetDocuments getDocumentsUseCase;
  final AddDocument addDocumentUseCase;
  final UpdateDocument updateDocumentUseCase;
  final DeleteDocument deleteDocumentUseCase;
  final SearchDocuments searchDocumentsUseCase;

  DocumentController({
    required this.getDocumentsUseCase,
    required this.addDocumentUseCase,
    required this.updateDocumentUseCase,
    required this.deleteDocumentUseCase,
    required this.searchDocumentsUseCase,
  });

  List<Document> getAllDocuments() {
    return getDocumentsUseCase();
  }

  void addDocument(Document document) {
    addDocumentUseCase(document);
  }

  void updateDocument(Document document) {
    updateDocumentUseCase(document);
  }

  void deleteDocument(int id) {
    deleteDocumentUseCase(id);
  }

  List<Document> searchDocuments(String keyword) {
    return searchDocumentsUseCase(keyword);
  }
}
