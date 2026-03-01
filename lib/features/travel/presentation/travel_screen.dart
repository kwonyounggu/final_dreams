import 'package:final_dreams/features/travel/model/travel_structure.dart';
import 'package:flutter/material.dart';

import 'travel_card.dart';

class TravelScreen extends StatelessWidget {
  const TravelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Travel Stories',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'A collection of my journeys and adventures.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;
                  int crossAxisCount = width > 900 ? 3 : (width > 600 ? 2 : 1);
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.75, // adjust for card height
                    ),
                    itemCount: myTravels.length,
                    itemBuilder: (context, index) {
                      return TravelCard(travel: myTravels[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}