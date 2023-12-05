import 'package:flutter/material.dart';
import 'package:hive_app/utils/Cache.dart';

class BeeWrapper extends StatefulWidget {
  final Widget Function(void Function()) childBuilder;

  const BeeWrapper({Key? key, required this.childBuilder}) : super(key: key);

  @override
  _BeeWrapperState createState() => _BeeWrapperState();
}

class _BeeWrapperState extends State<BeeWrapper>
    with SingleTickerProviderStateMixin {
  final double beeSize = 50.0;

  late AnimationController _controller;
  late Animation<Offset> _animation;
  Offset _currentPosition = const Offset(0, 0);
  Offset _targetPosition = const Offset(0, 0);
  bool _isFlipped = false;
  bool _followFinger = false;

  void toogleBeeFollowing() {
    setState(() {
      _followFinger = !_followFinger;
      cache.write('bee-followfinger', _followFinger);
    });
  }

  @override
  void initState() {
    super.initState();

    double beeX = cache.read('bee-x') ?? 0;
    double beeY = cache.read('bee-y') ?? 0;
    bool beeIsFlipped = cache.read('bee-isflipped') ?? false;
    bool beeFollowFinger = cache.read('bee-followfinger') ?? false;
    setState(() {
      _currentPosition = Offset(beeX, beeY);
      _isFlipped = beeIsFlipped;
      _followFinger = beeFollowFinger;
    });

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
      _targetPosition =
          details.localPosition - Offset(beeSize / 2, beeSize / 2);
      _isFlipped = _targetPosition.dx > _currentPosition.dx;

      cache.write('bee-x', _targetPosition.dx);
      cache.write('bee-y', _targetPosition.dy);
      cache.write('bee-isflipped', _isFlipped);

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
      _currentPosition =
          details.localPosition - Offset(beeSize / 2, beeSize / 2);

      cache.write('bee-x', _currentPosition.dx);
      cache.write('bee-y', _currentPosition.dy);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _followFinger ? onPointerDown : null,
      onPointerMove: _followFinger ? onPointerMove : null,
      child: Stack(
        children: <Widget>[
          widget.childBuilder(toogleBeeFollowing),
          _followFinger
              ? Positioned(
                  left: _currentPosition.dx,
                  top: _currentPosition.dy,
                  child: IgnorePointer(
                    child: Transform(
                      transform: Matrix4.identity()
                        ..scale(_isFlipped ? -1.0 : 1.0, 1.0),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/bee_icon.png',
                        width: beeSize,
                        height: beeSize,
                      ),
                    ),
                  ),
                )
              : Container(),
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
