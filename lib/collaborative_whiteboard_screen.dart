import 'package:flutter/material.dart';

enum DrawingTool { pen, highlighter, rectangle, circle, arrow }

class Stroke {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  final DrawingTool tool;

  Stroke({required this.points, required this.color, required this.strokeWidth, required this.tool});
}

class CollaborativeWhiteboardScreen extends StatefulWidget {
  const CollaborativeWhiteboardScreen({Key? key}) : super(key: key);

  @override
  State<CollaborativeWhiteboardScreen> createState() => _CollaborativeWhiteboardScreenState();
}

class _CollaborativeWhiteboardScreenState extends State<CollaborativeWhiteboardScreen> {
  DrawingTool _selectedTool = DrawingTool.pen;
  Color _selectedColor = Colors.black;
  double _strokeWidth = 4.0;
  final List<Stroke> _strokes = [];
  Stroke? _currentStroke;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClassRush Whiteboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Toolbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                _toolButton(Icons.edit, DrawingTool.pen, 'Pen'),
                _toolButton(Icons.highlight, DrawingTool.highlighter, 'Highlighter'),
                _toolButton(Icons.crop_square, DrawingTool.rectangle, 'Rectangle'),
                _toolButton(Icons.circle_outlined, DrawingTool.circle, 'Circle'),
                _toolButton(Icons.arrow_forward, DrawingTool.arrow, 'Arrow'),
                const VerticalDivider(),
                _colorSwatch(Colors.black),
                _colorSwatch(Colors.red),
                _colorSwatch(Colors.blue),
                _colorSwatch(Colors.green),
                _colorSwatch(Colors.orange),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.undo),
                  onPressed: _strokes.isNotEmpty ? () => setState(() => _strokes.removeLast()) : null,
                  tooltip: 'Undo',
                ),
                IconButton(
                  icon: const Icon(Icons.clear, color: Colors.red),
                  onPressed: () => setState(() => _strokes.clear()),
                  tooltip: 'Clear Board',
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Canvas Area
          Expanded(
            child: GestureDetector(
              onPanStart: (details) {
                setState(() {
                  _currentStroke = Stroke(
                    points: [details.localPosition],
                    color: _selectedTool == DrawingTool.highlighter ? _selectedColor.withOpacity(0.4) : _selectedColor,
                    strokeWidth: _selectedTool == DrawingTool.highlighter ? 18.0 : _strokeWidth,
                    tool: _selectedTool,
                  );
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  if (_currentStroke != null) {
                    _currentStroke!.points.add(details.localPosition);
                  }
                });
              },
              onPanEnd: (details) {
                setState(() {
                  if (_currentStroke != null) {
                    _strokes.add(_currentStroke!);
                    _currentStroke = null;
                  }
                });
              },
              child: CustomPaint(
                painter: WhiteboardPainter(strokes: _strokes, currentStroke: _currentStroke),
                size: Size.infinite,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolButton(IconData icon, DrawingTool tool, String tooltip) {
    final isSelected = _selectedTool == tool;
    return IconButton(
      icon: Icon(icon, color: isSelected ? Colors.orange : Colors.grey.shade700),
      tooltip: tooltip,
      onPressed: () => setState(() => _selectedTool = tool),
    );
  }

  Widget _colorSwatch(Color color) {
    return GestureDetector(
      onTap: () => setState(() => _selectedColor = color),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300, width: 2),
        ),
      ),
    );
  }
}

class WhiteboardPainter extends CustomPainter {
  final List<Stroke> strokes;
  final Stroke? currentStroke;

  WhiteboardPainter({required this.strokes, required this.currentStroke});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (var stroke in [...strokes, if (currentStroke != null) currentStroke!]) {
      paint.color = stroke.color;
      paint.strokeWidth = stroke.strokeWidth;

      if (stroke.tool == DrawingTool.pen || stroke.tool == DrawingTool.highlighter) {
        for (int i = 0; i < stroke.points.length - 1; i++) {
          canvas.drawLine(stroke.points[i], stroke.points[i + 1], paint);
        }
      } else if (stroke.tool == DrawingTool.rectangle && stroke.points.length >= 2) {
        canvas.drawRect(Rect.fromPoints(stroke.points.first, stroke.points.last), paint);
      } else if (stroke.tool == DrawingTool.circle && stroke.points.length >= 2) {
        final rect = Rect.fromPoints(stroke.points.first, stroke.points.last);
        canvas.drawOval(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
