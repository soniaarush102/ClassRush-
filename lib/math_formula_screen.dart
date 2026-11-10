import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class MathFormulaScreen extends StatelessWidget {
  const MathFormulaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Math Formulas & LaTeX', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Advanced Mathematics & Olympiad Reference',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _formulaCard('Quadratic Formula', r'x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}'),
          _formulaCard('Euler\'s Identity', r'e^{i\pi} + 1 = 0'),
          _formulaCard('Binomial Theorem', r'(x + y)^n = \sum_{k=0}^{n} \binom{n}{k} x^{n-k} y^k'),
          _formulaCard('Sum of First $n$ Cubes', r'\sum_{i=1}^{n} i^3 = \left( \frac{n(n+1)}{2} \right)^2'),
        ],
      ),
    );
  }

  Widget _formulaCard(String title, String latex) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
            const SizedBox(height: 12),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Math.tex(
                  latex,
                  textStyle: const TextStyle(fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
