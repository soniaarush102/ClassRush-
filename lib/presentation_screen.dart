import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({Key? key}) : super(key: key);

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  String? _uploadedFileName;
  int _currentSlide = 1;
  final int _totalSlides = 5;
  final List<String> _slideNotes = [
    'Introduction to Olympiad Number Theory & Modular Arithmetic.',
    'Fermat\'s Little Theorem and Applications.',
    'Wilson\'s Theorem and Prime Residues.',
    'Solving Diophantine Equations using Congruences.',
    'Practice Problem Sets & Q&A Session.'
  ];

  Future<void> _pickPresentation() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['ppt', 'pptx', 'pdf'],
    );

    if (result != null) {
      setState(() {
        _uploadedFileName = result.files.single.name;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully loaded: $_uploadedFileName')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClassRush Presentation & Slides', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _pickPresentation,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Upload PPT / PDF'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _uploadedFileName = 'Custom Class Deck (Created)';
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Created new blank slide deck!')),
                    );
                  },
                  icon: const Icon(Icons.add_to_photos),
                  label: const Text('Create New Slide'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_uploadedFileName != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.description, color: Colors.orange),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Active Deck: $_uploadedFileName',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            const Text('Slide Viewer & Teaching Notes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Slide $_currentSlide of $_totalSlides',
                      style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        _slideNotes[_currentSlide - 1],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _currentSlide > 1 ? () => setState(() => _currentSlide--) : null,
                          child: const Text('Previous Slide'),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: _currentSlide < _totalSlides ? () => setState(() => _currentSlide++) : null,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                          child: const Text('Next Slide'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
