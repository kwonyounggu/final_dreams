class Travel 
{
  final String title;           // e.g., "Kyoto Autumn"
  final String location;        // e.g., "Kyoto, Japan"
  final DateTime date;          // when you visited
  final String description;     // short summary
  final String? imageUrl;       // asset path or network URL
  final String? youtubeUrl;     // link to your YouTube video
  final List<String> tags;      // e.g., ['Japan', 'Temples', 'Food']

  Travel
  (
    {
      required this.title,
      required this.location,
      required this.date,
      required this.description,
      this.imageUrl,
      this.youtubeUrl,
      this.tags = const [],
    }
  );
}


final List<Travel> myTravels = [
  Travel(
    title: 'Autumn in Kyoto',
    location: 'Kyoto, Japan',
    date: DateTime(2024, 11, 15),
    description: 'Explored ancient temples and zen gardens during peak foliage. The golden pavilion was breathtaking.',
    imageUrl: 'assets/travel/kyoto.jpg',
    youtubeUrl: 'https://youtu.be/abcdefg',
    tags: ['Japan', 'Temples', 'Nature'],
  ),
  Travel(
    title: 'Hiking the Alps',
    location: 'Swiss Alps',
    date: DateTime(2024, 7, 10),
    description: 'Took the Jungfrau railway and hiked through wildflower meadows. Unforgettable views.',
    imageUrl: 'assets/travel/alps.jpg',
    youtubeUrl: 'https://youtu.be/hijklmn',
    tags: ['Switzerland', 'Hiking', 'Mountains'],
  ),
  Travel(
    title: 'Cherry Blossoms in Seoul',
    location: 'Seoul, South Korea',
    date: DateTime(2025, 4, 5),
    description: 'Walked along the Han River under cherry blossoms. Visited traditional palaces.',
    imageUrl: 'assets/travel/seoul.jpg',
    youtubeUrl: 'https://youtu.be/opqrstu',
    tags: ['Korea', 'Spring', 'Culture'],
  ),
];