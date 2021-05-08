import 'package:flutter/material.dart';
import 'package:raid_list/configuration.dart';
import 'package:raid_list/route_generator.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Raid list',
      theme: ThemeData(
        primaryColor: primaryRed,
        accentColor: primaryRed,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

