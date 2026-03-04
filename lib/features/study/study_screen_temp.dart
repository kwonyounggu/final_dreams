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
    // 1. Check screen width
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;

        // 4. Library Overview Mode
        if (topic == null) {
          return _buildTopicOverview(context, isMobile);
        }

        // 3 & 5. Markdown Reader Mode
        return Scaffold(
          // On mobile, we add an AppBar to hold the drawer trigger
          appBar: isMobile 
            ? AppBar(title: Text(topic!.toUpperCase())) 
            : null,
          drawer: isMobile ? Drawer(child: _buildSidebarContent(context)) : null,
          body: Row(
            children: [
              // Only show permanent sidebar on Desktop
              if (!isMobile) 
                Container(
                  width: 260,
                  color: Colors.blueGrey.shade50,
                  child: _buildSidebarContent(context),
                ),
              if (!isMobile) const VerticalDivider(width: 1),
              Expanded(child: _buildMarkdownBody()),
            ],
          ),
        );
      },
    );
  }

  // Extracted sidebar logic so it can be used in Row (Desktop) or Drawer (Mobile)
  Widget _buildSidebarContent(BuildContext context) {
    final currentTopicData = myInterests.firstWhere(
      (t) => t.id == topic, 
      orElse: () => myInterests.first
    );

    return Column(
      children: [
        _buildSidebarHeader(currentTopicData),
        const Divider(),
        Expanded(
          child: ListView(
            children: [
              ...currentTopicData.notes.map((note) => ListTile(
                title: Text(note.title, style: const TextStyle(fontSize: 14)),
                selected: fileName == note.fileName,
                onTap: () {
                  context.go('/study/${topic}:${note.fileName}');
                  if (Navigator.canPop(context)) Navigator.pop(context);
                },
              )),
            ],
          ),
        ),
        _buildSidebarFooter(context),
      ],
    );
  }

  Widget _buildTopicOverview(BuildContext context, bool isMobile) {
    return Scaffold(
      appBar: AppBar(title: const Text("Study Library")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 16 : 32),
        child: Center(
          child: Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: myInterests.map((interest) => _buildLibraryCard(context, interest, isMobile)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildLibraryCard(BuildContext context, StudyTopic topicData, bool isMobile) {
    // Card width fills screen on mobile, fixed on desktop
    double cardWidth = isMobile ? MediaQuery.of(context).size.width - 32 : 300;
    
    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(topicData.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const Divider(),
          ...topicData.notes.map((note) => ListTile(
            dense: true,
            title: Text(note.title),
            onTap: () => context.go('/study/${topicData.id}:${note.fileName}'),
          )),
        ],
      ),
    );
  }

  // Inside StudyScreen class

  Widget _buildSidebarHeader(StudyTopic data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blueGrey.shade100,
            child: Icon(data.icon, color: Colors.blueGrey.shade800, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            data.title.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 1.2,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Research Notes",
            style: TextStyle(
              fontSize: 12,
              color: Colors.blueGrey.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => context.go('/study'),
          icon: const Icon(Icons.grid_view_rounded, size: 16),
          label: const Text("Full Library"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blueGrey,
            side: BorderSide(color: Colors.blueGrey.shade100),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
  /*
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
  */
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
          padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 16 : 40),
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

  /*
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
  */
 /*
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
  }*/
}