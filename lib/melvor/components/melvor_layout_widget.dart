import 'package:flutter/material.dart';
import 'package:incremental_increment/melvor/components/melvor_inventory_widget.dart';
import 'package:incremental_increment/melvor/components/melvor_mining_widget.dart';

class MelvorLayoutWidget extends StatefulWidget {
  const MelvorLayoutWidget({super.key});

  @override
  State<MelvorLayoutWidget> createState() => _MelvorLayoutWidget();
}

class _MelvorLayoutWidget extends State<MelvorLayoutWidget> {
  var selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const Placeholder();
        break;
      case 1:
        page = const MelvorInventoryWidget();
        break;
      case 2:
        page = const MelvorMiningWidget();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Center(
      child: LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              body: Row(
                children: [
                  SafeArea(
                    child: NavigationRail(
                      extended: constraints.maxWidth >= 600,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home_outlined),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.business_center_outlined),
                          label: Text('Inventory'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.diamond_outlined),
                          label: Text('Mining'),
                        ),
                      ],
                      selectedIndex: selectedIndex,
                      onDestinationSelected: (value) {
                        setState(() {
                          selectedIndex = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primaryContainer,
                      alignment: Alignment.topCenter,
                      child: page,
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}