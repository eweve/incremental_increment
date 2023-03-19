import 'package:incremental_increment/game/engine/util/number.dart';
import 'package:incremental_increment/melvor/game_logic/item.dart';

class InventoryManager {
  final Map<MelvorItemType, MelvorItem> bank = {};
  final int bankSize = 10;

  bool get isBankFull => bank.keys.length == bankSize;

  bool add(MelvorItemType itemType, Number amount) {
    if (isBankFull) {
      return false;
    }
    bank.putIfAbsent(itemType, () => MelvorItem(resource: itemType));
    bank[itemType]?.accumulate(amount);
    return true;
  }

  bool remove(MelvorItemType itemType, Number amount) {
    if (!bank.containsKey(itemType) || bank[itemType]!.value < amount) {
      return false;
    }
    bank[itemType]?.decrease(amount);
    return true;
  }
}