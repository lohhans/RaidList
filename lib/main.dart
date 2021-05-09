import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raid_list/initialize_get_it.dart';
import 'package:raid_list/route_generator.dart';
import 'package:raid_list/screens/home_screen.dart';
import 'package:raid_list/services/web_fetch_service.dart';
import 'package:raid_list/viewmodels/bosses_view_model.dart';

import 'configuration.dart';

void main() async {
  getIt.registerLazySingleton(() => WebFetchService());
  BossesViewModel bossesViewModel = BossesViewModel();

  bossesViewModel.onAppStart().then((_) {
    runApp(MyApp(bossesViewModel));
  });
}

class MyApp extends StatelessWidget {

  final BossesViewModel bossesViewModel;

  MyApp(this.bossesViewModel);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Raid list',
      theme: ThemeData(
        primarySwatch: customRed,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Provider(
        create: (context) => bossesViewModel,
        child: HomeScreen(),
      ),
      // initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
