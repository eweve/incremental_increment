import 'package:incremental_increment/game/engine/unit/producer_unit.dart';
import 'package:incremental_increment/game/engine/util/time_unit.dart';

class ResourceProducer extends ProducerUnit {
  final Function(int) callback;
  final double cyclePeriod;
  final List<double Function()> summedDurationModifiers;

  double _timestamp = 0;

  ResourceProducer(this.callback, this.cyclePeriod, this.summedDurationModifiers);

  double modifier() {
    double finalModifier = 1;
    for (Function mod in summedDurationModifiers) {
      finalModifier += mod();
    }
    return finalModifier;
  }

  double get modifiedCyclePeriod => cyclePeriod * modifier();
  double get currentPercentProgress => _timestamp / modifiedCyclePeriod;

  @override
  void reset() {
    _timestamp = 0;
    super.reset();
  }

  @override
  void unitTick(TimeUnit timeUnit) {
    _timestamp += timeUnit.deltaEpoch;
    if (_timestamp > modifiedCyclePeriod) {
      int cyclesPassed = _timestamp ~/ modifiedCyclePeriod;
      _timestamp = _timestamp % modifiedCyclePeriod;
      callback(cyclesPassed);
    }
  }
}