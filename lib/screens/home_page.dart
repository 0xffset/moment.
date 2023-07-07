import 'package:flutter/material.dart';
import 'package:tarea_8/widgets/save.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          Navigator.pushNamed(context, MySaveScreen.routeName);
        },
        child: const Icon(
          Icons.image,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: const Text('Moment.'),
      ),
    );
  }
}
