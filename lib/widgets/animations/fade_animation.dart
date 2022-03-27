import 'dart:async';

import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  final Widget child;
  final AxisDirection from;
  final Duration duration;
  final int orderDelay;
  final int order;

  const FadeAnimation({
    Key? key,
    required this.child,
    this.from = AxisDirection.left,
    this.duration = const Duration(milliseconds: 700),
    this.orderDelay = 300,
    this.order = 1,
  }) : super(key: key);

  @override
  State<FadeAnimation> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _offsetController;
  late final Animation<Offset> _offsetAnimation;
  late final AnimationController _opacityController;
  late final Animation<double> _opacityAnimation;
  Timer? _timerStart;

  @override
  void initState() {
    _offsetController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    final Offset beginOffset;
    switch (widget.from) {
      case AxisDirection.up:
        beginOffset = const Offset(0, -1);
        break;
      case AxisDirection.right:
        beginOffset = const Offset(1, 0);
        break;
      case AxisDirection.down:
        beginOffset = const Offset(0, 1);
        break;
      case AxisDirection.left:
        beginOffset = const Offset(-1, 0);
        break;
    }
    _offsetAnimation = Tween<Offset>(begin: beginOffset, end: Offset.zero)
        .animate(_offsetController)
      ..addListener(() {
        setState(() {});
      });
    _opacityController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_opacityController)
          ..addListener(() {
            setState(() {});
          });
    if (widget.order < 2) {
      _offsetController.forward();
      _opacityController.forward();
    } else {
      _timerStart = Timer(
          widget.duration +
              Duration(milliseconds: widget.orderDelay * (widget.order - 2)),
          () {
        _offsetController.forward();
        _opacityController.forward();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _offsetController.dispose();
    _opacityController.dispose();
    _timerStart?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: AnimatedOpacity(
        duration: widget.duration,
        opacity: _opacityAnimation.value,
        child: widget.child,
      ),
    );
  }
}
