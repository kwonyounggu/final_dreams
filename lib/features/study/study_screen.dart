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

  Future<String> _loadMarkdown() async {
    final path = 'assets/studies/${topic ?? 'buddhism'}/${fileName ?? 'intro'}.md';
    try {
      return await rootBundle.loadString(path);
    } catch (e) {
      return "# 404\nFile not found: $path";
    }
  }

  @override
  Widget build(BuildContext context) {
    logger.d('inside of StudyScreen, topic = $topic fileName = $fileName');
    
    // If no topic selected, show library overview
    if (topic == null) return _buildTopicOverview(context);

    // Check if we're on mobile (width < 600)
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return isMobile 
        ? _buildMobileLayout(context)
        : _buildDesktopLayout(context);
  }

  // Desktop: Side-by-side sidebar + content
  Widget _buildDesktopLayout(BuildContext context) {
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

  // Mobile: Stacked layout with proper back navigation
  Widget _buildMobileLayout(BuildContext context) {
    final bool isIntro = fileName == 'intro';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_getCurrentTopicTitle()),
        // Smart back button logic
        leading: !isIntro
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  // Always go to intro of current topic
                  context.go('/study/${topic}:intro');
                },
              )
            : Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _showTopicDrawer(context),
                ),
              ),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () => context.go('/study'),
            tooltip: 'Library',
          ),
        ],
      ),
      body: _buildMarkdownBody(),
    );
  }

  String _getCurrentTopicTitle() {
    final topicData = myInterests.firstWhere(
      (t) => t.id == topic,
      orElse: () => myInterests.first,
    );
    return topicData.title;
  }

  void _showTopicDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: _buildSidebarList(context, scrollController),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Desktop sidebar
  Widget _buildSidebar(BuildContext context) {
    final currentTopicData = myInterests.firstWhere(
      (t) => t.id == topic,
      orElse: () => myInterests.first,
    );
    
    final currentTopicId = currentTopicData.id;

    return Container(
      width: 280,
      color: Colors.blueGrey.shade50,
      child: ListView(
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
          ListTile(
            title: const Text("Introduction", style: TextStyle(fontSize: 14)),
            leading: const Icon(Icons.info_outline, size: 18),
            onTap: () => context.go('/study/$currentTopicId:intro'),
            selected: fileName == 'intro',
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text(
              "NOTES",
              style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
          ...currentTopicData.notes.map((note) => ListTile(
            title: Text(note.title, style: const TextStyle(fontSize: 14)),
            selected: fileName == note.fileName,
            onTap: () => context.go('/study/$currentTopicId:${note.fileName}'),
          )),
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

  // Sidebar list (used by both desktop and mobile drawer)
  Widget _buildSidebarList(BuildContext context, [ScrollController? controller]) {
    final currentTopicData = myInterests.firstWhere(
      (t) => t.id == topic,
      orElse: () => myInterests.first,
    );

    final currentTopicId = currentTopicData.id;

    return ListView(
      controller: controller,
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
        ListTile(
          title: const Text("Introduction", style: TextStyle(fontSize: 14)),
          leading: const Icon(Icons.info_outline, size: 18),
          onTap: () {
            Navigator.pop(context); // close bottom sheet
            context.go('/study/$currentTopicId:intro');
          },
          selected: fileName == 'intro',
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
          child: Text(
            "NOTES",
            style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
        ...currentTopicData.notes.map((note) => ListTile(
          title: Text(note.title, style: const TextStyle(fontSize: 14)),
          selected: fileName == note.fileName,
          onTap: () {
            Navigator.pop(context); // close bottom sheet
            context.go('/study/$currentTopicId:${note.fileName}');
          },
        )),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.grid_view, size: 18),
          title: const Text("Back to Library", style: TextStyle(fontSize: 13)),
          onTap: () {
            Navigator.pop(context); // close bottom sheet
            context.go('/study');
          },
        ),
      ],
    );
  }

  // Fixed Markdown body with proper constraints
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

        final isMobile = MediaQuery.of(context).size.width < 600;
        final padding = isMobile ? 16.0 : 40.0;

        return SizedBox.expand(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: MarkdownBody(
              data: snapshot.data!,
              selectable: true,
              styleSheet: MarkdownStyleSheet(
                h1: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, height: 1.5),
                h2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade800),
                h3: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                p: const TextStyle(fontSize: 16, height: 1.6),
                blockquote: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                  fontStyle: FontStyle.italic,
                ),
                code: TextStyle(backgroundColor: Colors.grey.shade200, fontFamily: 'monospace'),
              ),
            ),
          ),
        );
      },
    );
  }

  // Library overview screen
  Widget _buildTopicOverview(BuildContext context) 
  {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Scaffold
    (
      //appBar: AppBar(
       // title: const Text("Study Library"),
      //),
      body: SingleChildScrollView
      (
        padding: EdgeInsets.all(isMobile ? 16 : 32),
        child: isMobile
            ? Column
            (
                children: myInterests.map((interest) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildLibraryCard(context, interest, isMobile),
                )).toList(),
              )
            : Wrap(
                spacing: 24,
                runSpacing: 24,
                children: myInterests.map((interest) => _buildLibraryCard(context, interest, isMobile)).toList(),
              ),
      ),
    );
  }

  Widget _buildLibraryCard(BuildContext context, StudyTopic topicData, bool isMobile) {
    return Container(
      width: isMobile ? double.infinity : 340,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Topic header
          Row(
            children: [
              Icon(topicData.icon, color: Colors.blueGrey, size: 28),
              const SizedBox(width: 12),
              Text(
                topicData.title, 
                style: const TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 20
                ),
              ),
            ],
          ),
          const Divider(height: 28),
          
          // Notes with FULL filenames
          ...topicData.notes.map((note) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              dense: false,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              title: Text(
                note.title, // This now shows "2025-02-28-Dependent-Origination"
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.arrow_right, size: 20),
              onTap: () => context.go('/study/${topicData.id}:${note.fileName}'),
            ),
          )),
          
          // Optional: Add a "View all" button if there are many notes
          if (topicData.notes.length > 5)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextButton(
                onPressed: () => context.go('/study/${topicData.id}'),
                child: const Text('View all notes →'),
              ),
            ),
        ],
      ),
    );
  }
}