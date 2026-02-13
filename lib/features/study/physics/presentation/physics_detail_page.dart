import 'package:final_dreams/features/shared/widgets/latex_renderer.dart';
import 'package:flutter/material.dart';

import '../models/quantum_note.dart';

class PhysicsDetailPage extends StatelessWidget {
  final QuantumNote note;

  const PhysicsDetailPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(note.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.title, style: Theme.of(context).textTheme.headlineMedium),
            Text(note.date, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            Text(note.theory, style: const TextStyle(fontSize: 18, height: 1.6)),
            const SizedBox(height: 40),
            const Text("Mathematical Representation:", 
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            // The LaTeX Renderer
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
                  ],
                ),
                child: LatexRenderer(
                  formula: note.latexFormula,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}