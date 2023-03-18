import 'package:flutter/material.dart';

import 'melvor_layout_widget.dart';

class MelvorApp extends StatelessWidget {
  const MelvorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Melvor Idle Clone',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const MelvorLayoutWidget(),
    );
  }
}
