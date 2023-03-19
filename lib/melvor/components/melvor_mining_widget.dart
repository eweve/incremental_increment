import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:incremental_increment/melvor/components/melvor_mining_action_card_widget.dart';
import 'package:incremental_increment/melvor/game_logic/mining_manager.dart';

class MelvorMiningWidget extends StatefulWidget {
  const MelvorMiningWidget({Key? key}) : super(key: key);

  @override
  State<MelvorMiningWidget> createState() => _MelvorMiningWidgetState();
}

class _MelvorMiningWidgetState extends State<MelvorMiningWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _controller.addListener(() { setState(() {}); });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Melvor Idle - Mining',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown.shade500,
          leading: Padding(
              padding: const EdgeInsets.all(5),
              child: SvgPicture.asset('lib/melvor/assets/war-pick.svg')
          ),
          title: const Text('Mining'),
        ),
        body: Container(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: const [
                    MelvorMiningActionCardWidget(resource: MiningResource.copperNode),
                    MelvorMiningActionCardWidget(resource: MiningResource.tinNode),
                    MelvorMiningActionCardWidget(resource: MiningResource.ironNode),
                    MelvorMiningActionCardWidget(resource: MiningResource.coalNode),
                  ],
                )
            )
        ),
      ),
    );
  }
}
