import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twister_app/models/move/move.dart';
import 'package:twister_app/models/move/move_enums.dart';

class MoveCard extends StatelessWidget {
  final Move move;
  final double bottomMargin;
  const MoveCard({Key? key, required this.move, this.bottomMargin = 10.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        key: const ValueKey(1),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Text(
              move.player,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          const FaIcon(
            FontAwesomeIcons.rightLong,
          ),
          Flexible(
            child: RichText(
              textAlign: TextAlign.end,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${translateParts[move.part]![2]} ",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  TextSpan(
                    text: translateColors[move.color]!.toLowerCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: move.color,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
