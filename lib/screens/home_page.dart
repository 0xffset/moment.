import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
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
          actions: <Widget>[
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(value: 0, child: Text('Clean all')),
              ],
            ),
          ],
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
                          itemBuilder: (context, i) => Dismissible(
                            background: Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              alignment: AlignmentDirectional.centerStart,
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                              secondaryBackground: Container(
                                color:  Colors.transparent,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                alignment: AlignmentDirectional.centerEnd,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                              key: ValueKey(i),
                              confirmDismiss: (direction) => promptUser(direction, context) ,
                              onDismissed: (direction) {
                                return handleDismiss(direction, context, i, image.items);

                              },
                              child: Padding(
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
                                   /* leading: Text(
                                      image.items[i].title,
                                      style: TextStyle(fontSize: 30.0),
                                    ),*/
                                    //subtitle: Text(image.items[i].description),
                                    trailing: Text(timeago.format(
                                        DateTime.parse(image.items[i].time))),
                                  ),
                                ),
                              )),
                          itemCount: image.items.length,
                        )),
        ));


  }
  Future<bool?> promptUser(DismissDirection direction, BuildContext context) async {
    String action;
    if (direction == DismissDirection.startToEnd) {
      // This is a delete action
      action = "delete";
    } else {
      // archiveItem();
      // This is an archive action
      action = "archive";
    }

    return   action == "delete" ?  await showDialog<bool?>(
      context: context,
      builder: (BuildContext context){
        return  AlertDialog(

          title: const Text('Are you sure do you want to delete this moment?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This action cannot be undone'),
                Text('If you sure, press delete, otherwise, cancel.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Not, don't delete it"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Yes!'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },

    ) : false;// In case the user dismisses the dialog by clicking away from it
  }

  handleDismiss(DismissDirection direction, BuildContext context, int index, dynamic items) {
    // Get a reference to the swiped item
    final swipedEmail = items[index];

    // Remove it from the list
    items.removeAt(index);

    String action;
    if (direction == DismissDirection.startToEnd) {
      //deleteItem();
      action = "Deleted";
    } else {
      //archiveItem();
      action = "Archived";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$action. Do you want to undo?"),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
            label: "Undo",
            textColor: Colors.yellow,
            onPressed: () {
              // Deep copy the email
             // final copiedEmail = Email.copy(swipedEmail);
              // Insert it at swiped position and set state
             // setState(() => items.insert(index, copiedEmail));
            }),
      ),
    )
        .closed
        .then((reason) {
      if (reason != SnackBarClosedReason.action) {
        // The SnackBar was dismissed by some other means
        // that's not clicking of action button
        // Make API call to backend

      }
    });
  }

}


void handleClick(int item) {
  switch (item) {
    case 0:
      break;
    case 1:
      break;
  }
}
