///=============================================================================
///Name:      main.dart
///Author:    Maksymilian Jackowski
///Created:   12.05.2022
///=============================================================================

import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  int value;
  String label;
  String unit;

  InfoCard({
    Key? key,
    required this.label,
    required this.value,
    required this.unit,
  }) : super(key: key);

  //TODO: dodać cyfry po przecinku!!!
  String shortNum(int value) {
    const units = <int, String>{
      1000000000: 'B',
      1000000: 'M',
      1000: 'K',
    };
    return units.entries
        .map((e) => '${value ~/ e.key}${e.value}')
        .firstWhere((e) => !e.startsWith('0'), orElse: () => '$value');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Card(
        margin: const EdgeInsets.only(top: 20),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromARGB(87, 255, 255, 255),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Text(
                label,
                style: const TextStyle(fontSize: 25),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Card(
                    color: const Color.fromARGB(85, 41, 41, 41),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: Text(
                        shortNum(value),
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  Text(
                    unit,
                    style: const TextStyle(fontSize: 30),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
