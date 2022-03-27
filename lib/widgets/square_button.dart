import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? splashColor;
  const SquareButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.backgroundColor,
    this.splashColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor ?? Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(7.0),
            ),
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
          Material(
            borderRadius: BorderRadius.circular(7.0),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(7.0),
              splashColor: splashColor ?? Colors.white.withOpacity(.3),
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
