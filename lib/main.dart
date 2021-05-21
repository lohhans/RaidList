import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:raid_list/initialize_get_it.dart';
import 'package:raid_list/screens/accounts/accounts_screen.dart';
import 'package:raid_list/screens/copy_nicknames/copy_nicknames_screen.dart';
import 'package:raid_list/screens/home_screen.dart';
import 'package:raid_list/screens/not_found/not_found_screen.dart';
import 'package:raid_list/screens/settings/settings_screen.dart';
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Raid list',
      theme: ThemeData(
        primarySwatch: customRed,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // fontFamily: 'Circular',
      ),
      home: Provider(
        create: (context) => bossesViewModel,
        child: HomeScreen(),
      ),
      defaultTransition: Transition.native,
      unknownRoute: GetPage(name: '/notFound', page: () => NotFoundScreen()),
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/accounts', page: () => AccountsScreen()),
        GetPage(name: '/settings', page: () => SettingsScreen()),
        GetPage(name: '/copyNicknames', page: () => CopyNicknamesScreen()),
      ],
      // initialRoute: '/',
      // onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
