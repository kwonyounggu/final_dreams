import 'package:final_dreams/features/study/models/study_repository.dart';
import 'package:final_dreams/features/study/models/study_structure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';


class StudyDetailScreen extends StatelessWidget {
  final Study study;

  const StudyDetailScreen({super.key, required this.study});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(study.title),
      ),
      body: FutureBuilder<String>(
        future: StudyRepository.loadMarkdown(study.markdownPath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading content: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Markdown(
                data: snapshot.data!,
                selectable: true,
                styleSheet: MarkdownStyleSheet(
                  h1: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  p: const TextStyle(fontSize: 16, height: 1.6),
                ),
              ),
            );
          } else {
            return const Center(child: Text('No content'));
          }
        },
      ),
    );
  }
}