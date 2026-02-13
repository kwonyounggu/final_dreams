import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../models/buddhism_note.dart';

class NoteDetailPage extends StatelessWidget {
  final BuddhismNote note;

  const NoteDetailPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(note.title)),
      body: Markdown(
        data: note.content,
        styleSheet: MarkdownStyleSheet(
          h1: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blueGrey),
          p: const TextStyle(fontSize: 18, height: 1.6),
          blockquote: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          blockquoteDecoration: BoxDecoration(
            border: Border(left: BorderSide(color: Colors.blueGrey.shade200, width: 4)),
          ),
        ),
      ),
    );
  }
}