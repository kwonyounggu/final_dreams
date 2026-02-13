import 'package:final_dreams/features/projects/presentation/projects_page.dart';
import 'package:final_dreams/features/study/vision_science/presentation/vision_science_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Import your shared components
import 'package:final_dreams/features/shared/widgets/section_layout.dart';

// Import your feature models and pages
import 'package:final_dreams/features/study/models/study_topic.dart';
import 'package:final_dreams/features/study/buddhism/presentation/buddhism_home.dart';
import 'package:final_dreams/features/study/physics/presentation/physics_list_page.dart'; // Assume you created this based on the Buddhism pattern

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sticky AppBar for easy navigation
      appBar: AppBar(
        title: const Text("Your Name | Polymath Portfolio"),
        actions: [
          TextButton(onPressed: () {}, child: const Text("About")),
          TextButton(onPressed: () {}, child: const Text("Music")),
          TextButton(onPressed: () {}, child: const Text("Projects")),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHero(context),
            
            // About / History Section
            const SectionLayout(
              title: "History & Vision",
              child: Text(
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
            
            // ADD THIS:
            const ContactSection(),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 24),
          const Text(
            "The Digital Garden",
            style: TextStyle(fontSize: 42, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            "Code. Physics. Philosophy. Music.",
            style: TextStyle(fontSize: 20, color: Colors.blueGrey.shade100),
          ),
        ],
      ),
    );
  }
}

class StudyGrid extends StatelessWidget {
  const StudyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine grid columns based on screen width
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = width > 900 ? 3 : 1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        // CHANGED: 1.3 provides more vertical height than 1.5
        childAspectRatio: width > 1200 ? 1.4 : 1.2, 
      ),
      itemCount: myInterests.length,
      itemBuilder: (context, index) {
        final topic = myInterests[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          child: InkWell(
            onTap: () => _handleNavigation(context, topic.title),
            child: Padding(
              // CHANGED: Reduced from 20 to 16 to save 8px of vertical space
              padding: const EdgeInsets.all(16.0), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CHANGED: Icon reduced from 40 to 32 to save 8px
                  Icon(topic.icon, size: 32, color: Theme.of(context).primaryColor),
                  const SizedBox(height: 12),
                  Text(
                    topic.title, 
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // ADDED: Flexible prevents the 'yellow stripe' overflow error
                  Flexible(
                    child: Text(
                      topic.description, 
                      textAlign: TextAlign.center, 
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleNavigation(BuildContext context, String title) {
    switch (title) {
      case "Apps":
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProjectsPage()));
        break;
      case "Buddhism":
        Navigator.push(context, MaterialPageRoute(builder: (context) => const BuddhismHomePage()));
        break;
      case "Quantum Mechanics":
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PhysicsListPage()));
        break;
      case "Vision Science":
        // UPDATED: Now navigates to your interactive lab
        Navigator.push(context, 
          MaterialPageRoute(builder: (context) => const VisionSciencePage()));
        break;
    
      default:
        debugPrint("No route defined for $title");
    }
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
                onPressed: () => _launchUrl("mailto:your.email@example.com"),
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