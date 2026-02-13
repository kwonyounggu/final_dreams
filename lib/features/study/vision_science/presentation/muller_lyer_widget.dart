import 'package:flutter/material.dart';

class MullerLyerIllusion extends StatefulWidget {
  const MullerLyerIllusion({super.key});

  @override
  State<MullerLyerIllusion> createState() => _MullerLyerIllusionState();
}

class _MullerLyerIllusionState extends State<MullerLyerIllusion> {
  double _topLineWidth = 200.0;
  double _bottomLineWidth = 200.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "The Müller-Lyer Illusion",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text("Adjust the sliders until the two horizontal lines look equal in length."),
        ),
        const SizedBox(height: 40),
        
        // The Top Line (Arrows pointing inward)
        _buildLine(width: _topLineWidth, arrowsOut: false),
        const SizedBox(height: 60),
        
        // The Bottom Line (Arrows pointing outward)
        _buildLine(width: _bottomLineWidth, arrowsOut: true),
        
        const SizedBox(height: 50),
        
        // Controls
        _buildSlider("Top Line", _topLineWidth, (val) => setState(() => _topLineWidth = val)),
        _buildSlider("Bottom Line", _bottomLineWidth, (val) => setState(() => _bottomLineWidth = val)),
        
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _topLineWidth = 200.0;
              _bottomLineWidth = 200.0;
            });
          },
          child: const Text("Reset to Equal Length"),
        ),
      ],
    );
  }

  Widget _buildLine({required double width, required bool arrowsOut}) {
    const double arrowSize = 20.0;
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // The main horizontal line
        Container(height: 3, width: width, color: Colors.black),
        
        // Left Fin
        Positioned(
          left: 0,
          child: _buildFin(arrowSize, arrowsOut, isLeft: true),
        ),
        
        // Right Fin
        Positioned(
          right: 0,
          child: _buildFin(arrowSize, arrowsOut, isLeft: false),
        ),
      ],
    );
  }

  Widget _buildFin(double size, bool outward, {required bool isLeft}) {
    double angle = outward ? (isLeft ? 0.7 : -0.7) : (isLeft ? -0.7 : 0.7);
    return Transform.rotate(
      angle: angle,
      child: Container(
        height: 2,
        width: size,
        color: Colors.black,
        alignment: isLeft ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Transform.rotate(angle: 0.8, child: Container(height: 2, width: size, color: Colors.black)),
            Transform.rotate(angle: -0.8, child: Container(height: 2, width: size, color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(String label, double value, ValueChanged<double> onChanged) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text(label)),
        Expanded(
          child: Slider(
            min: 100,
            max: 300,
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}