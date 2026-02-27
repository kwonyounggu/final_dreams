import 'package:final_dreams/features/projects/project_structure.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(project.icon, size: 28, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    project.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(project.description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              children: project.tags.map((tag) => Chip(
                label: Text(tag, style: const TextStyle(fontSize: 12)),
                padding: EdgeInsets.zero,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              )).toList(),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (project.githubUrl != null)
                  IconButton(
                    icon: const Icon(Icons.code),
                    onPressed: () => _launchUrl(project.githubUrl!),
                  ),
                if (project.liveUrl != null)
                  IconButton(
                    icon: const Icon(Icons.open_in_browser),
                    onPressed: () => _launchUrl(project.liveUrl!),
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
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}