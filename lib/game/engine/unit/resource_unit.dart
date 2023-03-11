import 'package:incremental_increment/game/engine/unit/abstract_unit.dart';
import 'package:incremental_increment/game/engine/util/number.dart';

class ResourceUnit extends AbstractUnit {
  ResourceUnit() {
    init();
  }

  void accumulate(Number amount) {
      value += amount;
  }

  void decrease(Number amount) {
    assert(amount.isNonNegative());
    return accumulate(-amount);
  }
}