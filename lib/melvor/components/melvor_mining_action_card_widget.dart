import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:incremental_increment/melvor/bloc/melvor_mining_bloc.dart';
import 'package:incremental_increment/melvor/game_logic/mining_manager.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MelvorMiningActionCardWidget extends StatelessWidget {
  final MiningResource resource;

  const MelvorMiningActionCardWidget({Key? key, required this.resource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SvgPicture svg = SvgPicture.asset(
      'lib/melvor/assets/rock.svg',
      fit: BoxFit.fitWidth,
      width: 50, height: 50,
    );
    return BlocConsumer<MelvorMiningBloc, MelvorMiningState>(
        listener: (context, state) {},
        builder: (context, state) {
          bool cardIsActive = (state.activeResource == resource);
          return Card(
              child: InkWell(
                onTap: () {
                  context
                      .read<MelvorMiningBloc>()
                      .add(ToggleMiningResourceEvent(resource: resource));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 100,
                    // height: 200,
                    child: Center(
                        child:Column(
                            children: [
                              cardIsActive ? _rowText("Mining") : _rowText("Mine"),
                              _rowText(resource.name),
                              _rowText("Ore"),
                              Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: svg
                              ),
                              LinearPercentIndicator(
                                lineHeight: 20.0,
                                percent: cardIsActive ? state.miningProgressPercent : 0,
                                barRadius: const Radius.circular(3),
                                progressColor: Colors.brown,
                              ),
                            ]
                        )
                    ),
                  ),
                ),
              )
          );
        }
    );
  }

  Widget _rowText(String text) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ Text(text) ]
    );
  }
}

