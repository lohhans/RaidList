import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:raid_list/screens/create_list/create_list_screen.dart';
import 'package:raid_list/screens/modules/drawer.dart';
import 'package:raid_list/viewmodels/bosses_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final BossesViewModel _bossesViewModel = Provider.of<BossesViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Criar lista'),
        actions: [
          _bossesViewModel.bosses.length == 1 ? Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    loading = true;

                  });
                  await _bossesViewModel.onAppStart();
                  setState(() {

                    loading = false;
                  });
                },
                child: Icon(
                  Mdi.reload,
                  size: 26.0,
                ),
              )
          ) : Container(),

          /*Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  await _bossesViewModel.onAppStart();
                  print('att');
                  *//*setState(() {
                    loading = false;
                  });*//*
                },
                child: Icon(
                  Mdi.reload,
                  size: 26.0,
                ),
              )
          )*/
        ],
      ),
      drawer: MyDrawer(),
      body: Visibility(
        visible: loading,
        child: Center(child: CircularProgressIndicator()),
        replacement: CreateListScreen(bosses: _bossesViewModel.bosses,),
      ),
    );
  }
}
