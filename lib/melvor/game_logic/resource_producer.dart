import 'package:incremental_increment/game/engine/unit/abstract_unit.dart';
import 'package:incremental_increment/game/engine/unit/producer_unit.dart';
import 'package:incremental_increment/game/engine/unit/resource_unit.dart';
import 'package:incremental_increment/game/engine/util/number.dart';
import 'package:incremental_increment/game/engine/util/time_unit.dart';

class ResourceProducer extends ProducerUnit {
  // Resource producer needs to know
  // - what it is producing
  // - how often it is producing
  // - how much it is producing
  // It needs to be capable to adjusting this production on the fly
  // In the case of melvor, it needs to handle
  // - producing multiple resources
  // - producing additional resources based on gloves
  // Maybe we don't need a resource producer class. Just something that can
  // handle a timer? Timer that takes in a timestamp and then returns
  // the number of elements produced for the given time cycle?

  final int
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
}