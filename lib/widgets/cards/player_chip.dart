import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlayerChip extends StatelessWidget {
  final String player;
  final Function(String)? onDelete;
  final Color? deleteColor;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  const PlayerChip({
    Key? key,
    required this.player,
    this.onDelete,
    this.deleteColor,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(5.0),
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        color: backgroundColor ?? Theme.of(context).chipTheme.backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(player),
            ),
          ),
          if (onDelete != null) ...[
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () => onDelete!(player),
              child: FaIcon(
                FontAwesomeIcons.circleMinus,
                color: deleteColor,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
