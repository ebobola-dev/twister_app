import 'package:flutter/material.dart';
import 'package:twister_app/widgets/animations/fade_animation.dart';
import 'package:twister_app/widgets/header/change_theme_button.dart';

class SimpleHeader extends StatelessWidget {
  final Widget? title;
  final Widget? leading;
  final Duration fadeDuration;
  const SimpleHeader({
    Key? key,
    this.title,
    this.leading,
    this.fadeDuration = const Duration(milliseconds: 700),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      from: AxisDirection.up,
      duration: fadeDuration,
      child: AppBar(
        leading: leading != null
            ? FadeAnimation(
                child: leading!,
                from: AxisDirection.left,
                order: 2,
                duration: fadeDuration,
              )
            : null,
        title: title != null
            ? FadeAnimation(
                child: title!,
                from: AxisDirection.up,
                order: 2,
                duration: fadeDuration,
              )
            : null,
        actions: [
          FadeAnimation(
            duration: fadeDuration,
            from: AxisDirection.right,
            order: 2,
            child: const ChangeThemeButton(),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
