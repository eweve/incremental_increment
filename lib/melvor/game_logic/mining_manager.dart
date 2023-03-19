import 'package:incremental_increment/game/engine/unit/ticker_unit.dart';
import 'package:incremental_increment/game/engine/util/time_unit.dart';
import 'package:incremental_increment/melvor/game_logic/item.dart';
import 'package:incremental_increment/melvor/game_logic/resource_producer.dart';

class MiningManager extends TickerUnit {
  late final Map<MiningResource, ResourceProducer> producers;

  final void Function(List<MelvorItemAction>) inventoryFunction;

  MiningResource _activeResource = MiningResource.inactive;

  MiningManager({required this.inventoryFunction}) {
    producers = {
      for (var e in MiningResource.values)
        e : ResourceProducer(handleProduction, e.cyclePeriod, [])
    };
  }

  bool get isActive => _activeResource != MiningResource.inactive;
  MiningResource get activeResource => _activeResource;
  double get percentProgress => producers[activeResource]!.currentPercentProgress;

  @override
  void unitTick(TimeUnit timeUnit) {
    if (_activeResource != MiningResource.inactive) {
      producers[_activeResource]!.tick(timeUnit);
    }
  }

  void toggleProduction(MiningResource resource) {
    if (_activeResource == MiningResource.inactive) {
      _activeResource = resource;
    } else if (_activeResource == resource) {
      producers[_activeResource]!.reset();
      _activeResource = MiningResource.inactive;
    }
  }

  void handleProduction(int resourcesProduced) {
    List<MelvorItemAction> actions = _activeResource.produces;
    List<MelvorItemAction> finalActions = actions
        .map((e) => MelvorItemAction(e.resource, e.amount * resourcesProduced))
        .toList();
    inventoryFunction(finalActions);
  }
}

enum MiningResource {
  inactive(100, []),
  copperNode(1, [MelvorItemAction(MelvorItemType.copperOre, 1)]),
  tinNode(1, [MelvorItemAction(MelvorItemType.tinOre, 1)]),
  ironNode(2, [MelvorItemAction(MelvorItemType.ironOre, 1)]),
  coalNode(.5, [MelvorItemAction(MelvorItemType.coal, 1)]);

  final double cyclePeriod;
  final List<MelvorItemAction> produces;

  const MiningResource(this.cyclePeriod, this.produces);
}