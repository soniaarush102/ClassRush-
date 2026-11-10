import 'package:flutter/material.dart';
import 'create_classroom_screen.dart';
import 'collaborative_whiteboard_screen.dart';
import 'math_formula_screen.dart';
import 'video_classroom_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ClassRushApp());
}

class ClassRushApp extends StatelessWidget {
  const ClassRushApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClassRush',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('CR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            const Text('ClassRush Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome, Teacher!', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateClassroomScreen()));
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Create Class'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CollaborativeWhiteboardScreen()));
                  },
                  icon: const Icon(Icons.dashboard, color: Colors.orange),
                  label: const Text('Whiteboard'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MathFormulaScreen()));
                  },
                  icon: const Icon(Icons.functions, color: Colors.orange),
                  label: const Text('Math Formulas'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text('Active & Recent Sessions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Icon(Icons.video_call, color: Colors.white),
                      ),
                      title: const Text('Advanced Mathematics Olympiad Class'),
                      subtitle: const Text('Live Video & Interactive Whiteboard Active'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const VideoClassroomScreen()));
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                        child: const Text('Join Live'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
