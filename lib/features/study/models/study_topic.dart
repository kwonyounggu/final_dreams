import 'package:flutter/material.dart';

class StudyNote {
  final String title;
  final String fileName;

  StudyNote({required this.title, required this.fileName});
}

class StudyTopic {
  final String id; // folder name: buddhism, quantum, etc.
  final String title;
  final String description;
  final IconData icon;
  final List<StudyNote> notes;

  StudyTopic({
    required this.id, 
    required this.title, 
    required this.description, 
    required this.icon,
    required this.notes,
  });
}

final List<StudyTopic> myInterests = [
  StudyTopic(
    id: "buddhism",
    title: "Buddhism", 
    description: "Daily reflections on mindfulness and the nature of self.", 
    icon: Icons.self_improvement,
    notes: [
      StudyNote(title: "Dependent Origination", fileName: "2025-02-28-Dependent-Origination"),
      StudyNote(title: "The Eightfold Path", fileName: "2025-02-15-Eightfold-Path"),
      StudyNote(title: "Introduction to Zen", fileName: "2025-01-10-Zen-Intro"),
      StudyNote(title: "Four Noble Truths", fileName: "four-noble-truths"),
    ],
  ),
  StudyTopic(
    id: "quantum",
    title: "Quantum Mechanics", 
    description: "Exploring the Schrödinger equation and wave-particle duality.", 
    icon: Icons.science,
    notes: [
      StudyNote(title: "Wave-Particle Duality", fileName: "wave-particle"),
      StudyNote(title: "Schrödinger Equation", fileName: "schrodinger"),
    ],
  ),
];