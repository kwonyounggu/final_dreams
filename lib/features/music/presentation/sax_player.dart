import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SaxPlayer extends StatefulWidget {
  final String audioUrl;
  final String title;

  const SaxPlayer({super.key, required this.audioUrl, required this.title});

  @override
  State<SaxPlayer> createState() => _SaxPlayerState();
}

class _SaxPlayerState extends State<SaxPlayer> {
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.setUrl(widget.audioUrl);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          StreamBuilder<PlayerState>(
            stream: _player.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final playing = playerState?.playing ?? false;
              return IconButton(
                icon: Icon(playing ? Icons.pause_circle : Icons.play_circle),
                iconSize: 48,
                color: Colors.amber.shade400,
                onPressed: playing ? _player.pause : _player.play,
              );
            },
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                StreamBuilder<Duration>(
                  stream: _player.positionStream,
                  builder: (context, snapshot) {
                    final position = snapshot.data ?? Duration.zero;
                    return LinearProgressIndicator(
                      value: position.inMilliseconds / (300000), // Static 5-min max for demo
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation(Colors.amber.shade400),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}