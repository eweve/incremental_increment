import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:incremental_increment/antimatter_dimensions/game_logic/incrementer.dart';
import 'package:incremental_increment/antimatter_dimensions/game_logic/incrementer_buyer.dart';
import 'package:incremental_increment/antimatter_dimensions/game_logic/world_state.dart';
import 'package:incremental_increment/game/engine/util/number.dart';

@immutable
class AntimatterDimensionsState extends Equatable {
  final Number worldNumber;
  final List<IncrementerState> incrementers;
  final List<IncrementerBuyerState> buyers;

  factory AntimatterDimensionsState.from(WorldState worldState) {
    List<IncrementerState> incrementers = worldState
        .incrementers
        .map(IncrementerState.from).toList();
    List<IncrementerBuyerState> buyers = worldState
        .incrementerBuyers
        .map(IncrementerBuyerState.from).toList();
    return AntimatterDimensionsState(
        worldNumber: worldState.worldNumber.value,
        incrementers: incrementers,
        buyers: buyers);
  }

  const AntimatterDimensionsState({
    required this.worldNumber,
    required this.incrementers,
    required this.buyers,

  });

  @override
  List<Object> get props => [worldNumber, incrementers, buyers];
}

@immutable
class IncrementerState extends Equatable {
  final int dimension;
  final Number purchasedIncrementers;
  final Number incrementers;
  final Number modifier;

  factory IncrementerState.from(Incrementer incrementer) {
      return IncrementerState(
          dimension: incrementer.dimension,
          purchasedIncrementers: incrementer.purchasedIncrementers.value,
          incrementers: incrementer.incrementers.value,
          modifier: incrementer.modifier());
  }

  const IncrementerState({
    required this.dimension,
    required this.purchasedIncrementers,
    required this.incrementers,
    required this.modifier,
  });

  @override
  List<Object> get props => [dimension, purchasedIncrementers, incrementers, modifier];
}

@immutable
class IncrementerBuyerState extends Equatable {
  final int index;
  final Number cost;

  factory IncrementerBuyerState.from(IncrementerBuyer buyer) {
    return IncrementerBuyerState(index: buyer.dimension, cost: buyer.cost);
  }

  const IncrementerBuyerState({
    required this.index,
    required this.cost,
  });

  @override
  List<Object> get props => [index, cost];
}