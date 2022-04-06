import 'package:flutter/material.dart';

class BlockFloatingButton extends StatelessWidget {
  bool isBlocked;
  VoidCallback? selectHandler;

  BlockFloatingButton({Key? key, this.isBlocked = false, this.selectHandler});

  Icon _getIcon() => isBlocked
      ? const Icon(Icons.run_circle_outlined)
      : const Icon(Icons.block);

  Color _getColor() => isBlocked ? Colors.red : Colors.black;

  String _getText() => isBlocked ? 'Blocked' : 'Not Blocked';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25),
      child: FloatingActionButton(
        onPressed: selectHandler,
        child: _getIcon(),
        backgroundColor: _getColor(),
        foregroundColor: Colors.white,
        tooltip: _getText(),
      ),
    );
  }
}
