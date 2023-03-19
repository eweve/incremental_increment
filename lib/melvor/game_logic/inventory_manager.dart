import 'package:incremental_increment/game/engine/util/number.dart';
import 'package:incremental_increment/melvor/game_logic/item.dart';

class InventoryManager {
  final Map<MelvorItemType, MelvorItem> bank = {};
  final int bankSize = 10;

  bool get isBankFull => bank.keys.length == bankSize;

  // Jank: list order matters. First invalid action cancels the rest.
  // TODO: Code a better inventory system.
  bool handleTransaction(List<MelvorItemAction> actions) {
    for (int i = 0; i < actions.length; i++) {
      if (!handleAction(actions[i])) {
        return false;
      }
    }
    return true;
  }

  bool contains(MelvorItemType itemType, Number amount) {
    return bank.containsKey(itemType) && bank[itemType]!.value < amount;
  }

  bool handleAction(MelvorItemAction action) {
    if (action.amount > 0) {
      return add(action.resource, Number.from(action.amount));
    } else {
      return remove(action.resource, Number.from(action.amount));
    }
  }

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