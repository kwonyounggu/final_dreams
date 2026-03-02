import 'package:final_dreams/features/projects/presentation/project_card.dart';
import 'package:final_dreams/features/projects/models/project_structure.dart';
import 'package:final_dreams/features/shared/widgets/section_layout.dart';
import 'package:final_dreams/features/study/models/study_topic.dart';

import 'package:final_dreams/features/travel/model/travel_structure.dart';
import 'package:final_dreams/features/travel/presentation/travel_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeScreen extends ConsumerStatefulWidget 
{
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: SingleChildScrollView
      (
        child: Column
        (
          children: 
          [
            _buildHero(context),
            
            // About / History Section
            const SectionLayout
            (
              title: "History & Vision",
              child: Text
              (
                "M.CompSci graduate exploring the intersection of Vision Science, "
                "Quantum Mechanics, and Buddhist philosophy. Building tools for the future.",
                style: TextStyle(fontSize: 18),
              ),
            ),

            // Study Grid Section
            const SectionLayout(
              title: "Life Study",
              backgroundColor: Color(0xFFF8F9FA),
              child: StudyGrid(),
            ),

            // Music Section
            SectionLayout(
              title: "Music & Saxophone",
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text("Recording Studio Coming Soon", 
                    style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            // Projects Section
            SectionLayout(
              title: "Projects & Experiments",
              backgroundColor: Colors.white,
              child: ProjectsGrid(),
            ),

            SectionLayout(
              title: "Travel Stories",
              backgroundColor: const Color(0xFFF8F9FA),
              child: const TravelGrid(),
            ),
            
            // ADD THIS:
            const ContactSection(),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) 
  {
    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration
      (
        gradient: LinearGradient
        (
          colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column
      (
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
        [
          const CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 24),
          const Text(
            "The Digital Garden now under construction",
            style: TextStyle(fontSize: 42, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Padding
          (
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text // ← no 'const'
            (
              "I build software, play Korean Gayo saxophone, and explore the mysteries of quantum mechanics, visual perception, and Buddhist philosophy. This site is my digital garden—a place where all my passions meet.",
              style: TextStyle(fontSize: 20, color: Colors.blueGrey.shade100),
            ),
          )
        ],
      ),
    );
  }
}

// home_screen.dart

// Inside home_screen.dart
class StudyGrid extends StatelessWidget {
  const StudyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = width > 900 ? 3 : 1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: width > 1200 ? 1.0 : 0.8, 
      ),
      itemCount: myInterests.length,
      itemBuilder: (context, index) {
        final topic = myInterests[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(topic.icon, size: 32, color: Theme.of(context).primaryColor),
                const SizedBox(height: 8),
                Text(topic.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const Divider(),
                // Show ONLY 3 notes on Home Screen
                ...topic.notes.take(3).map((note) => ListTile(
                  dense: true,
                  title: Text(note.title, style: const TextStyle(fontSize: 13)),
                  trailing: const Icon(Icons.chevron_right, size: 14),
                  onTap: () => context.go('/study/${topic.id}:${note.fileName}'),
                )),
                const Spacer(),
                TextButton(
                  onPressed: () => context.go('/study'),
                  child: const Text("View Library"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProjectsGrid extends StatelessWidget {
  const ProjectsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        int crossAxisCount = width > 900 ? 3 : (width > 600 ? 2 : 1);
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.0, // adjust as needed
          ),
          itemCount: myProjects.length,
          itemBuilder: (context, index) => ProjectCard(project: myProjects[index]),
        );
      },
    );
  }
}
class TravelGrid extends StatelessWidget {
  const TravelGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        int crossAxisCount = width > 900 ? 3 : (width > 600 ? 2 : 1);
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.75, // taller cards for travel
          ),
          itemCount: myTravels.length,
          itemBuilder: (context, index) => TravelCard(travel: myTravels[index]),
        );
      },
    );
  }
}
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50, // Subtle background shift
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        children: [
          const Text(
            "Get in Touch",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            "Whether it's about a vision science collaboration, jazz recordings, "
            "or quantum physics—I'd love to hear from you.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _contactButton(
                icon: Icons.email_outlined,
                label: "Email Me",
                onPressed: () => _launchUrl("mailto:kwon.younggu@google.com"),
              ),
              _contactButton(
                icon: Icons.link,
                label: "LinkedIn",
                onPressed: () => _launchUrl("https://linkedin.com/in/yourprofile"),
              ),
              _contactButton(
                icon: Icons.code,
                label: "GitHub",
                onPressed: () => _launchUrl("https://github.com/yourusername"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueGrey.shade800,
        elevation: 0,
        side: BorderSide(color: Colors.blueGrey.shade100),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $url');
  }
}
}

class Footer extends StatelessWidget {
  const Footer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: const Text("© 2026 | Built with Flutter & Intent"),
    );
  }
}