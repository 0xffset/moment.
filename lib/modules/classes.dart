import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:tarea_8/modules/database.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Image {
  late final String id;
  late final String title;
  late final String description;
  late final File image;
  late final time;

  Image(
      {required this.image,
      required this.title,
      required this.description,
      required this.id,
      required this.time});
}

class ImageFile with ChangeNotifier {
  List<Image> _items = [];
  List<Image> get items {
    return [..._items];
  }

  Future<void> addImagePlace(
      String title, String description, File image) async {
    final newImage = Image(
        image: image,
        title: title,
        description: description,
        id: uuid.v1(),
        time: DateTime.now().toString());
    _items.add(newImage);
    notifyListeners();
    DataBaseHelper.insert('moments', {
      'id': newImage.id,
      'title': newImage.title,
      'description': newImage.description,
      'time': newImage.time,
      'image': newImage.image.path
    });
  }

  Image findImage(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchImage() async {
    final list = await DataBaseHelper.getData('moments');
    _items = list.map((e) => Image(
        image: File(e['image']),
        title: e['title'],
        description: e['description'],
        time: e['time'],
        id: e['id'])).toList();
    notifyListeners();
  }
}
