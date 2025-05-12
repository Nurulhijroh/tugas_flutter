import 'package:flutter/material.dart';
import 'pages/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My List',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[400],
        primarySwatch: Colors.blue,
      ),
      darkTheme : ThemeData.dark(),
      themeMode : themeMode.system,
      home: const TodoScreen(),
    );
  }
}

