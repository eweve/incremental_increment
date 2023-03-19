import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:incremental_increment/game/engine/util/number.dart';
import 'package:incremental_increment/melvor/game_logic/item.dart';
import 'package:incremental_increment/melvor/game_logic/world_state.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MelvorInventoryEvent {
  const MelvorInventoryEvent();
}

@immutable
class InventoryUpdateEvent extends MelvorInventoryEvent {
  const InventoryUpdateEvent();
}

@immutable
class MelvorItemState extends Equatable {
  final MelvorItemType type;
  final Number value;

  factory MelvorItemState.from(MelvorItem item) {
    return MelvorItemState(
        type: item.resource,
        value: item.value,
    );
  }

  const MelvorItemState({required this.type, required this.value});

  @override
  List<Object> get props => [type, value];
}

@immutable
class MelvorInventoryState extends Equatable {
  final List<MelvorItemState> bank;
  final int bankSlots;

  factory MelvorInventoryState.from(WorldState worldState) {
    return MelvorInventoryState(
        bank: worldState.inventoryManager.bank.values
            .map((e) => MelvorItemState.from(e))
            .toList(),
        bankSlots: worldState.inventoryManager.bankSize
    );
  }

  const MelvorInventoryState({required this.bankSlots, required this.bank});

  @override
  List<Object> get props => [bankSlots, bank];
}

class MelvorInventoryBloc extends Bloc<MelvorInventoryEvent, MelvorInventoryState> {
  final WorldState worldState;
  late final StreamSubscription tickListener;

  MelvorInventoryBloc({
    required this.worldState
  }) : super(MelvorInventoryState.from(worldState)) {
    tickListener = worldState.tickEventStream.stream.listen((event) {
        add(const InventoryUpdateEvent());
    });

    on<InventoryUpdateEvent>((event, emit) {
      emit(MelvorInventoryState.from(worldState));
    });
  }
}
