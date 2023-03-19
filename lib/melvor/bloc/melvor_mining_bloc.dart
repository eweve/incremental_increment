import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:incremental_increment/melvor/game_logic/mining_manager.dart';
import 'package:incremental_increment/melvor/game_logic/world_state.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MelvorMiningEvent {
  const MelvorMiningEvent();
}

@immutable
class MiningUpdateEvent extends MelvorMiningEvent {
  const MiningUpdateEvent();
}

@immutable
class ToggleMiningResourceEvent extends MelvorMiningEvent {
  final MiningResource resource;
  const ToggleMiningResourceEvent({required this.resource});
}

@immutable
class MelvorMiningState extends Equatable {
  final MiningResource activeResource;
  final double miningProgressPercent;

  factory MelvorMiningState.from(WorldState worldState) {
    return MelvorMiningState(
        activeResource: worldState.miningManager.activeResource,
        miningProgressPercent: worldState.miningManager.percentProgress);
  }

  const MelvorMiningState({
    required this.activeResource,
    required this.miningProgressPercent,
  });

  @override
  List<Object> get props => [activeResource, miningProgressPercent];
}

class MelvorMiningBloc extends Bloc<MelvorMiningEvent, MelvorMiningState> {
  final WorldState worldState;
  late final StreamSubscription tickListener;

  MelvorMiningBloc({
    required this.worldState
  }) : super(MelvorMiningState.from(worldState)) {
    tickListener = worldState.tickEventStream.stream.listen((event) {
      // print("Listening to $event and emitting MiningUpdateEvent");
      add(const MiningUpdateEvent());
    });

    _registerUpdateEventHandler();
    _registerToggleMiningResource();
  }
  void _registerUpdateEventHandler() {
    on<MiningUpdateEvent>((event, emit) {
      emit(MelvorMiningState.from(worldState));
    });
  }

  void _registerToggleMiningResource() {
    on<ToggleMiningResourceEvent>((event, emit) {
      worldState.miningManager.toggleProduction(event.resource);
      emit(MelvorMiningState.from(worldState));
    });
  }
}
