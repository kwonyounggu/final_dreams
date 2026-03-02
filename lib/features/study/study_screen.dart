// study_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:final_dreams/features/study/models/study_topic.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class StudyScreen extends StatelessWidget {
  final String? topic;
  final String? fileName;

  const StudyScreen({super.key, this.topic, this.fileName});

  Future<String> _loadMarkdown() async 
  {
    // Uses the path format: assets/studies/topic/file.md
    final path = 'assets/studies/${topic ?? 'buddhism'}/${fileName ?? 'intro'}.md';
    try {
      return await rootBundle.loadString(path);
    } catch (e) {
      return "# 404\nFile not found: $path";
    }
  }

  @override
  Widget build(BuildContext context) {
    // 4. When clicking 'Study' directly, display all StudyNotes (All)
    logger.d('inside of StudyScreen, topic = $topic fileName = $fileName');
    if (topic == null) return _buildTopicOverview(context);

    // 3 & 5. When a note is clicked, display the reader
    return Scaffold(
      body: Row(
        children: [
          _buildSidebar(context),
          const VerticalDivider(width: 1),
          Expanded(child: _buildMarkdownBody()),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    // Find the current topic metadata
    final currentTopicData = myInterests.firstWhere(
      (t) => t.id == topic, 
      orElse: () => myInterests.first
    );

    return Container(
      width: 280,
      color: Colors.blueGrey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(currentTopicData.icon, size: 20, color: Colors.blueGrey),
                const SizedBox(width: 10),
                Text(
                  currentTopicData.title.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              children: [
                // Always provide an 'Introduction' or 'Intro' link
                ListTile(
                  title: const Text("Introduction", style: TextStyle(fontSize: 14)),
                  leading: const Icon(Icons.info_outline, size: 18),
                  onTap: () => context.go('/study/${topic}:intro'),
                  selected: fileName == 'intro',
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                  child: Text("NOTES", style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)),
                ),
                // Display the StudyNotes list
                ...currentTopicData.notes.map((note) => ListTile(
                  title: Text(note.title, style: const TextStyle(fontSize: 14)),
                  selected: fileName == note.fileName,
                  onTap: () => context.go('/study/${topic}:${note.fileName}'),
                )),
              ],
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.grid_view, size: 18),
            title: const Text("Back to Library", style: TextStyle(fontSize: 13)),
            onTap: () => context.go('/study'),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkdownBody() {
    return FutureBuilder<String>(
      future: _loadMarkdown(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No content available."));
        }

        return Markdown(
          data: snapshot.data!,
          selectable: true,
          padding: const EdgeInsets.all(40),
          styleSheet: MarkdownStyleSheet(
            h1: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1.5),
            h2: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade800),
            p: const TextStyle(fontSize: 16, height: 1.7),
            code: TextStyle(backgroundColor: Colors.grey.shade200, fontFamily: 'monospace'),
          ),
        );
      },
    );
  }

  Widget _buildTopicOverview(BuildContext context) {
    // Displays all StudyTopics with ALL StudyNotes visible
    return Scaffold(
      appBar: AppBar(title: const Text("Study Library")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Wrap(
          spacing: 24,
          runSpacing: 24,
          children: myInterests.map((interest) => _buildLibraryCard(context, interest)).toList(),
        ),
      ),
    );
  }

  Widget _buildLibraryCard(BuildContext context, StudyTopic topicData) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(topicData.icon, color: Colors.blueGrey),
              const SizedBox(width: 12),
              Text(topicData.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          const Divider(height: 24),
          // Display ALL notes for this topic in the library view
          ...topicData.notes.map((note) => ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            title: Text(note.title, style: const TextStyle(fontSize: 14)),
            trailing: const Icon(Icons.arrow_right, size: 16),
            onTap: () => context.go('/study/${topicData.id}:${note.fileName}'),
          )),
        ],
      ),
    );
  }
}