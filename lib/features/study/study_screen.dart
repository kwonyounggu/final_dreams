import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';

class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});

  // Helper function to load the asset
  Future<String> _loadMarkdown() async {
    // Note: The path must exactly match your pubspec.yaml listing
    return await rootBundle.loadString('studies/buddhism/intro.md');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: _loadMarkdown(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error loading notes: ${snapshot.error}"),
            );
          }

          return Markdown(
            data: snapshot.data ?? "",
            styleSheet: MarkdownStyleSheet(
              h1: const TextStyle(color: Colors.blueGrey, fontSize: 32, fontWeight: FontWeight.bold),
              p: const TextStyle(fontSize: 16, height: 1.5),
              blockquoteDecoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.blueGrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }
}