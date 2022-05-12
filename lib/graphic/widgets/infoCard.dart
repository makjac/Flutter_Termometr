import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  int value;
  String label;

  InfoCard({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Card(
        margin: const EdgeInsets.only(top: 10),
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
              child: Text(
                '$value',
                style: const TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
