import 'package:flutter/material.dart';
import 'package:raid_list/main.dart';
import 'package:raid_list/screens/accounts_screen.dart';
import 'package:raid_list/screens/create_list_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => CreateListScreen());
      case '/accounts':
        return MaterialPageRoute(builder: (_) => AccountsScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Erro'),
        ),
        body: Center(
          child: Text('Erro'),
        ),
      );
    });
  }
}
