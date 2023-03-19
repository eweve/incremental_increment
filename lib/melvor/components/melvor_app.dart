import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incremental_increment/melvor/bloc/melvor_inventory_bloc.dart';
import 'package:incremental_increment/melvor/bloc/melvor_mining_bloc.dart';
import 'package:incremental_increment/melvor/game_logic/world_state.dart';

import 'melvor_layout_widget.dart';

class MelvorApp extends StatelessWidget {
  final WorldState worldState = WorldState();

  MelvorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Melvor Idle Clone',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<MelvorInventoryBloc>(
          create: (BuildContext context) =>
              MelvorInventoryBloc(worldState: worldState),
        ),
        BlocProvider<MelvorMiningBloc>(
          create: (BuildContext context) =>
              MelvorMiningBloc(worldState: worldState),
        ),
      ], child: const MelvorLayoutWidget()),
    );
  }
}
