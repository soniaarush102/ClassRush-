import 'package:flutter/material.dart';

class VideoClassroomScreen extends StatefulWidget {
  const VideoClassroomScreen({Key? key}) : super(key: key);

  @override
  State<VideoClassroomScreen> createState() => _VideoClassroomScreenState();
}

class _VideoClassroomScreenState extends State<VideoClassroomScreen> {
  bool _isMicMuted = false;
  bool _isVideoOff = false;
  bool _isHandRaised = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: const Text('ClassRush Live Room (LiveKit)', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2D2D2D),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(_isHandRaised ? Icons.front_hand : Icons.back_hand_outlined, color: _isHandRaised ? Colors.orange : Colors.white),
            onPressed: () => setState(() => _isHandRaised = !_isHandRaised),
            tooltip: 'Raise Hand',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(12),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _videoTile('Teacher (Host)', Colors.orange.shade800, false),
                _videoTile('Student 1', Colors.blue.shade800, true),
                _videoTile('Student 2', Colors.green.shade800, false),
                _videoTile('Student 3', Colors.purple.shade800, true),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            color: const Color(0xFF2D2D2D),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => setState(() => _isMicMuted = !_isMicMuted),
                  icon: Icon(_isMicMuted ? Icons.mic_off : Icons.mic),
                  color: _isMicMuted ? Colors.red : Colors.white,
                  iconSize: 28,
                ),
                IconButton(
                  onPressed: () => setState(() => _isVideoOff = !_isVideoOff),
                  icon: Icon(_isVideoOff ? Icons.videocam_off : Icons.videocam),
                  color: _isVideoOff ? Colors.red : Colors.white,
                  iconSize: 28,
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Screen sharing tools active')),
                    );
                  },
                  icon: const Icon(Icons.screen_share),
                  color: Colors.white,
                  iconSize: 28,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.call_end),
                  color: Colors.red,
                  iconSize: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _videoTile(String name, Color bgColor, bool isMuted) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Text(name, style: const TextStyle(color: Colors.white, fontSize: 12)),
                  if (isMuted) const SizedBox(width: 4),
                  if (isMuted) const Icon(Icons.mic_off, color: Colors.red, size: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
