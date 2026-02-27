import 'package:final_dreams/features/apps/app_structure.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class AppCard extends StatelessWidget {
  final AppModel app;
  const AppCard({super.key, required this.app});

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
                Icon(app.icon, size: 28, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    app.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(app.description, style: const TextStyle(fontSize: 14)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (app.githubUrl != null)
                  IconButton(
                    icon: const Icon(Icons.code),
                    onPressed: () => _launchUrl(app.githubUrl!),
                  ),
                if (app.appStoreUrl != null)
                  IconButton(
                    icon: const Icon(Icons.apple),
                    onPressed: () => _launchUrl(app.appStoreUrl!),
                  ),
                if (app.playStoreUrl != null)
                  IconButton(
                    icon: const Icon(Icons.android),
                    onPressed: () => _launchUrl(app.playStoreUrl!),
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