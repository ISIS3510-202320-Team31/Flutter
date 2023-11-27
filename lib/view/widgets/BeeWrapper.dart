import 'package:flutter/material.dart';

class BeeWrapper extends StatefulWidget {
  final Widget child;

  const BeeWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _BeeWrapperState createState() => _BeeWrapperState();
}

class _BeeWrapperState extends State<BeeWrapper> {
  Offset position = const Offset(0, 0);

  void updatePosition(PointerEvent details) {
    setState(() {
      position = details.localPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: updatePosition,
      onPointerMove: updatePosition,
      child: Stack(
        children: <Widget>[
          widget.child,
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Image.asset(
              'assets/images/bee_icon.png',
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
