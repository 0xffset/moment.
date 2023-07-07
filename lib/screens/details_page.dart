import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tarea_8/modules/classes.dart' as img;
import 'dart:io';
class DetailsScreen extends StatefulWidget {
  static const routerName = 'DetailsScreen';

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final imageId = ModalRoute.of(context)?.settings.arguments as String;
    final image =
        Provider.of<img.ImageFile>(context, listen: false).findImage(imageId);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            height: 400,
            width: double.infinity,
            child: Image.file(
              image.image,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            image.title,
            style: const TextStyle(fontSize: 30.0),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            image.description,
            style: const TextStyle(fontSize: 15.0),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'The moment was take at ${DateFormat.yMMMd().format(DateTime.parse(image.time))} ',
            style: const TextStyle(fontSize: 15.0),
          ),
        ],
      ),
    );
  }
}
