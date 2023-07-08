import 'dart:io';
import 'package:provider/provider.dart';
import 'package:tarea_8/modules/classes.dart';
import 'package:flutter/material.dart';
import 'package:tarea_8/widgets/image.dart';
import 'package:tarea_8/widgets/record_audio.dart';
import 'package:tarea_8/widgets/show_audio.dart';

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
  late File savedAudio;

  void savedImages(File image) {
    savedImage = image;
  }

  void audioSaves(File audio) {
    savedAudio = audio;
  }

  void onSave() {
    if (_titleControler.text.isEmpty ||
        _descriptionControler.text.isEmpty ||
        savedImage == null || savedAudio == null) {
      // show modal
      return;
    } else {
      Provider.of<ImageFile>(context, listen: false).addImagePlace(
          _titleControler.text, _descriptionControler.text, savedImage, savedAudio);
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
            const Text(
              "Record a new Moment. in your awesome life",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: _titleControler,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: _descriptionControler,
              maxLines: 8,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(
              height: 25,
            ),
            ImageSave(savedImages),
            const SizedBox(
              height: 25,
            ),
          RecordAudio(audioSaves)
          ]),
        ),
      ),
    );
  }
}
