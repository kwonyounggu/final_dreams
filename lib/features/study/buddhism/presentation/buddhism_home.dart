import 'package:flutter/material.dart';
import '../models/buddhism_note.dart';
import 'note_detail_page.dart';

class BuddhismHomePage extends StatelessWidget {
  const BuddhismHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buddhism & Philosophy")),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: buddhismNotes.length,
        itemBuilder: (context, index) {
          final note = buddhismNotes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${note.date} • ${note.category}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NoteDetailPage(note: note)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}