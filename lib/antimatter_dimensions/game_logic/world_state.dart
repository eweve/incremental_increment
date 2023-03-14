import 'package:incremental_increment/game/engine/unit/abstract_unit.dart';
import 'package:incremental_increment/game/engine/util/number.dart';
import 'package:incremental_increment/game/engine/util/pulse.dart';
import 'package:incremental_increment/antimatter_dimensions/game_logic/incrementer.dart';
import 'package:incremental_increment/antimatter_dimensions/game_logic/world_number.dart';

import 'incrementer_buyer.dart';

class WorldState {
  DateTime _lastTime = DateTime.now();
  final Pulse pulse = Pulse(null);

  final WorldNumber worldNumber = WorldNumber();
  final List<Incrementer> incrementers = [];
  final List<IncrementerBuyer> incrementerBuyers = [];

  WorldState() {
    init();
  }

  void init() {
    for (int i = 0; i < 4; i++) {
      List<Number Function()> modifiers = [];
      for (int j = i + 1; j < 4; j++) {
        modifiers.add(() => (incrementers[j].purchasedIncrementers.value >= Number.ten) ? Number.from(0.1) : Number.zero);
      }
      AbstractUnit incrementedValue = (i == 0) ? worldNumber : incrementers[i-1].incrementers;
      Incrementer incrementer = Incrementer(i, Incrementer.increment(incrementedValue), modifiers);
      incrementers.add(incrementer);

      IncrementerBuyer buyer = IncrementerBuyer(worldNumber, incrementer, i);
      incrementerBuyers.add(buyer);
    }
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

    for (Incrementer incrementer in incrementers) {
      incrementer.tick(timeUnit);
    }

    _lastTime = currentTime;
  }

  void resetTime() {
    _lastTime = DateTime.now();
  }

  void buyAll() {
    for (int i = incrementerBuyers.length; i > 0;) {
      var element = incrementerBuyers[--i];
      element.buyUpgrade();
    }
  }
}
