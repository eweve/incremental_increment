import 'package:flutter/material.dart';
import 'dart:math';

class MelvorInventoryWidget extends StatelessWidget {
  final int slotCount;

  const MelvorInventoryWidget({super.key, this.slotCount = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (int i = 0; i < slotCount; i++)
                  _createInventorySlot()
              ],
            )
        )
    );
  }

  Container _createInventorySlot({
    double itemWidth = 40,
    double itemHeight = 40,
    randomIcon = true
  }) {
    if (randomIcon) {
      return Container(
        width: itemWidth,
        height: itemHeight,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(_getRandomIcon()),
      );
    } else {
      return Container(
        width: itemWidth,
        height: itemHeight,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }
  }

  static IconData _getRandomIcon() {
    final List<IconData> icons = [
      Icons.star,
      Icons.favorite,
      Icons.camera,
      Icons.flight,
      Icons.book,
      Icons.music_note,
      Icons.movie,
      Icons.directions_bike,
      Icons.watch,
    ];
    final Random random = Random();
    return icons[random.nextInt(icons.length)];
  }
}
