
import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'dashboard_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ClassRushApp());
}

class ClassRushApp extends StatefulWidget {
  const ClassRushApp({super.key});

  @override
  State<ClassRushApp> createState() => _ClassRushAppState();
}

class _ClassRushAppState extends State<ClassRushApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _setThemeMode(ThemeMode mode) {
    setState(() => _themeMode = mode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClassRush',
      debugShowCheckedModeBanner: false,
      theme: ClassRushTheme.light,
      darkTheme: ClassRushTheme.dark,
      themeMode: _themeMode,
      home: DashboardScreen(
        themeMode: _themeMode,
        onThemeChanged: _setThemeMode,
      ),
    );
  }
}
