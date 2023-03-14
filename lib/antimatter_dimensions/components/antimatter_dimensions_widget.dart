import 'dart:async';

import 'package:flutter/material.dart';
import 'package:incremental_increment/antimatter_dimensions/game_logic/incrementer_buyer.dart';
import 'package:incremental_increment/antimatter_dimensions/game_logic/world_state.dart';

class AntimatterDimensionsApp extends StatelessWidget {
  const AntimatterDimensionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Idle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AntimatterDimensionsPage(title: 'Antimatter Dimensions'),
    );
  }
}

class AntimatterDimensionsPage extends StatefulWidget {
  const AntimatterDimensionsPage({super.key, required this.title});

  final String title;

  @override
  State<AntimatterDimensionsPage> createState() => _AntimatterDimensionsPageState();
}

class _AntimatterDimensionsPageState extends State<AntimatterDimensionsPage> {
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