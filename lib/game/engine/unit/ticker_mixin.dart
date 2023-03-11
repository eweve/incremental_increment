import 'package:incremental_increment/game/engine/util/time_unit.dart';
import 'package:meta/meta.dart';

// TODO: Decide if mixin > composition pattern in this situation
mixin TickerMixin {

  @protected TimeUnit lastTimeUnit = TimeUnit.nonExistent;

  @protected bool isRunning = false;
  bool get running => isRunning;

  bool isNextTick(TimeUnit timeUnit) {
    return timeUnit.compareTo(lastTimeUnit) > 0;
  }

  void baseTick(TimeUnit timeUnit, Function(TimeUnit) action) {
    if (!isRunning && isNextTick(timeUnit)) {
      isRunning = true;
      action(timeUnit);
      isRunning = false;
      lastTimeUnit = timeUnit;
    }
  }

  void transferTicker(TickerMixin ticker) {
    lastTimeUnit = ticker.lastTimeUnit;
    isRunning = ticker.isRunning;
  }

  void resetTicker() {
    lastTimeUnit = TimeUnit.nonExistent;
  }
}