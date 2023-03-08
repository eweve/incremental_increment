import 'dart:async';

import 'package:flutter/material.dart';
import 'package:incremental_increment/game/state/antimatter_dimensions/incrementer_buyer.dart';
import 'package:incremental_increment/game/state/antimatter_dimensions/world_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Idle',
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
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Antimatter Dimensions'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isRunning = true;

  WorldState worldState = WorldState();

  void _incrementCounter() {
    setState(() {
      worldState.tick();
    });
  }

  void _buy() {
    worldState.buyAll();
  }

  @override
  void dispose() {
    _isRunning = false;
    super.dispose();
  }

  @override
  void initState() {
    worldState.init();
    Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
      if (!_isRunning) {
        // cancel the timer
        timer.cancel();
      }
      _incrementCounter();
    });
    super.initState();
  }

  String _formatDimension(IncrementerBuyer buyer) {
    return "Antimatter Dimension ${buyer.incrementer.dimension + 1} "
        "x${buyer.incrementer.modifier().toString()} "
        "${buyer.incrementer.incrementers.value.toString()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ...[
              Text(
                worldState.worldNumber.value.toString(),
                style: Theme.of(context).textTheme.displaySmall,
              )
            ],
            for (IncrementerBuyer buyer in worldState.incrementerBuyers)
              Row(
                children: [
                  Text(
                    _formatDimension(buyer),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  MaterialButton(
                      onPressed: buyer.buyUpgrade,
                      child: Container(
                        color: Colors.green,
                        child: Text(
                          'Cost: ${buyer.cost}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 13.0),
                        ),
                      )),
                ],
              ),
          ],
        ),
      )
    );
  }
}
