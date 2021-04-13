import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:raid_list/helpers/database_helper.dart';
import 'package:raid_list/models/game_account_model.dart';
import 'package:raid_list/screens/create_list_screen.dart';

class AccountsScreen extends StatefulWidget {
  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  DatabaseHelper db = DatabaseHelper();

  List<GameAccount> gameAccounts = [];

  @override
  void initState() {
    super.initState();

    // GameAccount ga1 = GameAccount('ArmstrongLohans', '1234 5678 9123');
    // db.insertGameAccount(ga1);
    // GameAccount ga2 = GameAccount('LohansArmstrong', '0123 4567 8912');
    // db.insertGameAccount(ga2);
    //
    // db.getGameAccounts().then((value) => (lista){
    //   print(lista);
    // });

    fetchAccounts();

  }

  fetchAccounts() async{
    gameAccounts = await db.getGameAccounts();
  }

  _listGameAccounts(context, index) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(gameAccounts[index].accountName ?? ""),
            Text(gameAccounts[index].accountId ?? ""),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(gameAccounts);
    return Scaffold(
      appBar: AppBar(
        title: Text('Contas'),
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
              child: Text('Lista de Reide'),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            ListTile(
              title: Text('Criar lista'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => CreateListScreen()),
                    (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              title: Text('Contas salvas'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Configurações'),
              onTap: () {
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
      body: ListView.builder(itemCount: gameAccounts.length, itemBuilder: (context, index){
        return _listGameAccounts(context, index);
      }),
    );
  }
}
