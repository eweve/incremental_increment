import '../../antimatter_dimensions/game_logic/incrementer.dart';
import '../../game/engine/unit/abstract_unit.dart';
import '../../game/engine/unit/producer_unit.dart';
import '../../game/engine/util/number.dart';
import '../../game/engine/util/time_unit.dart';

class MiningManager extends ProducerUnit {
  static final List<MiningResource> resources = [
    MiningResource.copperNode,
    MiningResource.tinNode,
    MiningResource.ironNode,
    MiningResource.coalNode
  ];
  final Map<MiningResource, bool> miningStatus = {
    for (var e in resources) e : false
  };

  // @override
  // void unitTick(TimeUnit timeUnit) {
  //   produce(this, timeUnit, modifier());
  // }
}

enum MiningResource {
  copperNode, tinNode, ironNode, coalNode,
}