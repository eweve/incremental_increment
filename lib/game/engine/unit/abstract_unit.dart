import 'package:incremental_increment/game/engine/util/number.dart';
import 'package:meta/meta.dart';

abstract class AbstractUnit {
  static int _counter = 0;

  late final String id;

  @protected bool isInitialized = false;
  bool get initialized => isInitialized;

  Number value = Number.zero;

  AbstractUnit() {
    id = '${runtimeType.toString()}.${++_counter}';
  }

  void unitInit() {  }

  Number init() {
    if (!isInitialized) {
      unitInit();
      isInitialized = true;
    }
    return value;
  }

  bool setIsInitialized(bool isInitialized) {
    this.isInitialized = isInitialized;
    return this.isInitialized;
  }

  void reset() {
    value = Number.zero;
  }

  void transfer(AbstractUnit unit) {
    value = unit.value;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is AbstractUnit) {
      return id == other.id;
    }
    return false;
  }
}
