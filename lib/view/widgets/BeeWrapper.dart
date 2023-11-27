import 'package:flutter/material.dart';

class BeeWrapper extends StatefulWidget {
  final Widget child;

  const BeeWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _BeeWrapperState createState() => _BeeWrapperState();
}

class _BeeWrapperState extends State<BeeWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  Offset _currentPosition = const Offset(0, 0);
  Offset _targetPosition = const Offset(0, 0);
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _animation = Tween<Offset>(
      begin: _currentPosition,
      end: _targetPosition,
    ).animate(_controller);

    _controller.addListener(() {
      setState(() {
        _currentPosition = _animation.value;
      });
    });
  }

  void onPointerDown(PointerEvent details) {
    setState(() {
      _targetPosition = details.localPosition;
      _isFlipped = _targetPosition.dx > _currentPosition.dx;

      _animation = Tween<Offset>(
        begin: _currentPosition,
        end: _targetPosition,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );

      _controller.forward(from: 0.0);
    });
  }

  void onPointerMove(PointerEvent details) {
    setState(() {
      _currentPosition = details.localPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: onPointerDown,
      onPointerMove: onPointerMove,
      child: Stack(
        children: <Widget>[
          widget.child,
          Positioned(
            left: _currentPosition.dx,
            top: _currentPosition.dy,
            child: Transform(
              transform: Matrix4.identity()
                ..scale(_isFlipped ? -1.0 : 1.0, 1.0),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/bee_icon.png',
                width: 50,
                height: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
