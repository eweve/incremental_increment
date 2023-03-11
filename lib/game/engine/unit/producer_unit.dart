import 'package:incremental_increment/game/engine/unit/abstract_unit.dart';
import 'package:incremental_increment/game/engine/unit/resource_unit.dart';
import 'package:incremental_increment/game/engine/unit/ticker_mixin.dart';
import 'package:incremental_increment/game/engine/util/time_unit.dart';

class ProducerUnit extends ResourceUnit with TickerMixin {
  ProducerUnit() {
    init();
  }

  void unitTick(TimeUnit timeUnit) {

  }

  void tick(TimeUnit timeUnit) {
    baseTick(timeUnit, unitTick);
  }

  @override
  void transfer(AbstractUnit unit) {
    super.transfer(unit);

    if (unit is TickerMixin) {
      transferTicker(unit as TickerMixin);
    }
  }

  @override
  void reset() {
    super.reset();
    resetTicker();
  }
}