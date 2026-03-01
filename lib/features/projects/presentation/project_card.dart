import 'package:final_dreams/features/projects/models/project_structure.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // add url_launcher to pubspec


class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (project.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  project.imageUrl!,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              project.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                project.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: project.tags.map((tag) {
                return Chip(
                  label: Text(tag),
                  backgroundColor: Colors.grey.shade200,
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (project.githubUrl != null)
                  IconButton(
                    icon: const Icon(Icons.code),
                    onPressed: () => _launchUrl(project.githubUrl!),
                    tooltip: 'GitHub',
                  ),
                if (project.appStoreUrl != null)
                  IconButton(
                    icon: const Icon(Icons.apple),
                    onPressed: () => _launchUrl(project.appStoreUrl!),
                    tooltip: 'App Store',
                  ),
                if (project.playStoreUrl != null)
                  IconButton(
                    icon: const Icon(Icons.android),
                    onPressed: () => _launchUrl(project.playStoreUrl!),
                    tooltip: 'Google Play',
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}