import 'package:flutter/material.dart';
import 'muller_lyer_widget.dart'; // Import the illusion widget we made

class VisionSciencePage extends StatelessWidget {
  const VisionSciencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vision Science Lab")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: const Column(
              children: [
                MullerLyerIllusion(),
                SizedBox(height: 60),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Computational visual perception involves understanding how the brain "
                    "reconstructs 3D scenes from 2D retinal images. Illusions like these "
                    "reveal the heuristics and 'short-circuits' in our neural processing.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}