

class Project {
  final String title;
  final String description;
  final String? imageUrl;
  final List<String> tags;
  final String? githubUrl;
  final String? appStoreUrl;
  final String? playStoreUrl;

  Project({
    required this.title,
    required this.description,
    this.imageUrl,
    this.tags = const [],
    this.githubUrl,
    this.appStoreUrl,
    this.playStoreUrl,
  });
}

final List<Project> myProjects = [
  Project(
    title: 'Mindful Moments',
    description: 'A meditation timer with gentle reminders and progress tracking. Features guided sessions and nature sounds.',
    imageUrl: 'assets/apps/mindful_moments.png', // make sure you have this asset
    tags: ['Wellness', 'Meditation', 'Flutter'],
    appStoreUrl: 'https://apps.apple.com/app/id123456789',
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.yourapp.mindful',
    githubUrl: 'https://github.com/yourname/mindful_moments',
  ),
  Project(
    title: 'Saxophone Tuner',
    description: 'Precision tuner specifically calibrated for saxophones. Includes pitch detection and transposition guides.',
    imageUrl: 'assets/apps/sax_tuner.png',
    tags: ['Music', 'Utility', 'Flutter'],
    appStoreUrl: 'https://apps.apple.com/app/id123456790',
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.yourapp.saxtuner',
    githubUrl: 'https://github.com/yourname/sax_tuner',
  ),
  Project(
    title: 'Quantum Notes',
    description: 'Interactive study companion for quantum mechanics. Includes wavefunction visualizations and equation references.',
    imageUrl: 'assets/apps/quantum_notes.png',
    tags: ['Education', 'Physics', 'Flutter'],
    appStoreUrl: 'https://apps.apple.com/app/id123456791',
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.yourapp.quantumnotes',
    githubUrl: 'https://github.com/yourname/quantum_notes',
  ),
  Project(
    title: 'Vision Science Flashcards',
    description: 'Spaced-repetition flashcards for vision science terminology and concepts. Great for students and enthusiasts.',
    imageUrl: 'assets/apps/vision_flashcards.png',
    tags: ['Education', 'Science', 'Flutter'],
    appStoreUrl: 'https://apps.apple.com/app/id123456792',
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.yourapp.visionflash',
    githubUrl: 'https://github.com/yourname/vision_flashcards',
  ),
  Project(
    title: 'Buddhist Study Companion',
    description: 'A collection of suttas, mindfulness exercises, and a community forum for Buddhist study groups.',
    imageUrl: 'assets/apps/buddhist_study.png',
    tags: ['Spirituality', 'Study', 'Flutter'],
    appStoreUrl: 'https://apps.apple.com/app/id123456793',
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.yourapp.buddhiststudy',
    githubUrl: 'https://github.com/yourname/buddhist_study',
  ),
];