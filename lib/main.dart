import 'package:flutter/material.dart';
import 'package:tarea_8/screens/home_page.dart';
import 'package:tarea_8/widgets/save.dart';
import 'modules/classes.dart';
import 'package:provider/provider.dart';
import 'screens/details_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>ImageFile(),
      child: MaterialApp(
        title: "Moment.",
        theme: ThemeData.dark(),
        home: const MyHome(),
        routes: {
          MySaveScreen.routeName: (context) => const MySaveScreen(),
          DetailsScreen.routerName:(context)=>DetailsScreen()
        },
      ),
    );
  }
}
