import 'package:incremental_increment/game/engine/unit/resource_unit.dart';
import 'package:incremental_increment/game/engine/util/number.dart';

class WorldNumber extends ResourceUnit {
  WorldNumber({startingNumber = Number.ten}) {
    value = startingNumber;
  }
}