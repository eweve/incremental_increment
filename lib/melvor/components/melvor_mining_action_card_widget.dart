import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MelvorMiningActionCardWidget extends StatefulWidget {
  final String resourceName;

  const MelvorMiningActionCardWidget({Key? key, required this.resourceName}) : super(key: key);

  @override
  State<MelvorMiningActionCardWidget> createState() => _MelvorMiningActionCardWidgetState();
}

class _MelvorMiningActionCardWidgetState extends State<MelvorMiningActionCardWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.addListener(() { setState(() {}); });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SvgPicture svg = SvgPicture.asset(
      'lib/melvor/assets/rock.svg',
      fit: BoxFit.fitWidth,
      width: 50, height: 50,
    );
    return Card(
        child: InkWell(
          onTap: () {
            if (_controller.isAnimating) {
              _controller.reset();
            } else {
              _controller.repeat();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 100,
              // height: 200,
              child: Center(
                  child:Column(
                      children: [
                        (_controller.isAnimating) ? _rowText("Mining") : _rowText("Mine"),
                        _rowText(widget.resourceName),
                        _rowText("Ore"),
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: svg
                        ),
                        LinearPercentIndicator(
                          lineHeight: 20.0,
                          animateFromLastPercent: true,
                          percent: _controller.value,
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

  Widget _rowText(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ Text(text) ]
    );
  }
}

