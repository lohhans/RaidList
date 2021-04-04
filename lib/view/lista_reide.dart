import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:toggle_switch/toggle_switch.dart';

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

  @override
  void initState() {
    super.initState();

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
                          TextFormField(
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
                              var today = new DateTime.now();
                              var endOfRaid = today.add(Duration(minutes: _remainTimeOfRaid.toInt()));

                              this._stringDataOfRaid = '🔱 Boss: $_raidBoss \n ⛩ Gym: $_raidGym \n Eclode: $_timeToStartRaid \n" ⚔ Bater: $_raidBoss \n';
                              this._accountsData = 'Convidados \n Primeira conta responsável: $_firstAccountName \n Código da primeira conta: $_firstAccountCod \n 1.\n 2 \n 3. \n 4. \n 5. \nContas que irão remotamente (sem necessitar de convite):  \n 1. \n 2. \n 3. \n 4. \n 5. \n';

                              // Output: 01/01/2021, 02:41 PM
                              print(formatTime(endOfRaid));
                              print(_timeToStartRaid);
                              Share.share(_stringDataOfRaid + '\n' + _accountsData + '\n' + _warningsInfo);
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