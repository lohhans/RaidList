import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:get/get.dart';

import '../../configuration.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              Get.routing.current == '/' ? Get.back() : Get.offAndToNamed('/');
              // Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: Text('Copiar nome de usuários da lista'),
            onTap: () {
              Get.routing.current == '/copyNicknames' ? Get.back() : Get.offAndToNamed('/copyNicknames');
            },
          ),
          ListTile(
            title: Text('Contas salvas'),
            onTap: () {
              Get.routing.current == '/accounts' ? Get.back() : Get.offAndToNamed('/accounts');

              // OPÇÃO
              /*if(Get.routing.current == '/accounts') {
                Get.back();
              } else {
                Get.offNamedUntil('/', (route) => false);
                Get.toNamed('/accounts');
              }*/

              // Navigator.pushNamedAndRemoveUntil(context, '/accounts', (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: Text('Configurações'),
            onTap: () {
              Get.routing.current == '/settings' ? Get.back() : Get.offAndToNamed('/settings');
            },
          ),
          ListTile(
            leading: Icon(Mdi.informationOutline),
            title: Text('Sobre'),
            onTap: () {
              Get.routing.current == '/about' ? Get.back() : Get.offAndToNamed('/about');
            },
          ),
        ],
      ),
    );
  }
}
