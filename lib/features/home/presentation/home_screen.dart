import 'package:final_dreams/features/shared/widgets/section_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            // 1. Personal intro with photo and description
            IntroRow(
              name: 'YounG',
              photoUrl: 'assets/photo.jpg', // replace with your image
              description:
                  'Software engineer, saxophonist, and forever curious about quantum reality, vision, and the mind. This site is my digital garden—a place where all my passions meet.',
            ),

            // 2. Quick navigation cards (Explore my world)
            CategoryCardGrid(),

            // 3. Life Study (your existing grid)
            SectionLayout(
              title: 'Life Study',
              backgroundColor: Color(0xFFF8F9FA),
              child: StudyGrid(),
            ),

            // 4. Featured Music
            SectionLayout(
              title: 'Latest from Saxophone',
              child: MusicFeatured(),
            ),

            // 5. Contact & Footer
            ContactSection(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class IntroRow extends StatelessWidget {
  final String name;
  final String photoUrl;
  final String description;

  const IntroRow({
    super.key,
    required this.name,
    required this.photoUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Stack vertically on mobile
            return Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(photoUrl), // or NetworkImage
                ),
                const SizedBox(height: 24),
                _buildTextColumn(),
              ],
            );
          } else {
            // Side by side on desktop/tablet
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 90,
                  backgroundImage: AssetImage(photoUrl),
                ),
                const SizedBox(width: 40),
                Expanded(child: _buildTextColumn()),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildTextColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, I’m $name.',
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: const TextStyle(
            fontSize: 18,
            height: 1.5,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}


class CategoryCardGrid extends StatelessWidget {
  const CategoryCardGrid({super.key});

  final List<CategoryItem> categories = const [
    CategoryItem('About', Icons.person_outline, '/about'),
    CategoryItem('Music', Icons.music_note, '/music'),
    CategoryItem('Study', Icons.school, '/study'),
    CategoryItem('Projects', Icons.build, '/projects'),
    CategoryItem('Apps', Icons.phone_android, '/apps'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explore my world',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount(context),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () => context.go(cat.route),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(cat.icon, size: 40, color: Theme.of(context).primaryColor),
                        const SizedBox(height: 12),
                        Text(
                          cat.label,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  int _crossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 400) return 2;
    if (width < 800) return 3;
    return 5; // all five in one row on very wide screens
  }
}

class CategoryItem {
  final String label;
  final IconData icon;
  final String route;
  const CategoryItem(this.label, this.icon, this.route);
}


class MusicFeatured extends StatelessWidget {
  const MusicFeatured({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Icon(
                Icons.music_note,
                size: 180,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '🎷 Latest Recording',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Listen to my recent saxophone improvisation.',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => context.go('/music'),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Listen Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueGrey.shade800,
                  ),
                ),
              ],
            ),
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
        //Navigator.push(context, MaterialPageRoute(builder: (context) => const ProjectsPage()));
        break;
      case "Buddhism":
        //Navigator.push(context, MaterialPageRoute(builder: (context) => const BuddhismHomePage()));
        context.go('/study/buddhism'); 
        break;
      case "Quantum Mechanics":
        //Navigator.push(context, MaterialPageRoute(builder: (context) => const PhysicsListPage()));
        break;
      case "Vision Science":
        // UPDATED: Now navigates to your interactive lab
        //Navigator.push(context, 
        //  MaterialPageRoute(builder: (context) => const VisionSciencePage()));
        break;
    
      default:
        //debugPrint("No route defined for $title");
        context.go('/study'); // fallback to study list
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