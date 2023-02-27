import 'package:flutter/material.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/provider/MapProvider.dart';
import 'package:park_spot/view/home.dart';

import 'package:park_spot/view/userpage/park_now.dart';
import 'package:park_spot/view/userpage/park_table.dart';
import 'package:provider/provider.dart';

class ParkingHome extends StatefulWidget {
  const ParkingHome({Key? key}) : super(key: key);

  @override
  State<ParkingHome> createState() => _ParkingHomeState();
}

class _ParkingHomeState extends State<ParkingHome> {
  final List<Widget> _pages = [ParkNow(), ParkingTable()];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    mapProvider = Provider.of<MapProvider>(context);

    return Scaffold(
      body: mapProvider!.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            )
          : _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryColor,
        onTap: (selectedIndex) {
          setState(() {
            _index = selectedIndex;
          });
        },
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
                color: kPrimaryColor,
              ),
              label: 'Parking Maps'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.local_parking,
                color: kPrimaryColor,
              ),
              label: 'Parking Table'),
        ],
      ),
    );
  }
}
