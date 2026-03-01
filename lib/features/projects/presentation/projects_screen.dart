import 'package:final_dreams/features/projects/models/project_structure.dart';
import 'package:flutter/material.dart';

import 'project_card.dart';

class ProjectsScreen extends StatelessWidget {
  ProjectsScreen({super.key});

  final List<Project> projects = [
    Project(
      title: 'HVAC Automation',
      description: 'Arduino-based temperature controller for energy efficiency.',
      imageUrl: 'assets/projects/hvac.jpg', // placeholder
      tags: ['IoT', 'Arduino', 'Flutter'],
      githubUrl: 'https://github.com/yourname/hvac',
    ),
    Project(
      title: 'DIY Telescope',
      description: 'A 10" dobsonian telescope with motorized tracking.',
      imageUrl: 'assets/projects/telescope.jpg',
      tags: ['DIY', 'Astronomy', '3D Printing'],
      githubUrl: 'https://github.com/yourname/telescope',
    ),
    Project(
      title: 'AI Vision Experiment',
      description: 'Neural style transfer using TensorFlow Lite.',
      imageUrl: 'assets/projects/ai_vision.jpg',
      tags: ['AI', 'Flutter', 'TensorFlow'],
      githubUrl: 'https://github.com/yourname/ai-vision',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return ProjectCard(project: projects[index]);
          },
        ),
      ),
    );
  }
}