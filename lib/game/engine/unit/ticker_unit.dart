import 'package:incremental_increment/game/engine/unit/ticker_mixin.dart';
import 'package:incremental_increment/game/engine/util/time_unit.dart';
import 'package:incremental_increment/game/engine/unit/abstract_unit.dart';
import 'package:incremental_increment/game/engine/util/number.dart';

class TickerUnit extends AbstractUnit with TickerMixin {
  final bool isAccumulator;
  late final Number Function(Number) produce;

  TickerUnit({this.isAccumulator = false}) {
    if (isAccumulator) {
      produce = accumulate;
    } else {
      produce = setValue;
    }
    init();
  }

  factory TickerUnit.from(Number number) {
    var unit = TickerUnit();
    unit.value = number;
    return unit;
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

  Number decrease(Number amount) {
    assert(amount.isNonNegative());
    return accumulate(-amount);
  }

  Number setValue(Number amount) {
    value = amount;
    return value;
  }

  Number accumulate(Number amount) {
    value += amount;
    return value;
  }
}
