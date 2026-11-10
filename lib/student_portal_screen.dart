import 'package:flutter/material.dart';
import 'math_formula_screen.dart';
import 'presentation_screen.dart';

class StudentPortalScreen extends StatefulWidget {
  const StudentPortalScreen({Key? key}) : super(key: key);

  @override
  State<StudentPortalScreen> createState() => _StudentPortalScreenState();
}

class _StudentPortalScreenState extends State<StudentPortalScreen> {
  final _roomCodeController = TextEditingController();
  bool _isInClass = false;

  void _joinClass() {
    if (_roomCodeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid class room code')),
      );
      return;
    }
    setState(() {
      _isInClass = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Successfully joined room: ${_roomCodeController.text}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClassRush Student Portal', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: !_isInClass ? _buildJoinScreen() : _buildClassroomView(),
      ),
    );
  }

  Widget _buildJoinScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.school, size: 80, color: Colors.orange),
        const SizedBox(height: 24),
        const Text(
          'Join a Live Class',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Text(
          'Enter the room code provided by your teacher to access live slides, math formulas, and interactive whiteboards.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 32),
        TextField(
          controller: _roomCodeController,
          decoration: InputDecoration(
            labelText: 'Room Code (e.g. CR-8024)',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.vpn_key, color: Colors.orange),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _joinClass,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Join Classroom', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildClassroomView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.between,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Connected Room:', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(_roomCodeController.text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
                ],
              ),
              OutlinedButton.icon(
                onPressed: () => setState(() => _isInClass = false),
                icon: const Icon(Icons.exit_to_app, color: Colors.red),
                label: const Text('Leave', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text('Shared Learning Tools', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Expanded(
          child: ListView(
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.slideshow, color: Colors.orange),
                  title: const Text('View Current Slide Deck'),
                  subtitle: const Text('Follow along with the teacher\'s presentation'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PresentationScreen()));
                  },
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.functions, color: Colors.orange),
                  title: const Text('Interactive Math Formulas'),
                  subtitle: const Text('Review LaTeX equations and Olympiad theorems'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MathFormulaScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
