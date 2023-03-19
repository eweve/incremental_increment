import 'package:incremental_increment/antimatter_dimensions/game_logic/incrementer_buyer.dart';
import 'package:incremental_increment/game/engine/unit/abstract_unit.dart';
import 'package:incremental_increment/game/engine/util/number.dart';
import 'package:incremental_increment/game/engine/util/pulse.dart';
import 'package:incremental_increment/antimatter_dimensions/game_logic/incrementer.dart';
import 'package:incremental_increment/antimatter_dimensions/game_logic/world_number.dart';

import 'inventory_manager.dart';

class WorldState {
  DateTime _lastTime = DateTime.now();
  final Pulse pulse = Pulse(null);

  final InventoryManager inventoryManager;

  WorldState(this.inventoryManager) {
    init();
  }

  void init() {

  }

  void tick() {
    var currentTime = DateTime.now();
    var delta = 0.001 *
        (currentTime.millisecondsSinceEpoch - _lastTime.millisecondsSinceEpoch);
    _lastTime = currentTime;
    if (delta <= 0) {
      return;
    }
    var timeUnit = pulse.next(delta * 5);

    _lastTime = currentTime;
  }

  void resetTime() {
    _lastTime = DateTime.now();
  }
}
