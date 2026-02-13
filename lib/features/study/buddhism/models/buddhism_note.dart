class BuddhismNote {
  final String title;
  final String date;
  final String content; // This will be your Markdown string
  final String category;

  BuddhismNote({
    required this.title,
    required this.date,
    required this.content,
    required this.category,
  });
}

// Example Data
final List<BuddhismNote> buddhismNotes = [
  BuddhismNote(
    title: "The Nature of Impermanence",
    date: "Oct 12, 2025",
    category: "Reflections",
    content: """
# Impermanence (Anicca)
Everything is in a state of **flux**. 

### Key Takeaways:
* Resistance to change causes *dukkha* (suffering).
* Mindfulness helps us observe the passing of thoughts.

> "Peace is the result of retraining your mind to process life as it is, rather than as you think it should be."
    """,
  ),
];