import 'package:flutter/material.dart';
import 'package:tarea_8/widgets/save.dart';
import 'package:provider/provider.dart';
import 'package:tarea_8/modules/classes.dart' as img;
import 'package:flutter/widgets.dart' as widgets;
import 'package:timeago/timeago.dart' as timeago;
import '../modules/classes.dart';
import 'dart:io';

import 'details_page.dart';

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
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: const Text('Moment.'),
        ),
        body: FutureBuilder(
          future:
              Provider.of<img.ImageFile>(context, listen: false).fetchImage(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<img.ImageFile>(
                  child: Center(child: const Text('Start adding your moment')),
                  builder: (context, image, ch) => image.items.length <= 0
                      ? ch!
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, i) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridTile(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, DetailsScreen.routerName,
                                        arguments: image.items[i].id);
                                  },
                                  child: widgets.Image.file(
                                    image.items[i].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              footer: GridTileBar(
                                leading: Text(
                                  image.items[i].title,
                                  style: TextStyle(fontSize: 30.0),
                                ),
                                subtitle: Text(image.items[i].description),
                                trailing: Text(timeago.format(
                                    DateTime.parse(image.items[i].time))),
                              ),
                            ),
                          ),
                          itemCount: image.items.length,
                        )),
        ));
  }
}
