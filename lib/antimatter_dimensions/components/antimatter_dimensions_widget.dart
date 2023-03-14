import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incremental_increment/antimatter_dimensions/bloc/adi_bloc.dart';
import 'package:incremental_increment/antimatter_dimensions/bloc/adi_bloc_event.dart';
import 'package:incremental_increment/antimatter_dimensions/bloc/adi_bloc_state.dart';

class AntimatterDimensionsApp extends StatelessWidget {
  const AntimatterDimensionsApp({super.key});

  String _formatDimension(AntimatterDimensionsState state, int dimension) {
    return "Antimatter Dimension ${dimension + 1} "
        "x${state.incrementers[dimension].modifier.toString()} "
        "${state.incrementers[dimension].incrementers.toString()}";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Idle',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
            create: (context) => AntimatterDimensionsBloc(),
            child: Scaffold(
                appBar: AppBar(
                  title: const Text("Antimatter Dimensions"),
                ),
                body: BlocConsumer<AntimatterDimensionsBloc, AntimatterDimensionsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ...[
                              Text(
                                state.worldNumber.toString(),
                                style: Theme.of(context).textTheme.displaySmall,
                              )
                            ],
                            for (int i = 0; i < state.incrementers.length; i++)
                              Row(
                                children: [
                                  Text(
                                    _formatDimension(state, i),
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  ),
                                  MaterialButton(
                                      onPressed: () => context.read<AntimatterDimensionsBloc>().add(BuyDimensionEvent(dimension: i)),
                                      child: Container(
                                        color: Colors.green,
                                        child: Text(
                                          'Cost: ${state.buyers[i].cost}',
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 13.0),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
                    }
                )
            )
        )
    );
  }
}