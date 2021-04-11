import 'package:flutter/material.dart';
import 'package:raid_list/screens/lista_reide.dart';
import 'package:raid_list/services/web_fetch_service.dart' as web_fetch_service;

Future<void> main() async {
  print(await web_fetch_service.initiate());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Raid list',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListaReide(title: 'Lista de Reide'),
    );
  }
}

