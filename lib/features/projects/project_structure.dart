import 'package:flutter/material.dart';

class Project {
  final String title;
  final String description;
  final IconData icon;
  final String? imagePath;
  final List<String> tags;
  final String? githubUrl;
  final String? liveUrl;

  Project({
    required this.title,
    required this.description,
    required this.icon,
    this.imagePath,
    this.tags = const [],
    this.githubUrl,
    this.liveUrl,
  });
}

// Sample data
final List<Project> myProjects = [
  Project(
    title: 'HVAC Automation',
    description: 'Arduino‑based temperature controller with mobile app.',
    icon: Icons.thermostat,
    tags: ['IoT', 'Arduino', 'Flutter'],
    githubUrl: 'https://github.com/yourname/hvac',
  ),
  Project(
    title: 'DIY Telescope',
    description: '10" dobsonian with motorized tracking.',
    icon: Icons.thermostat,
    tags: ['DIY', 'Astronomy', '3D Printing'],
    githubUrl: 'https://github.com/yourname/telescope',
  ),
];