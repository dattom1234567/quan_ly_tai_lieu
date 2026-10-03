import 'package:flutter/material.dart';

import '../../domain/entities/document.dart';
import '../controllers/document_controller.dart';
import '../widgets/document_card.dart';
import 'document_form_screen.dart';

class HomeScreen extends StatefulWidget {
  final DocumentController controller;

  const HomeScreen({super.key, required this.controller});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Document> documents;

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    documents = widget.controller.getAllDocuments();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchDocuments(String keyword) {
    setState(() {
      documents = widget.controller.searchDocuments(keyword);
    });
  }

  Future<void> addDocument() async {
    final document = await Navigator.push<Document>(
      context,
      MaterialPageRoute(builder: (_) => const DocumentFormScreen()),
    );

    if (document != null) {
      widget.controller.addDocument(document);

      setState(() {
        documents = widget.controller.getAllDocuments();
      });
    }
  }

  Future<void> editDocument(Document document) async {
    final updatedDocument = await Navigator.push<Document>(
      context,
      MaterialPageRoute(builder: (_) => DocumentFormScreen(document: document)),
    );

    if (updatedDocument != null) {
      widget.controller.updateDocument(updatedDocument);

      setState(() {
        documents = widget.controller.getAllDocuments();
      });
    }
  }

  void deleteDocument(Document document) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xóa tài liệu'),
          content: Text('Bạn có chắc muốn xóa "${document.title}" không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.controller.deleteDocument(document.id);

                Navigator.pop(context);

                setState(() {
                  documents = widget.controller.getAllDocuments();
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã xóa tài liệu')),
                );
              },
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý tài liệu học tập'),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: addDocument,
        icon: const Icon(Icons.add),
        label: const Text('Thêm tài liệu'),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: searchDocuments,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm tài liệu...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();
                          searchDocuments('');
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Expanded(
            child: documents.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_open, size: 80, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Chưa có tài liệu',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 90),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final document = documents[index];

                      return DocumentCard(
                        document: document,
                        onEdit: () => editDocument(document),
                        onDelete: () => deleteDocument(document),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
