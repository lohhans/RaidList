import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Raid list',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Lista de Reide'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _chocou = false;
  bool _secondAccount = false;
  double _remainTimeOfRaid = 1;
  double _timeToStartRaid = 1;
  double _maxWaitingTimeForRaid = 1;
  double _increaseMinutesToMaxWaitingTimeForRaid = 1;
  // var _currentTime = DateTime.now();

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
                          Text(
                            'Digite o nome do Pokémon:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextFormField(),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            // keyboardType: inputType,
                            decoration: new InputDecoration(
                              /*border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.0, color: Colors.red),
                              ),*/
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: Colors.grey),
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
                            // keyboardType: inputType,
                            decoration: new InputDecoration(
                              /*border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.0, color: Colors.red),
                              ),*/
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: Colors.grey),
                              ),
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 8,
                                bottom: 4,
                                top: 0,
                                right: 8,
                              ),
                              labelText: 'Insira seu nick',
                              // hintText: "Insira seu nick",
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            // keyboardType: inputType,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 8,
                                bottom: 4,
                                top: 0,
                                right: 8,
                              ),
                              labelText: 'Insira seu ID',
                              // hintText: "Insira seu nick",
                            ),
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
                                TextFormField(
                                  cursorColor: Colors.black,
                                  // keyboardType: inputType,
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                      left: 8,
                                      bottom: 4,
                                      top: 0,
                                      right: 8,
                                    ),
                                    labelText: 'Insira seu nick',
                                    // hintText: "Insira seu nick",
                                  ),
                                ),
                                TextFormField(
                                  cursorColor: Colors.black,
                                  // keyboardType: inputType,
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                      left: 8,
                                      bottom: 4,
                                      top: 0,
                                      right: 8,
                                    ),
                                    labelText: 'Insira seu ID',
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
                            onPressed: () {
                              var today = new DateTime.now();
                              var endOfRaid = today.add(Duration(minutes: _remainTimeOfRaid.toInt()));

                              // Output: 01/01/2021, 02:41 PM
                              print(formatTime(endOfRaid));
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
