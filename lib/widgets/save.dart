import 'dart:io';
import 'package:provider/provider.dart';
import 'package:tarea_8/modules/classes.dart';
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
  late File savedImage;

  void savedImages(File image) {
    savedImage = image;
  }

  void onSave() {
    if (_titleControler.text.isEmpty ||
        _descriptionControler.text.isEmpty ||
        savedImage == null) {
      // show modal
      return;
    } else {
      Provider.of<ImageFile>(context, listen: false).addImagePlace(
          _titleControler.text, _descriptionControler.text, savedImage);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Save Moment."),
        actions: [IconButton(onPressed: onSave, icon: const Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
            ImageSave(savedImages),
          ]),
        ),
      ),
    );
  }
}
