import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:incremental_increment/antimatter_dimensions/game_logic/world_state.dart';

import 'adi_bloc_event.dart';
import 'adi_bloc_state.dart';

class AntimatterDimensionsBloc extends Bloc<AntimatterDimensionsBlocEvent, AntimatterDimensionsState> {
  final WorldState worldState = WorldState();
  StreamSubscription? _timerSubscription;

  AntimatterDimensionsBloc() : super(AntimatterDimensionsState.from(WorldState())) {
    _registerTickEventHandler();
    _registerBuyDimensionEventHandler();

    _timerSubscription = Stream.periodic(const Duration(milliseconds: 100)).listen((_) {
      add(const TickEvent());
    });
  }

  void _registerTickEventHandler() {
    on<TickEvent>((event, emit) {
      worldState.tick();
      emit(AntimatterDimensionsState.from(worldState));
    });
  }

  void _registerBuyDimensionEventHandler() {
    on<BuyDimensionEvent>((event, emit) {
      worldState.incrementerBuyers[event.dimension].buyUpgrade();
      emit(AntimatterDimensionsState.from(worldState));
    });
  }

  @override
  Future<void> close() {
    _timerSubscription?.cancel();
    return super.close();
  }
}
