import 'package:flutter/material.dart';
import '../models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusBadge(project.status),
                const Icon(Icons.developer_mode, color: Colors.blueGrey),
              ],
            ),
            const SizedBox(height: 16),
            Text(project.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(project.description, style: TextStyle(color: Colors.grey.shade600)),
            const Spacer(),
            Wrap(
              spacing: 8,
              children: project.techStack.map((tech) => Chip(
                label: Text(tech, style: const TextStyle(fontSize: 10)),
                visualDensity: VisualDensity.compact,
              )).toList(),
            ),
            const Divider(),
            Row(
              children: [
                if (project.githubUrl != null)
                  IconButton(onPressed: () {}, icon: const Icon(Icons.code)),
                if (project.appStoreUrl != null)
                  IconButton(onPressed: () {}, icon: const Icon(Icons.apple)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(ProjectStatus status) {
    Color color = status == ProjectStatus.live ? Colors.green : Colors.orange;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Text(status.name.toUpperCase(), style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}