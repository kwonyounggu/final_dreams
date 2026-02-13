import 'package:flutter/material.dart';

class LatexRenderer extends StatelessWidget {
  final String formula;
  final double fontSize;
  final Color color;

  const LatexRenderer({
    super.key,
    required this.formula,
    this.fontSize = 20,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    // We encode the formula to handle special characters in the URL
    final encodedFormula = Uri.encodeComponent(formula);
    
    // Using a high-quality SVG/PNG renderer API
    // format=svg provides the sharpest text on web
    final url = 'https://latex.codecogs.com/png.json?%5Cdpi%7B200%7D%20$encodedFormula';

    return Image.network(
      url,
      color: color == Colors.black ? null : color,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Text(formula, style: const TextStyle(fontFamily: 'monospace'));
      },
    );
  }
}