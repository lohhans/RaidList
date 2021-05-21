import 'package:flutter/material.dart';
import 'package:raid_list/configuration.dart';
import 'package:raid_list/helpers/database_helper.dart';
import 'package:raid_list/models/game_account_model.dart';

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

  fetchAccounts() async {
    gameAccounts = await db.getGameAccounts();
    setState(() {
      //  informa que a consulta foi realizada
    });
  }

  @override
  Widget build(BuildContext context) {
    print(gameAccounts);
    return Scaffold(
      appBar: AppBar(
        title: Text('Contas'),
      ),
      body: ListView.builder(
        itemCount: gameAccounts.length,
        itemBuilder: (context, index) {
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
        },
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.add),
          backgroundColor: primaryRed,
          onPressed: () {}),
    );
  }
}
