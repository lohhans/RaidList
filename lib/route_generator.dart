import 'package:flutter/material.dart';
import 'package:raid_list/screens/accounts/accounts_screen.dart';
import 'package:raid_list/screens/home_screen.dart';
import 'package:raid_list/screens/settings/settings_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/accounts':
        return MaterialPageRoute(builder: (_) => AccountsScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsScreen());
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
