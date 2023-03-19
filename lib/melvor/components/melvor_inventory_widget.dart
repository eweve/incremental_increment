import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incremental_increment/melvor/bloc/melvor_inventory_bloc.dart';
import 'package:incremental_increment/melvor/game_logic/item.dart';

class MelvorInventoryWidget extends StatelessWidget {
  const MelvorInventoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MelvorInventoryBloc, MelvorInventoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      // TODO: Put the items in the slots and put numbers in there.
                      for (int i = 0; i < state.bankSlots; i++)
                        (i < state.bank.length) ? _createInventorySlot(item: state.bank[i]) : _createInventorySlot()
                    ],
                  )
              )
          );
        }
    );
  }

  Widget _createInventorySlot({
    double itemWidth = 40,
    double itemHeight = 40,
    MelvorItemState? item,
  }) {
    Widget slotContainer = _createSlotContainer(itemHeight: itemHeight, itemWidth: itemWidth, randomIcon: false);
    return Stack(
      children: [
        slotContainer,
        Positioned(
          top: 0,
          left: 0,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              (item != null) ? item.type.resourceName : "",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 7
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              (item != null) ? item.value.toIntString() : "",
              style: const TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
  Container _createSlotContainer({
    double itemWidth = 40,
    double itemHeight = 40,
    bool randomIcon = true,
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
