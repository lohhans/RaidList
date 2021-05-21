import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:raid_list/models/boss_model.dart';
import 'package:raid_list/services/share_service.dart';
import 'package:raid_list/viewmodels/bosses_view_model.dart';
import 'package:share/share.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../configuration.dart';

class CreateListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> bosses;

  const CreateListScreen({Key key, this.bosses}) : super(key: key);

  @override
  _CreateListScreenState createState() => _CreateListScreenState();
}

class _CreateListScreenState extends State<CreateListScreen> {

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
  String _secondAccountName = '';
  String _secondAccountCod = '';

  bool _loading = false;

  var _now;
  Timer _everySecond; // ignore: unused_field

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

  @override
  void dispose() {
    _everySecond.cancel();
    super.dispose();
  }

  getBosses() async {
    // _loading = true;

    // bosses = await WebFetchService().fetchDataFromMestrePokemon();


    setState(() {
      _dropdownMenuItems = buildDropdownMenuItems(widget.bosses);
      _selectedBoss = null;
      // _loading = false;
    });
  }

  String formatTime(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("HH:mm");
    String timeFormatted = dateFormat.format(dateTime);
    return timeFormatted;
  }

  List<DropdownMenuItem<Boss>> buildDropdownMenuItems(List bosses) {
    List<DropdownMenuItem<Boss>> items = [];
    for (int k = 0; k < bosses.length; k++) {
      Boss boss = Boss(bosses[k]['name'], bosses[k]['sprite']);
      items.add(
        DropdownMenuItem(
          value: boss,
          onTap: () {
            print('Aqui mizera');
            print(boss.name);
            _selectedBoss = boss;
          },
          child: Container(
            width: 200.0, //200.0 to 100.0
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /*Flexible(
                    flex: 3,
                    child: Center(
                        child: boss.sprite.contains('http') ? Image.network(
                          boss.sprite,
                          height: 50,
                        ) : Image.asset(boss.sprite, height: 50, fit: BoxFit.fitHeight,))),
                Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                Flexible(flex: 7, child: Text(boss.name)),*/

                boss.sprite.contains('http') ? Image.network(
                  boss.sprite,
                  width: Get.width * 0.1,
                ) : Image.asset(boss.sprite, width: Get.width * 0.1,),
                SizedBox(width: 16),
                Text(boss.name, overflow: TextOverflow.ellipsis,),
              ],
            ),
          ),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Boss selectedBoss) {
    setState(() {
      print('chegou 1');
      _selectedBoss = selectedBoss;
      print('chegou 2');
      _raidBoss = _selectedBoss.name;
      print('chegou 3');
    });
  }

  @override
  Widget build(BuildContext context) {
    final BossesViewModel _bossesViewModel = Provider.of<BossesViewModel>(context);

    return Visibility(
      visible: _loading,
      child: Container(
        child: Center(
          child: Text('Carregando...'),
        ),
      ),
      replacement: SingleChildScrollView(
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
                          /*DropdownButton(
                            value: _selectedBoss,
                            onChanged: (value) {
                              setState(() {
                                _selectedBoss = value;
                              });
                            },
                            items: _bossesViewModel.bosses.map((value) {
                              // Boss boss = new Boss(value['name'], value['sprite']);
                              return DropdownMenuItem(child: Text(value['name']));
                            }),
                            // isExpanded: true,
                          ),*/
                          DropdownButton<Boss>(
                            value: _selectedBoss,
                            items: _dropdownMenuItems,
                            onChanged: onChangeDropdownItem,
                            underline: SizedBox(),
                            hint: _selectedBoss != null
                                ? null
                                : Text(
                              'Selecione o chefe de reide',
                              style: TextStyle(color: Colors.black),
                            ),
                            // isExpanded: true,
                          ),
                          // TextButton(onPressed: () => print(_bossesViewModel.bosses), child: Text('oi')),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            onChanged: (name) {
                              setState(() {
                                _gymName = name;
                              });
                            },
                            decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: primaryRed),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.grey[300]),
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
                              activeBgColor: primaryRed,
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
                                  label: _remainTimeOfRaid.toInt() == 1
                                      ? _remainTimeOfRaid.toInt().toString() +
                                      " minuto"
                                      : _remainTimeOfRaid.toInt().toString() +
                                      " minutos",
                                  divisions:
                                  (DateFormat('EEEE').format(_now) ==
                                      'Wednesday' &&
                                      _now.hour == 18)
                                      ? 60
                                      : 45,
                                  min: 1,
                                  max: (DateFormat('EEEE').format(_now) ==
                                      'Wednesday' &&
                                      _now.hour == 18)
                                      ? 60
                                      : 45,
                                  onChanged: (time) {
                                    setState(() {
                                      _remainTimeOfRaid = time;
                                      // _currentTime = DateTime.now();
                                      _maxWaitingTimeForRaid = 1;
                                    });
                                  },
                                ),
                                Text(_remainTimeOfRaid.toInt() == 1
                                    ? _remainTimeOfRaid.toInt().toString() +
                                    " minuto"
                                    : _remainTimeOfRaid.toInt().toString() +
                                    " minutos"),
                                const SizedBox(
                                  height: 24,
                                ),
                                Text('Que horas você quer fazer a Reide?'),
                                Slider(
                                  value: _maxWaitingTimeForRaid,
                                  label: formatTime(_now.add(Duration(
                                      minutes:
                                      _maxWaitingTimeForRaid.toInt()))),
                                  divisions: _remainTimeOfRaid.toInt(),
                                  min: 1,
                                  max: _remainTimeOfRaid,
                                  onChanged: (time) {
                                    setState(() {
                                      _maxWaitingTimeForRaid = time;
                                    });
                                  },
                                ),
                                Text(formatTime(_now.add(Duration(
                                    minutes:
                                    _maxWaitingTimeForRaid.toInt())))),
                                const SizedBox(
                                  height: 24,
                                ),
                              ],
                            ),
                            replacement: Column(
                              children: [
                                Text(
                                    'Quantos minutos faltam para a Reide iniciar?'),
                                Slider(
                                  value: _timeToStartRaid,
                                  label: _timeToStartRaid.toInt() == 1
                                      ? _timeToStartRaid.toInt().toString() +
                                      " minuto"
                                      : _timeToStartRaid.toInt().toString() +
                                      " minutos",
                                  divisions: 60,
                                  min: 1,
                                  max: 60,
                                  onChanged: (time) {
                                    setState(() {
                                      // _maxWaitingTimeForRaid = 1;
                                      _timeToStartRaid = time;

                                      _hatchTime = formatTime(_now.add(
                                          Duration(
                                              minutes:
                                              _timeToStartRaid.toInt())));
                                      print('_hatchTime: ' + _hatchTime);
                                      // _raidStartAt.add(Duration(minutes: _timeToStartRaid.toInt()));
                                    });
                                  },
                                ),
                                Text(_timeToStartRaid.toInt() == 1
                                    ? _timeToStartRaid.toInt().toString() +
                                    " minuto"
                                    : _timeToStartRaid.toInt().toString() +
                                    " minutos"),
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(
                                    'Que horas você quer fazer a Reide? (Choca: ' +
                                        formatTime(_now.add(Duration(
                                            minutes:
                                            _timeToStartRaid.toInt()))) +
                                        ')'),
                                Slider(
                                  value:
                                  _increaseMinutesToMaxWaitingTimeForRaid,
                                  label: formatTime(_now.add(Duration(
                                      minutes: _timeToStartRaid.toInt() +
                                          _increaseMinutesToMaxWaitingTimeForRaid
                                              .toInt()))),
                                  divisions:
                                  (DateFormat('EEEE').format(_now) ==
                                      'Wednesday' &&
                                      _now.hour == 18)
                                      ? 60
                                      : 45,
                                  min: 1,
                                  max: (DateFormat('EEEE').format(_now) ==
                                      'Wednesday' &&
                                      _now.hour == 18)
                                      ? 60
                                      : 45,
                                  onChanged: (time) {
                                    setState(() {
                                      _increaseMinutesToMaxWaitingTimeForRaid =
                                          time;

                                      _partyTime = formatTime(_now.add(Duration(
                                          minutes: _timeToStartRaid.toInt() +
                                              _increaseMinutesToMaxWaitingTimeForRaid
                                                  .toInt())));
                                      print('_partyTime: ' + _partyTime);
                                    });
                                  },
                                ),
                                Text(formatTime(_now.add(Duration(
                                    minutes: _timeToStartRaid.toInt() +
                                        _increaseMinutesToMaxWaitingTimeForRaid
                                            .toInt())))),
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
                            onChanged: (name) {
                              setState(() {
                                _firstAccountName = name;
                              });
                            },
                            // keyboardType: inputType,
                            decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: primaryRed),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.grey[300]),
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
                            onChanged: (name) {
                              setState(() {
                                _firstAccountCod = name;
                              });
                            },
                            // keyboardType: inputType,
                            decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: primaryRed),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.grey[300]),
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
                                  onChanged: (name) {
                                    setState(() {
                                      _firstAccountName = name;
                                    });
                                  },
                                  // keyboardType: inputType,
                                  decoration: new InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.0, color: primaryRed),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.0,
                                          color: Colors.grey[300]),
                                    ),
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                      left: 8,
                                      bottom: 4,
                                      top: 0,
                                      right: 8,
                                    ),
                                    labelText:
                                    'Informe o nick da primeira conta',
                                    // hintText: "Insira seu nick",
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                TextFormField(
                                  cursorColor: Colors.black,
                                  onChanged: (name) {
                                    setState(() {
                                      _firstAccountCod = name;
                                    });
                                  },
                                  // keyboardType: inputType,
                                  decoration: new InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.0, color: primaryRed),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.0,
                                          color: Colors.grey[300]),
                                    ),
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                      left: 8,
                                      bottom: 4,
                                      top: 0,
                                      right: 8,
                                    ),
                                    labelText:
                                    'Informe o código da primeira conta',
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
                            color: primaryRed,
                            // onPressed: ()  => Share.share('🔱 Boss: $_raidBoss \n ⛩ Gym: $_raidGym \n Eclode: $_timeToStartRaid \n" ⚔ Bater: $_raidBoss \n', subject: 'Look what I made!'),
                            // onPressed: ()  => ,

                            onPressed: () async {
                              ShareService shareService = ShareService();

                              var today = new DateTime.now();
                              var endOfRaid = today.add(Duration(
                                  minutes: _remainTimeOfRaid.toInt()));

                              // Output: 01/01/2021, 02:41 PM
                              // print(formatTime(endOfRaid));
                              // print(_timeToStartRaid);
                              // Share.share(_stringDataOfRaid + '\n' + _accountsData + '\n' + _warningsInfo);
                              Share.share(shareService.fullShare(
                                  _raidBoss,
                                  _raidGym,
                                  _hatchTime,
                                  _endTime,
                                  _partyTime,
                                  _firstAccountName,
                                  _firstAccountCod,
                                  _firstAccountName,
                                  _firstAccountCod));
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
