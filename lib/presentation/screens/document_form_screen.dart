import 'package:flutter/material.dart';

import '../../domain/entities/document.dart';

class DocumentFormScreen extends StatefulWidget {
  final Document? document;

  const DocumentFormScreen({super.key, this.document});

  @override
  State<DocumentFormScreen> createState() => _DocumentFormScreenState();
}

class _DocumentFormScreenState extends State<DocumentFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;
  late TextEditingController filePathController;

  bool get isEditing => widget.document != null;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.document?.title ?? '');

    descriptionController = TextEditingController(
      text: widget.document?.description ?? '',
    );

    categoryController = TextEditingController(
      text: widget.document?.category ?? '',
    );

    filePathController = TextEditingController(
      text: widget.document?.filePath ?? '',
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    filePathController.dispose();
    super.dispose();
  }

  void saveDocument() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final document = Document(
      id: widget.document?.id ?? DateTime.now().millisecondsSinceEpoch,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      category: categoryController.text.trim(),
      filePath: filePathController.text.trim(),
      createdAt: widget.document?.createdAt ?? DateTime.now(),
    );

    Navigator.pop(context, document);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Sửa tài liệu' : 'Thêm tài liệu')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Tên tài liệu',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập tên tài liệu';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Mô tả',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập mô tả';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: 'Danh mục',
                hintText: 'Ví dụ: Bài giảng, Bài tập, Tham khảo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập danh mục';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: filePathController,
              decoration: const InputDecoration(
                labelText: 'Đường dẫn tài liệu',
                hintText: 'Ví dụ: bai_giang_flutter.pdf',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_file),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: saveDocument,
                icon: const Icon(Icons.save),
                label: Text(isEditing ? 'LƯU THAY ĐỔI' : 'THÊM TÀI LIỆU'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
