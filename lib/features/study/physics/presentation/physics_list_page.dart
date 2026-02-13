import 'package:final_dreams/features/shared/widgets/latex_renderer.dart';
import 'package:flutter/material.dart';

import '../models/quantum_note.dart';
import 'physics_detail_page.dart';

class PhysicsListPage extends StatelessWidget {
  const PhysicsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quantum Mechanics & Physics"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            itemCount: quantumNotes.length,
            itemBuilder: (context, index) {
              final note = quantumNotes[index];
              return _buildPhysicsCard(context, note);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPhysicsCard(BuildContext context, QuantumNote note) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhysicsDetailPage(note: note),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    note.date.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.2,
                      color: Colors.blueGrey.shade400,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.science_outlined, size: 20, color: Colors.blueGrey),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Georgia', // Giving it a "textbook" feel
                ),
              ),
              const SizedBox(height: 12),
              Text(
                note.theory,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700, height: 1.5),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              // Mini-preview of the LaTeX formula
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Text("Key Eq: ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: LatexRenderer
                        (
                          formula: note.latexFormula,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}