import 'package:final_dreams/features/study/models/study_structure.dart';
import 'package:flutter/services.dart';


class StudyRepository {
  // This could load from a JSON index file
  static Future<List<Study>> loadStudies() async {
    // In a real app, you'd maintain a JSON index file in assets
    // For simplicity, we'll hardcode a list
    return [
      Study(
        id: 'meditation-basics',
        title: 'Meditation Basics',
        category: 'Buddhism',
        excerpt: 'An introduction to mindfulness and sitting practice.',
        markdownPath: 'assets/studies/buddhism/meditation_basics.md',
        date: DateTime(2025, 1, 15),
      ),
      Study(
        id: 'wavefunction',
        title: 'Understanding the Wavefunction',
        category: 'Quantum Mechanics',
        excerpt: 'A gentle introduction to quantum states.',
        markdownPath: 'assets/studies/quantum/wavefunction.md',
        date: DateTime(2025, 2, 10),
      ),
      // Add more...
    ];
  }

  static Future<String> loadMarkdown(String path) async {
    return await rootBundle.loadString(path);
  }
}