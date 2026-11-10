import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

class VideoClassroomScreen extends StatefulWidget {
  const VideoClassroomScreen({Key? key}) : super(key: key);

  @override
  State<VideoClassroomScreen> createState() => _VideoClassroomScreenState();
}

class _VideoClassroomScreenState extends State<VideoClassroomScreen> {
  Room? _room;
  bool _isConnected = false;
  bool _isMuted = false;
  bool _isVideoOff = false;

  // For testing/development, you can plug in a LiveKit sandbox URL and token here
  final String _defaultUrl = 'wss://your-livekit-server.livekit.cloud';
  final String _defaultToken = 'YOUR_LIVEKIT_TOKEN';

  @override
  void initState() {
    super.initState();
    // Automatically attempt connection on screen load
    _connectToClassroom();
  }

  Future<void> _connectToClassroom() async {
    try {
      final room = Room();
      
      // Connect to the LiveKit server room
      await room.connect(_defaultUrl, _defaultToken);
      
      // Enable camera and microphone by default for the teacher/student
      await room.localParticipant?.setCameraEnabled(true);
      await room.localParticipant?.setMicrophoneEnabled(true);

      setState(() {
        _room = room;
        _isConnected = true;
      });
    } catch (e) {
      // If mock/sandbox server credentials aren't set yet, fallback gracefully to UI grid
      debugPrint('LiveKit connection note: $e');
      setState(() {
        _isConnected = false; // Falls back to interactive grid view if offline
      });
    }
  }

  void _toggleMic() {
    setState(() {
      _isMuted = !_isMuted;
      _room?.localParticipant?.setMicrophoneEnabled(!_isMuted);
    });
  }

  void _toggleVideo() {
    setState(() {
      _isVideoOff = !_isVideoOff;
      _room?.localParticipant?.setCameraEnabled(!_isVideoOff);
    });
  }

  @override
  void dispose() {
    _room?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: const Text('ClassRush Live Video Classroom', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF2D2D2D),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Video Grid Area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildVideoTile('Teacher (You)', Icons.person, Colors.orange),
                  _buildVideoTile('Student 1', Icons.person_outline, Colors.blueGrey),
                  _buildVideoTile('Student 2', Icons.person_outline, Colors.blueGrey),
                  _buildVideoTile('Student 3', Icons.person_outline, Colors.blueGrey),
                ],
              ),
            ),
          ),
          
          // Control Bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            color: const Color(0xFF2D2D2D),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filled(
                  onPressed: _toggleMic,
                  icon: Icon(_isMuted ? Icons.mic_off : Icons.mic),
                  style: IconButton.styleFrom(
                    backgroundColor: _isMuted ? Colors.red : Colors.grey.shade800,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                IconButton.filled(
                  onPressed: _toggleVideo,
                  icon: Icon(_isVideoOff ? Icons.videocam_off : Icons.videocam),
                  style: IconButton.styleFrom(
                    backgroundColor: _isVideoOff ? Colors.red : Colors.grey.shade800,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                IconButton.filled(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.call_end),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoTile(String name, IconData icon, Color borderColor) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 48, color: Colors.white70),
                const SizedBox(height: 8),
                Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}
