import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:raid_list/services/share_service.dart';
import 'package:share/share.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:raid_list/services/web_fetch_service.dart' as web_fetch_service;

class Boss {
  String name;
  String sprite;

  Boss(this.name, this.sprite);



  // static List<Boss> getCompanies() {
  //   return <Boss>[
  //     Boss(1, 'Apple'),
  //     Company(2, 'Google'),
  //     Company(3, 'Samsung'),
  //     Company(4, 'Sony'),
  //     Company(5, 'LG'),
  //   ];
  // }
}

class ListaReide extends StatefulWidget {
  ListaReide({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListaReideState createState() => _ListaReideState();
}

class _ListaReideState extends State<ListaReide> {
  bool _chocou = false;
  bool _secondAccount = false;
  double _remainTimeOfRaid = 1;
  double _timeToStartRaid = 1;
  double _maxWaitingTimeForRaid = 1;
  double _increaseMinutesToMaxWaitingTimeForRaid = 1;
  // var _currentTime = DateTime.now();

  String _hatchTime = '';
  String _endTime = '';
  String _partyTime = '';

  String _raidBoss = '';
  String _raidGym = '';
  String _gymName = '';
  String _firstAccountName = '';
  String _firstAccountCod = '';
  String _secondtAccountName = '';
  String _secondAccountCod = '';

  String _stringDataOfRaid = '';
  String _accountsData = '';
  String _warningsInfo = '❗ *ATENÇÃO: Insira seu nick (nome do jogador) corretamente, pois somente com o nome correto será possível convidá-lo!* \n \n‼️ *LEMBRE-SE: A responsabilidade de adicionar a conta é do convidado, portanto, faça com antecedência!* \n \n⚠️ Obs: Somente é permitido 10 jogadores remotamente numa sala, acima disso o jogo não permite entrar na mesma ou convidar, então, por mais que sejam abertas até 15 vagas remotas na lista _(10 por convite e 5 por acesso a distância)_, somente os 10 primeiros a preencherem poderão ser convidados! *Se organizem e divirtam-se :)*';

  var _now;
  Timer _everySecond; // ignore: unused_field

  var bosses;
  List<DropdownMenuItem<Boss>> _dropdownMenuItems;
  Boss _selectedBoss;


  @override
  void initState() {
    super.initState();

    getBosses();

    // sets first value
    _now = DateTime.now();

    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  String formatTime(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("HH:mm");
    String timeFormatted = dateFormat.format(dateTime);
    return timeFormatted;
  }

  Future<void> getBosses() async {
    print('2');
    bosses = await web_fetch_service.initiate();

    _dropdownMenuItems = buildDropdownMenuItems(bosses);
    _selectedBoss = _dropdownMenuItems[0].value;

    // print(bosses[2]);
  }

  List<DropdownMenuItem<Boss>> buildDropdownMenuItems(List bosses) {
    List<DropdownMenuItem<Boss>> items = List();
    for (int k = 0; k < bosses.length; k++) {
      Boss boss = Boss(bosses[k]['name'], bosses[k]['sprite']);
      items.add(
        DropdownMenuItem(
          value: boss,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(flex: 3, child: Center(child: Image.network(boss.sprite, height: 100,))),
              Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
              Flexible(flex: 7, child: Text(boss.name)),
            ],
          ),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Boss selectedBoss) {
    setState(() {
      _selectedBoss = selectedBoss;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              // POKE NAME
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Monte sua lista para a Reide:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          /*TextFormField(
                            cursorColor: Colors.black,
                            onChanged: (name){
                              setState(() {
                                _raidBoss = name;
                              });
                            },
                            // keyboardType: inputType,
                            decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: Colors.grey[300]),
                              ),
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 8,
                                bottom: 4,
                                top: 0,
                                right: 8,
                              ),
                              labelText: 'Informe o chefe da Reide',
                              // hintText: "Insira seu nick",
                            ),
                          ),*/
                          DropdownButton(
                            value: _selectedBoss,
                            items: _dropdownMenuItems,
                            onChanged: onChangeDropdownItem,
                            // isExpanded: true,

                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            onChanged: (name){
                              setState(() {
                                _gymName = name;
                              });
                            },
                            decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: Colors.grey[300]),
                              ),
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 8,
                                bottom: 4,
                                top: 0,
                                right: 8,
                              ),
                              labelText: 'Digite o nome do Ginásio',
                              // hintText: "Insira seu nick",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // TIME
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'O ovo já chocou?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: ToggleSwitch(
                              changeOnTap: false,
                              initialLabelIndex: _chocou ? 1 : 0,
                              minWidth: 90.0,
                              cornerRadius: 20.0,
                              activeBgColor: Colors.red,
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey,
                              inactiveFgColor: Colors.white,
                              labels: ['SIM', 'NÃO'],
                              icons: [
                                FontAwesomeIcons.check,
                                FontAwesomeIcons.times,
                              ],
                              onToggle: (_) {
                                setState(() {
                                  _chocou = !_chocou;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Visibility(
                            visible: !_chocou,
                            child: Column(
                              children: [
                                Text('Qual o tempo restante da Reide?'),
                                Slider(
                                  value: _remainTimeOfRaid,
                                  label: _remainTimeOfRaid.toInt() == 1 ? _remainTimeOfRaid.toInt().toString() + " minuto" : _remainTimeOfRaid.toInt().toString() + " minutos",
                                  divisions: (DateFormat('EEEE').format(_now) == 'Wednesday' && _now.hour == 18) ? 60 : 45,
                                  min: 1,
                                  max: (DateFormat('EEEE').format(_now) == 'Wednesday' && _now.hour == 18) ? 60 : 45,
                                  onChanged: (time) {
                                    setState(() {
                                      _remainTimeOfRaid = time;
                                      // _currentTime = DateTime.now();
                                      _maxWaitingTimeForRaid = 1;
                                    });
                                  },
                                ),
                                Text(_remainTimeOfRaid.toInt() == 1 ? _remainTimeOfRaid.toInt().toString() + " minuto" : _remainTimeOfRaid.toInt().toString() + " minutos"),
                                const SizedBox(
                                  height: 24,
                                ),
                                Text('Que horas você quer fazer a Reide?'),
                                Slider(
                                  value: _maxWaitingTimeForRaid,
                                  label: formatTime(_now.add(Duration(minutes: _maxWaitingTimeForRaid.toInt()))),
                                  divisions: _remainTimeOfRaid.toInt(),
                                  min: 1,
                                  max: _remainTimeOfRaid,
                                  onChanged: (time) {
                                    setState(() {
                                      _maxWaitingTimeForRaid = time;
                                    });
                                  },
                                ),
                                Text(formatTime(_now.add(Duration(minutes: _maxWaitingTimeForRaid.toInt())))),
                                const SizedBox(
                                  height: 24,
                                ),
                              ],
                            ),
                            replacement: Column(
                              children: [
                                Text('Quantos minutos faltam para a Reide iniciar?'),
                                Slider(
                                  value: _timeToStartRaid,
                                  label: _timeToStartRaid.toInt() == 1 ? _timeToStartRaid.toInt().toString() + " minuto" : _timeToStartRaid.toInt().toString() + " minutos",
                                  divisions: 60,
                                  min: 1,
                                  max: 60,
                                  onChanged: (time) {
                                    setState(() {
                                      // _maxWaitingTimeForRaid = 1;
                                      _timeToStartRaid = time;

                                      _hatchTime = formatTime(_now.add(Duration(minutes: _timeToStartRaid.toInt())));
                                      print('_hatchTime: '+_hatchTime);
                                      // _raidStartAt.add(Duration(minutes: _timeToStartRaid.toInt()));
                                    });
                                  },
                                ),
                                Text(_timeToStartRaid.toInt() == 1 ? _timeToStartRaid.toInt().toString() + " minuto" : _timeToStartRaid.toInt().toString() + " minutos"),
                                const SizedBox(
                                  height: 24,
                                ),
                                Text('Que horas você quer fazer a Reide? (Choca: ' + formatTime(_now.add(Duration(minutes: _timeToStartRaid.toInt()))) + ')'),
                                Slider(
                                  value: _increaseMinutesToMaxWaitingTimeForRaid,
                                  label: formatTime(_now.add(Duration(minutes: _timeToStartRaid.toInt() + _increaseMinutesToMaxWaitingTimeForRaid.toInt()))),
                                  divisions: (DateFormat('EEEE').format(_now) == 'Wednesday' && _now.hour == 18) ? 60 : 45,
                                  min: 1,
                                  max: (DateFormat('EEEE').format(_now) == 'Wednesday' && _now.hour == 18) ? 60 : 45,
                                  onChanged: (time) {
                                    setState(() {
                                      _increaseMinutesToMaxWaitingTimeForRaid = time;

                                      _partyTime = formatTime(_now.add(Duration(minutes: _timeToStartRaid.toInt() + _increaseMinutesToMaxWaitingTimeForRaid.toInt())));
                                      print('_partyTime: '+_partyTime);
                                    });
                                  },
                                ),
                                Text(formatTime(_now.add(Duration(minutes: _timeToStartRaid.toInt() + _increaseMinutesToMaxWaitingTimeForRaid.toInt())))),
                                const SizedBox(
                                  height: 24,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // ACCOUNTS
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informe sua(s) conta(s):',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text('Primeira conta: '),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            onChanged: (name){
                              setState(() {
                                _firstAccountName = name;
                              });
                            },
                            // keyboardType: inputType,
                            decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: Colors.grey[300]),
                              ),
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 8,
                                bottom: 4,
                                top: 0,
                                right: 8,
                              ),
                              labelText: 'Informe o nick da primeira conta',
                              // hintText: "Insira seu nick",
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            onChanged: (name){
                              setState(() {
                                _firstAccountCod = name;
                              });
                            },
                            // keyboardType: inputType,
                            decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: Colors.grey[300]),
                              ),
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 8,
                                bottom: 4,
                                top: 0,
                                right: 8,
                              ),
                              labelText: 'Informe o código da primeira conta',
                              // hintText: "Insira seu nick",
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _secondAccount,
                                onChanged: (_) {
                                  setState(() {
                                    _secondAccount = !_secondAccount;
                                  });
                                },
                              ),
                              Text('Adicionar uma segunda conta?'),
                            ],
                          ),
                          Visibility(
                            visible: _secondAccount,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('Segunda conta: '),
                                const SizedBox(
                                  height: 12,
                                ),
                                TextFormField(
                                  cursorColor: Colors.black,
                                  onChanged: (name){
                                    setState(() {
                                      _firstAccountName = name;
                                    });
                                  },
                                  // keyboardType: inputType,
                                  decoration: new InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 1.0, color: Colors.red),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 1.0, color: Colors.grey[300]),
                                    ),
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                      left: 8,
                                      bottom: 4,
                                      top: 0,
                                      right: 8,
                                    ),
                                    labelText: 'Informe o nick da primeira conta',
                                    // hintText: "Insira seu nick",
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                TextFormField(
                                  cursorColor: Colors.black,
                                  onChanged: (name){
                                    setState(() {
                                      _firstAccountCod = name;
                                    });
                                  },
                                  // keyboardType: inputType,
                                  decoration: new InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 1.0, color: Colors.red),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 1.0, color: Colors.grey[300]),
                                    ),
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                      left: 8,
                                      bottom: 4,
                                      top: 0,
                                      right: 8,
                                    ),
                                    labelText: 'Informe o código da primeira conta',
                                    // hintText: "Insira seu nick",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // SHARE
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlatButton(
                            child: Text('Compartilhar'),
                            color: Colors.red,
                            // onPressed: ()  => Share.share('🔱 Boss: $_raidBoss \n ⛩ Gym: $_raidGym \n Eclode: $_timeToStartRaid \n" ⚔ Bater: $_raidBoss \n', subject: 'Look what I made!'),
                            // onPressed: ()  => ,


                            onPressed: () async {
                              ShareService shareService = ShareService();

                              var today = new DateTime.now();
                              var endOfRaid = today.add(Duration(minutes: _remainTimeOfRaid.toInt()));


                              // Output: 01/01/2021, 02:41 PM
                              // print(formatTime(endOfRaid));
                              // print(_timeToStartRaid);
                              // Share.share(_stringDataOfRaid + '\n' + _accountsData + '\n' + _warningsInfo);
                              Share.share(shareService.fullShare(_raidBoss, _raidGym, _hatchTime, _endTime, _partyTime, _firstAccountName, _firstAccountCod, _firstAccountName, _firstAccountCod));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}