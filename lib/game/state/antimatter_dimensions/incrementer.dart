import 'package:incremental_increment/game/engine/unit/abstract_unit.dart';
import 'package:incremental_increment/game/engine/unit/producer_unit.dart';
import 'package:incremental_increment/game/engine/unit/resource_unit.dart';
import 'package:incremental_increment/game/engine/util/number.dart';
import 'package:incremental_increment/game/engine/util/time_unit.dart';

class Incrementer extends ProducerUnit {
  final int dimension;
  final Function(Incrementer, TimeUnit, Number) produce;
  final List<Number Function()> summedModifiers;

  final ResourceUnit purchasedIncrementers = ResourceUnit();
  final ResourceUnit incrementers = ResourceUnit();

  static final List<Number> baseIncrement =
    [Number.one, Number.from(0.1), Number.from(0.1), Number.from(0.1)];

  Incrementer(this.dimension, this.produce, this.summedModifiers);

  Number modifier() {
    Number finalModifier = Number.one;
    for (Function mod in summedModifiers) {
      finalModifier += mod();
    }
    return finalModifier;
  }

  @override
  void unitTick(TimeUnit timeUnit) {
    produce(this, timeUnit, modifier());
  }

  static Function(Incrementer, TimeUnit, Number) increment(AbstractUnit target) {
    return (Incrementer source, TimeUnit time, Number modifier) {
      target.value +=
          time.scaledTime
              * baseIncrement[source.dimension] // base value
              * source.incrementers.value       // number of incrementers
              * modifier;                       // multipliers
    };
  }
}