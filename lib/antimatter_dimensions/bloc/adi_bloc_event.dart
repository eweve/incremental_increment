import 'package:meta/meta.dart';

@immutable
abstract class AntimatterDimensionsBlocEvent {
  const AntimatterDimensionsBlocEvent();
}

@immutable
class TickEvent extends AntimatterDimensionsBlocEvent {
  const TickEvent();
}

@immutable
class BuyDimensionEvent extends AntimatterDimensionsBlocEvent {
  final int dimension;
  const BuyDimensionEvent({required this.dimension});
}