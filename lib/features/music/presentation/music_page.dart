import 'package:flutter/material.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Music & Saxophone")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("The Sound", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildAudioPlaceholder(),
            const SizedBox(height: 40),
            const Text("Gear List", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Divider(),
            _buildGearItem("Tenor Saxophone", "Selmer Mark VI / Yamaha Custom Z"),
            _buildGearItem("Mouthpiece", "Otto Link Super Tone Master (7*)"),
            _buildGearItem("Reeds", "Vandoren Java Red 3.0"),
            _buildGearItem("Recording Mic", "AKG C214"),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioPlaceholder() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
          const SizedBox(height: 16),
          const Text("Jazz Improvisation #1", style: TextStyle(color: Colors.white, fontSize: 18)),
          Text("Recorded Feb 2026", style: TextStyle(color: Colors.blueGrey.shade300)),
        ],
      ),
    );
  }

  Widget _buildGearItem(String category, String model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.music_note, size: 18, color: Colors.blueGrey),
          const SizedBox(width: 12),
          Text("$category: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(model),
        ],
      ),
    );
  }
}