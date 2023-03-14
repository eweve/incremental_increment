import 'package:incremental_increment/game/engine/util/number.dart';
import 'package:incremental_increment/antimatter_dimensions/game_logic/incrementer.dart';

import '../../game/engine/unit/resource_unit.dart';

class IncrementerBuyer {
  final int _dimension;
  final ResourceUnit bank;
  final Incrementer incrementer;

  var dimCostExp = [1, 2, 3, 5, 8, 13, 21, 34];
  var dimCostMulExp = [3, 4, 5, 7, 10, 15, 23, 36];

  IncrementerBuyer(this.bank, this.incrementer, this._dimension);

  Number get _baseCost => Number.number(1, dimCostExp[dimension]);
  Number get _costMultiplier => Number.number(1, dimCostMulExp[dimension]);
  Number get _costMultiplierStage => Number.from(incrementer.value.exponent);
  Number get cost => _baseCost * _costMultiplier.power(_costMultiplierStage);

  int get dimension => _dimension;

  bool buyUpgrade() {
    if (bank.value.compareTo(cost) < 0) {
      return false;
    }
    bank.decrease(cost);
    incrementer.incrementers.accumulate(Number.one);
    incrementer.purchasedIncrementers.accumulate(Number.one);
    return true;
  }
}