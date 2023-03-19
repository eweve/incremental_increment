import 'dart:async';

import 'package:incremental_increment/game/engine/util/pulse.dart';
import 'package:incremental_increment/melvor/game_logic/inventory_manager.dart';
import 'package:incremental_increment/melvor/game_logic/mining_manager.dart';

class WorldState {
  DateTime _lastTime = DateTime.now();
  final Pulse pulse = Pulse(null);

  late final InventoryManager inventoryManager;
  late final MiningManager miningManager;

  final StreamController<String> _tickEventStream = StreamController<String>.broadcast();
  StreamController<String> get tickEventStream => _tickEventStream;
  StreamSubscription? _timerSubscription;

  WorldState() {
    init();
  }

  void init() {
    inventoryManager = InventoryManager();
    miningManager = MiningManager(inventoryFunction: inventoryManager.handleTransaction);
    _timerSubscription = Stream.periodic(const Duration(milliseconds: 50)).listen((_) {
      tick();
    });
  }

  void tick() {
    var currentTime = DateTime.now();
    var delta = 0.001 *
        (currentTime.millisecondsSinceEpoch - _lastTime.millisecondsSinceEpoch);
    _lastTime = currentTime;
    if (delta <= 0) {
      return;
    }
    var timeUnit = pulse.next(delta);

    miningManager.tick(timeUnit);
    tickEventStream.sink.add("event");

    _lastTime = currentTime;
  }

  void resetTime() {
    _lastTime = DateTime.now();
  }
}
