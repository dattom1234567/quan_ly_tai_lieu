import 'package:flutter/material.dart';

import 'data/datasources/document_local_datasource.dart';
import 'data/repositories/document_repository_impl.dart';
import 'domain/usecases/add_document.dart';
import 'domain/usecases/delete_document.dart';
import 'domain/usecases/get_documents.dart';
import 'domain/usecases/search_documents.dart';
import 'domain/usecases/update_document.dart';
import 'presentation/controllers/document_controller.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  final dataSource = DocumentLocalDataSource();

  final repository = DocumentRepositoryImpl(dataSource);

  final controller = DocumentController(
    getDocumentsUseCase: GetDocuments(repository),
    addDocumentUseCase: AddDocument(repository),
    updateDocumentUseCase: UpdateDocument(repository),
    deleteDocumentUseCase: DeleteDocument(repository),
    searchDocumentsUseCase: SearchDocuments(repository),
  );

  runApp(DocumentManagementApp(controller: controller));
}

class DocumentManagementApp extends StatelessWidget {
  final DocumentController controller;

  const DocumentManagementApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quản lý tài liệu học tập',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      home: HomeScreen(controller: controller),
    );
  }
}
