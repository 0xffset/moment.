import 'package:flutter/material.dart';
import 'package:tarea_8/widgets/image.dart';

class MySaveScreen extends StatefulWidget {
  static const routeName = 'MySaveScreen';
  const MySaveScreen({super.key});

  @override
  State<MySaveScreen> createState() => _MySaveScreenState();
}

class _MySaveScreenState extends State<MySaveScreen> {
  final _titleControler = TextEditingController();
  final _descriptionControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Save Moment."),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          TextField(
            controller: _titleControler,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(
            height: 50,
          ),
          TextField(
            controller: _descriptionControler,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(
            height: 50,
          ),
          const ImageSave(),
        ]),
      ),
    );
  }
}
