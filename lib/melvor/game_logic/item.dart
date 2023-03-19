import 'package:incremental_increment/game/engine/unit/resource_unit.dart';
import 'package:meta/meta.dart';

class MelvorItem extends ResourceUnit {
  final MelvorItemType resource;

  MelvorItem({required this.resource});
}

@immutable
class MelvorItemAction {
  final MelvorItemType resource;
  final int amount;

  const MelvorItemAction(this.resource, this.amount);
}

enum MelvorItemType {
  copperOre(1, "Copper Ore"),
  tinOre(2, "Tin Ore"),
  ironOre(3, "Iron Ore"),
  coal(4, "Coal");

  const MelvorItemType(this.resourceId, this.resourceName);
  final int resourceId;
  final String resourceName;

  @override
  String toString() => 'MelvorItemType($resourceId, $resourceName)';
}

