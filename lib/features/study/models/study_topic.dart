import 'package:flutter/material.dart';

class StudyTopic {
  final String title;
  final String description;
  final IconData icon;
  final String? latexSnippet; // For your QM/Science notes

  StudyTopic({
    required this.title, 
    required this.description, 
    required this.icon,
    this.latexSnippet,
  });
}

// Data list for easy extension
final List<StudyTopic> myInterests = [
  StudyTopic(
    title: "Buddhism", 
    description: "Daily reflections on mindfulness and the nature of self.", 
    icon: Icons.self_improvement
  ),
  StudyTopic(
    title: "Quantum Mechanics", 
    description: "Exploring the Schrödinger equation and wave-particle duality.", 
    icon: Icons.science,
    latexSnippet: r"i\hbar \frac{\partial}{\partial t} \Psi(\mathbf{r},t) = \hat{H} \Psi(\mathbf{r},t)"
  ),
  StudyTopic(
    title: "Vision Science", 
    description: "Computational models of human visual perception.", 
    icon: Icons.visibility
  ),
];