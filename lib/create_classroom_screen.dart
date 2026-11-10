import 'package:flutter/material.dart';

class CreateClassroomScreen extends StatefulWidget {
  const CreateClassroomScreen({Key? key}) : super(key: key);

  @override
  State<CreateClassroomScreen> createState() => _CreateClassroomScreenState();
}

class _CreateClassroomScreenState extends State<CreateClassroomScreen> {
  final _classNameController = TextEditingController();
  String _selectedSubject = 'Mathematics';
  int _participantLimit = 50;
  bool _allowStudentAnnotations = true;
  bool _micEnabledByDefault = true;

  final List<String> _subjects = ['Mathematics', 'Physics', 'Chemistry', 'Biology', 'Computer Science'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Classroom', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const Text(
              'Configure Class Settings',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _classNameController,
              decoration: const InputDecoration(
                labelText: 'Classroom Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.class_),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedSubject,
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.book),
              ),
              items: _subjects.map((subject) {
                return DropdownMenuItem(value: subject, child: Text(subject));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSubject = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Participant Capacity Limit', style: TextStyle(fontWeight: FontWeight.w600)),
            Slider(
              value: _participantLimit.toDouble(),
              min: 10,
              max: 200,
              divisions: 19,
              label: '$_participantLimit participants',
              activeColor: Colors.orange,
              onChanged: (value) {
                setState(() {
                  _participantLimit = value.toInt();
                });
              },
            ),
            SwitchListTile(
              title: const Text('Allow Student Whiteboard Annotations'),
              subtitle: const Text('Students can write and draw on the shared board'),
              value: _allowStudentAnnotations,
              activeColor: Colors.orange,
              onChanged: (val) => setState(() => _allowStudentAnnotations = val),
            ),
            SwitchListTile(
              title: const Text('Mute Microphones Upon Joining'),
              subtitle: const Text('Participants join with mics muted by default'),
              value: _micEnabledByDefault,
              activeColor: Colors.orange,
              onChanged: (val) => setState(() => _micEnabledByDefault = val),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Generate meeting ID and launch live room
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Classroom "${_classNameController.text}" Created Successfully!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Generate Meeting & Start Class', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
