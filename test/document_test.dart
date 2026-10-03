import 'package:flutter_test/flutter_test.dart';

import 'package:quan_ly_tai_lieu/data/datasources/document_local_datasource.dart';
import 'package:quan_ly_tai_lieu/data/repositories/document_repository_impl.dart';
import 'package:quan_ly_tai_lieu/domain/entities/document.dart';
import 'package:quan_ly_tai_lieu/domain/usecases/add_document.dart';
import 'package:quan_ly_tai_lieu/domain/usecases/delete_document.dart';
import 'package:quan_ly_tai_lieu/domain/usecases/get_documents.dart';
import 'package:quan_ly_tai_lieu/domain/usecases/search_documents.dart';
import 'package:quan_ly_tai_lieu/domain/usecases/update_document.dart';

void main() {
  late DocumentLocalDataSource dataSource;
  late DocumentRepositoryImpl repository;

  setUp(() {
    dataSource = DocumentLocalDataSource();
    repository = DocumentRepositoryImpl(dataSource);
  });

  Document createDocument({
    int id = 1,
    String title = 'Flutter',
    String description = 'Tai lieu Flutter co ban',
    String category = 'Bai giang',
    String filePath = 'flutter.pdf',
  }) {
    return Document(
      id: id,
      title: title,
      description: description,
      category: category,
      filePath: filePath,
      createdAt: DateTime(2026, 1, 1),
    );
  }

  test('Them tai lieu thanh cong', () {
    final addDocument = AddDocument(repository);
    final getDocuments = GetDocuments(repository);

    addDocument(
      createDocument(),
    );

    final documents = getDocuments();

    expect(documents.length, 1);
    expect(documents.first.title, 'Flutter');
  });

  test('Sua tai lieu thanh cong', () {
    final addDocument = AddDocument(repository);
    final updateDocument = UpdateDocument(repository);
    final getDocuments = GetDocuments(repository);

    addDocument(
      createDocument(),
    );

    updateDocument(
      createDocument(
        title: 'Flutter nang cao',
        description: 'Tai lieu Flutter nang cao',
      ),
    );

    final documents = getDocuments();

    expect(documents.length, 1);
    expect(documents.first.title, 'Flutter nang cao');
    expect(
      documents.first.description,
      'Tai lieu Flutter nang cao',
    );
  });

  test('Xoa tai lieu thanh cong', () {
    final addDocument = AddDocument(repository);
    final deleteDocument = DeleteDocument(repository);
    final getDocuments = GetDocuments(repository);

    addDocument(
      createDocument(),
    );

    expect(getDocuments().length, 1);

    deleteDocument(1);

    expect(getDocuments(), isEmpty);
  });

  test('Tim kiem tai lieu theo ten', () {
    final addDocument = AddDocument(repository);
    final searchDocuments = SearchDocuments(repository);

    addDocument(
      createDocument(
        id: 1,
        title: 'Flutter Lap trinh',
        description: 'Hoc Flutter',
        category: 'Bai giang',
      ),
    );

    addDocument(
      createDocument(
        id: 2,
        title: 'Java co ban',
        description: 'Hoc Java',
        category: 'Bai tap',
      ),
    );

    final result = searchDocuments('flutter');

    expect(result.length, 1);
    expect(result.first.title, 'Flutter Lap trinh');
  });

  test('Tim kiem tai lieu theo danh muc', () {
    final addDocument = AddDocument(repository);
    final searchDocuments = SearchDocuments(repository);

    addDocument(
      createDocument(
        id: 1,
        title: 'Tai lieu Flutter',
        category: 'Bai giang',
      ),
    );

    addDocument(
      createDocument(
        id: 2,
        title: 'Tai lieu Java',
        category: 'Tham khao',
      ),
    );

    final result = searchDocuments('bai giang');

    expect(result.length, 1);
    expect(result.first.category, 'Bai giang');
  });

  test('Tim kiem rong tra ve tat ca tai lieu', () {
    final addDocument = AddDocument(repository);
    final searchDocuments = SearchDocuments(repository);

    addDocument(
      createDocument(
        id: 1,
        title: 'Flutter',
      ),
    );

    addDocument(
      createDocument(
        id: 2,
        title: 'Java',
      ),
    );

    final result = searchDocuments('');

    expect(result.length, 2);
  });
}