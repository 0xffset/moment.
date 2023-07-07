import 'package:flutter/material.dart';
import 'package:tarea_8/screens/home_page.dart';
import 'package:tarea_8/widgets/save.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Moment.",
      theme: ThemeData.dark(),
      home: const MyHome(),
      routes: {
        MySaveScreen.routeName: (context) => const MySaveScreen(),
      },
    );
  }
}
