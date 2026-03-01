class Study {
  final String id;
  final String title;
  final String category;
  final String excerpt;
  final String markdownPath;
  final DateTime date;

  Study({
    required this.id,
    required this.title,
    required this.category,
    required this.excerpt,
    required this.markdownPath,
    required this.date,
  });

  factory Study.fromJson(Map<String, dynamic> json) {
    return Study(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      excerpt: json['excerpt'],
      markdownPath: json['markdownPath'],
      date: DateTime.parse(json['date']),
    );
  }
}