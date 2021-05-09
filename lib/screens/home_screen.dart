import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:raid_list/screens/create_list_screen.dart';
import 'package:raid_list/viewmodels/bosses_view_model.dart';

import '../configuration.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BossesViewModel _bossesViewModel = Provider.of<BossesViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Criar lista'),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Lista de Reide',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: primaryRed,
              ),
            ),
            ListTile(
              title: Text('Criar lista'),
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (context) => CreateListScreen()));
              },
            ),
            ListTile(
              title: Text('Contas salvas'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/accounts');
                // Navigator.push(context, MaterialPageRoute(builder: (context) => AccountsScreen()));
              },
            ),
            ListTile(
              title: Text('Configurações'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/a');

                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Mdi.informationOutline),
              title: Text('Sobre'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: CreateListScreen(bosses: _bossesViewModel.bosses,),
    );
  }
}
