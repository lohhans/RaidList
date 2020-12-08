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
  double _remainTimeOfRaid = 1;
  double _maxWaitingTimeForRaid = 1;
  // var _currentTime = DateTime.now();

  var _now;
  Timer _everySecond;

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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                                  divisions: 45,
                                  min: 1,
                                  max: 45,
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
                                Text('nn chocou'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
